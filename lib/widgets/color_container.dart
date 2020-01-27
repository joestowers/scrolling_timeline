import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final Color color;
  final String title;
  final double widthRatio;

  ColorContainer({this.color, this.title, this.widthRatio});

  @override
  Widget build(BuildContext context) {
    //String volumeLabel = title + ' gal';

    return Container(
      color: color,
      height: 38.0,
      width: widthRatio * 300.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 24.0, maxWidth: 24.0),
            child: Placeholder(
              fallbackHeight: 10.0,
              fallbackWidth: 20.0,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
