import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final Color color;
  final String title;
  final double widthRatio;

  ColorContainer({this.color, this.title, this.widthRatio});

  @override
  Widget build(BuildContext context) {
    print('widthRatio = $widthRatio');

    String volumeLabel = title + ' gal';

    return Container(
      color: color,
      height: 38.0,
      width: widthRatio * 300.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          volumeLabel,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }
}
