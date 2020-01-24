import 'package:flutter/material.dart';

import 'color_container.dart';

class SliverGridTimeline extends StatelessWidget {
  final maxCrossAxisExtent = 200.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print('screenWidth = $screenWidth');

    return Flexible(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 2,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ColorContainer(color: Colors.yellow, title: '12:00'),
                  ColorContainer(color: Colors.orange, title: '12:15'),
                  ColorContainer(color: Colors.orange, title: '12:30'),
                  ColorContainer(color: Colors.orange, title: '12:40'),
                  ColorContainer(color: Colors.orange, title: '1:00'),
                ],
              ),
              ColorContainer(
                  color: Colors.red, title: 'SliverGrid.count Container 1'),
              // ColorContainer(color: Colors.purple, title: 'Container 2'),
              // ColorContainer(color: Colors.green, title: 'Container 3'),
              // ColorContainer(color: Colors.orange, title: 'Container 4'),
            ],
          ),
          SliverGrid.extent(
            maxCrossAxisExtent: maxCrossAxisExtent,
            children: <Widget>[
              ColorContainer(
                  color: Colors.red, title: 'Container 1 $maxCrossAxisExtent'),
              ColorContainer(
                  color: Colors.purple,
                  title: 'Container 2 $maxCrossAxisExtent'),
              ColorContainer(
                  color: Colors.green,
                  title: 'Container 3 $maxCrossAxisExtent'),
              ColorContainer(
                  color: Colors.orange,
                  title: 'Container 4 $maxCrossAxisExtent'),
            ],
          )
        ],
      ),
    );
  }
}
