import 'package:flutter/material.dart';

import '../models/buoy_event.dart';
import 'color_container.dart';

class VolumeBars extends StatelessWidget {
  final List<BuoyEvent> events;
  final double maxVolume;

  VolumeBars({this.events, this.maxVolume});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final event in events)
            ColorContainer(
              color: Color(0XFF2F71B3),
              title: event.volume.value.round().toString(),
              widthRatio: event.volume.value / maxVolume,
            )
        ],
      ),
    );
  }
}
