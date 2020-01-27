import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:scrolling_timeline/models/buoy_event.dart';
import 'package:scrolling_timeline/models/volume.dart';

class ListViewTimeline extends StatefulWidget {
  @override
  _ListViewTimelineState createState() => _ListViewTimelineState();
}

class _ListViewTimelineState extends State<ListViewTimeline> {
  final List<BuoyEvent> buoyEvents = [
    BuoyEvent(
        start: DateTime(2019, 1, 20, 12, 35, 27),
        volume: Volume(value: 36.3),
        category: BuoyCategory.gardenHose),
    BuoyEvent(
        start: DateTime(2019, 1, 20, 12, 15, 30),
        volume: Volume(value: 20.0),
        category: BuoyCategory.bath),
    BuoyEvent(
        start: DateTime(2019, 1, 20, 12, 17, 30),
        volume: Volume(value: 47.0),
        category: BuoyCategory.sink),
    BuoyEvent(
        start: DateTime(2019, 1, 20, 12, 35, 15),
        volume: Volume(value: 58.3),
        category: BuoyCategory.toilet),
  ];

  List<BuoyEventGroup> getGroups() {
    List<BuoyEventGroup> groups = [];

    BuoyEventGroup currentGroup;

    buoyEvents.sort((lhs, rhs) => rhs.start.compareTo(lhs.start));

    buoyEvents.forEach((event) {
      final start = event.start;

      final eventTime = DateTime(
        start.year,
        start.month,
        start.day,
        start.hour,
        start.minute,
      );

      if (currentGroup == null) {
        currentGroup = BuoyEventGroup(events: [], time: eventTime);
      }

      if (currentGroup.time == eventTime) {
        currentGroup.events.add(event);
      } else {
        groups.add(currentGroup);

        currentGroup = BuoyEventGroup(events: [event], time: eventTime);
      }
    });

    if (currentGroup != null && currentGroup.events.isNotEmpty) {
      groups.add(currentGroup);
    }

    return groups;
  }

  double getMaxVolume(List<BuoyEvent> events) {
    if (events == null || events.isEmpty) {
      return 0.0;
    } else {
      return events.fold(
          0, (previous, event) => math.max(previous, event.volume.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final groups = getGroups();

    final maxVolume = getMaxVolume(buoyEvents);
    print('maxVolume = $maxVolume');

    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (_, index) {
          final group = groups[index];
          final eventsByGroup = group.events;
          final time = group.time;

          //String eventContainer = eventsByGroup.map((e) => e.category.label).join(', ');
          List<ColorContainer> containerMap = eventsByGroup.map((event) {
            return ColorContainer(
              color: Color(0XFF2F71B3),
              title: event.volume.value.toString(),
              widthRatio: event.volume.value / maxVolume,
            );
          }).toList();

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 200.0,
                child: Center(
                  child: Text(time.toString()),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: containerMap,
              )
            ],
          );
        });

    // eventsByGroup.map((event) {
    //   return ListTile

    // })

    // return ListTile(
    //   leading: Text(time.toString()),
    //   title: Text(title),
    //   trailing: Text()
    // );
  }
}

class BuoyEventGroup {
  final List<BuoyEvent> events;
  final DateTime time;

  BuoyEventGroup({this.events, this.time});
}

extension CustomInterable on Iterable<double> {
  double get max => reduce(math.max);
}
