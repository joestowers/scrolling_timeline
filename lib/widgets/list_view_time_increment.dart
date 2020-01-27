import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../models/buoy_event.dart';
import '../models/volume.dart';
import '../utils/group_sort_utils.dart';
import 'volume_bars.dart';

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
          0.0, (previous, event) => math.max(previous, event.volume.value));
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
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 36.0,
                width: 72.0,
                child: Text(
                  formatTime(date),
                ),
              ),
              if (eventsForHour != null)
                Expanded(
                  child: VolumeBars(
                    events: eventsForHour,
                    maxVolume: maxVolume,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
