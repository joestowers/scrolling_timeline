import 'package:flutter/material.dart';

class SmallVolumeBar extends StatelessWidget {
  final double widthRatio;
  final String volume;

  SmallVolumeBar({this.widthRatio, this.volume});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 24.0, maxWidth: 24.0),
            child: Placeholder(
              color: Colors.black,
              fallbackHeight: 20.0,
              fallbackWidth: 20.0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Text(
              volume,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
