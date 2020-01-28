import 'package:flutter/material.dart';
import 'package:scrolling_timeline/widgets/large_volume_bar.dart';

import 'small_volume_bar.dart';

/// VolumeBarContainer builds a Container with a
/// width representing the volume for each event.
///
/// If widthRatio is < 0.20 for a containerWidth of 300.0,
/// then display a SmallVolumeBar with volume label outside.
class VolumeBarContainer extends StatelessWidget {
  final String volume;
  final double widthRatio;

  final double barHeight = 36.0;
  final double maxBarWidth = 300.0;
  final Color buoyBlue = Color(0XFF2F71B3);

  VolumeBarContainer({this.volume, this.widthRatio});

  @override
  Widget build(BuildContext context) {
    if (widthRatio < 0.20) {
      return Row(
        children: <Widget>[
          Container(
            color: buoyBlue,
            height: barHeight,
            width: widthRatio * maxBarWidth,
          ),
          SmallVolumeBar(widthRatio: widthRatio, volume: volume),
        ],
      );
    }
    return Container(
      color: buoyBlue,
      height: barHeight,
      width: widthRatio * maxBarWidth,
      child: LargeVolumeBar(widthRatio: widthRatio, volume: volume),
    );
  }
}
