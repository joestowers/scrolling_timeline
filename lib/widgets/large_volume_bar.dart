import 'package:flutter/material.dart';

class LargeVolumeBar extends StatelessWidget {
  final double widthRatio;
  final String volume;

  LargeVolumeBar({this.widthRatio, this.volume});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 24.0, maxWidth: 24.0),
            child: Placeholder(
              color: Colors.white,
              fallbackHeight: 20.0,
              fallbackWidth: 20.0,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  volume,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
