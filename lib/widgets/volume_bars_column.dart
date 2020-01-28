import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../models/buoy_event.dart';
import 'volume_bar_container.dart';

class VolumeBarsColumn extends StatelessWidget {
  final List<BuoyEvent> events;
  final double maxVolume;

  VolumeBarsColumn({this.events, this.maxVolume});

  Future<void> _eventDialog(event, context) async {
    print('event = $event');
    final startDate = DateFormat('yMd').format(event.start);
    final startTime = DateFormat.jm().format(event.start);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Event Detail'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(event.category.toString()),
                Text('------------------------'),
                Text('$startDate $startTime'),
                Text('${event.volume.value.toString()} gal'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final event in events)
            GestureDetector(
              onTap: () {
                _eventDialog(event, context);
              },
              child: VolumeBarContainer(
                volume: event.volume.value.round().toString(),
                widthRatio: event.volume.value / maxVolume,
              ),
            ),
        ],
      ),
    );
  }
}
