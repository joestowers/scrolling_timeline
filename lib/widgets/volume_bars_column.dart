import 'package:flutter/material.dart';

import '../models/buoy_event.dart';
import 'volume_bar.dart';

class VolumeBarsColumn extends StatelessWidget {
  final List<BuoyEvent> events;
  final double maxVolume;

  VolumeBarsColumn({this.events, this.maxVolume});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final event in events)
            // GestureDetector(
            //   onTap: () {
            //     print('Event Time = ${event.start}');
            //   },
            VolumeBar(
              volume: event.volume.value.round().toString(),
              widthRatio: event.volume.value / maxVolume,
            ),
          //),
        ],
      ),
    );
  }
}
