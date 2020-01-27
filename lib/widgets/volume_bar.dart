import 'package:flutter/material.dart';
import 'package:scrolling_timeline/widgets/large_volume_bar.dart';

import 'small_volume_bar.dart';

class VolumeBar extends StatelessWidget {
  final String volume;
  final double widthRatio;

  VolumeBar({this.volume, this.widthRatio});

  /*
    If widthRatio is < 0.20 for containerWidth of 300.0,
    then display a volume bar with volume label outside.
  */

  @override
  Widget build(BuildContext context) {
    if (widthRatio < 0.20) {
      return Row(
        children: <Widget>[
          Container(
            color: Color(0XFF2F71B3),
            height: 36.0,
            width: widthRatio * 300.0,
          ),
          SmallVolumeBar(widthRatio: widthRatio, volume: volume),
        ],
      );
    }
    return Container(
      color: Color(0XFF2F71B3),
      height: 36.0,
      width: widthRatio * 300.0,
      child: LargeVolumeBar(widthRatio: widthRatio, volume: volume),
    );
  }
}
