import 'dart:collection';
import 'dart:math' as math;

import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter/material.dart';
import 'package:scrolling_timeline/models/buoy_event.dart';
import 'package:scrolling_timeline/models/volume.dart';
import 'package:scrolling_timeline/utils/group_sort_utils.dart';
import 'package:scrolling_timeline/widgets/color_container.dart';

class ListViewTimeIncrement extends StatefulWidget {
  @override
  _ListViewTimeIncrementState createState() => _ListViewTimeIncrementState();
}

class _ListViewTimeIncrementState extends State<ListViewTimeIncrement> {
  List<DateTime> dateTimeIncrementList = [];
  SplayTreeMap<int, List<BuoyEvent>> eventsGroupedByHour;
  double maxVolume = 0.0;

  @override
  initState() {
    super.initState();

    getDateTimeIncrementList();
  }

  @override
  void didChangeDependencies() {
    // mimic a call to get events here
    final List<BuoyEvent> buoyEvents = [
      BuoyEvent(
          start: DateTime(2019, 1, 20, 5, 18, 15),
          volume: Volume(value: 3.2),
          category: BuoyCategory.toilet),
      BuoyEvent(
          start: DateTime(2019, 1, 20, 12, 35, 27),
          volume: Volume(value: 36.3),
          category: BuoyCategory.gardenHose),
      BuoyEvent(
          start: DateTime(2019, 1, 20, 12, 15, 30),
          volume: Volume(value: 83.0),
          category: BuoyCategory.bath),
      BuoyEvent(
          start: DateTime(2019, 1, 20, 12, 17, 30),
          volume: Volume(value: 24.1),
          category: BuoyCategory.sink),
      BuoyEvent(
          start: DateTime(2019, 1, 20, 12, 35, 15),
          volume: Volume(value: 3.4),
          category: BuoyCategory.toilet),
      BuoyEvent(
          start: DateTime(2019, 1, 20, 18, 35, 15),
          volume: Volume(value: 3.3),
          category: BuoyCategory.toilet),
    ];

    eventsGroupedByHour = buoyEvents.groupedSortedListBy(
      groupByKey: (event) => event.start.hour,
      groupSort: (int lhs, int rhs) => rhs.compareTo(lhs),
      elementSort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
    );

    maxVolume = getMaxVolume(buoyEvents);

    super.didChangeDependencies();
  }

  double getMaxVolume(List<BuoyEvent> events) {
    if (events == null || events.isEmpty) {
      return 0.0;
    } else {
      return events.fold(
          0, (previous, event) => math.max(previous, event.volume.value));
    }
  }

  void getDateTimeIncrementList() {
    DateTime today = DateTime.now();

    DateTime current = DateTime(today.year, today.month, today.day);

    DateTime finalTime = current.add(Duration(hours: 24));

    while (current != finalTime) {
      dateTimeIncrementList.add(current);
      current = current.add(Duration(minutes: 60));
    }

    print(dateTimeIncrementList);
  }

  String formatTime(DateTime time) {
    String hour = DateFormat('h').format(time);
    String minute = DateFormat('mm').format(time);
    String label = time.hour < 12 ? 'am' : 'pm';
    return hour + ':' + minute + ' $label';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dateTimeIncrementList.length,
      itemBuilder: (_, index) {
        final date = dateTimeIncrementList[index];
        final hour = date.hour;

        final eventsForHour = eventsGroupedByHour[hour];

        return Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: 72, child: Text(formatTime(date))),
              if (eventsForHour != null)
                Expanded(
                    child: _VolumeBarWidgets(
                        events: eventsForHour, maxVolume: maxVolume))
              else
                Container(height: 36)
            ],
          ),
        );
      },
    );
  }
}

class _VolumeBarWidgets extends StatelessWidget {
  final List<BuoyEvent> events;
  final double maxVolume;

  _VolumeBarWidgets({this.events, this.maxVolume});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final event in events)
          ColorContainer(
            color: Color(0XFF2F71B3),
            title: event.volume.value.toString(),
            widthRatio: event.volume.value / maxVolume,
          )
      ],
    );
    // return ListView.builder(
    //   itemCount: events.length,
    //   itemBuilder: (_, index) {
    //     final eventVolume = events[index].volume.value;
    //     return ColorContainer(
    //       color: Color(0XFF2F71B3),
    //       title: eventVolume.toString(),
    //       widthRatio: eventVolume / maxVolume,
    //     );
    //   },
    // );
  }
}
