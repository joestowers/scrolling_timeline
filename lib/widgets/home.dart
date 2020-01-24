import 'package:flutter/material.dart';
import 'package:scrolling_timeline/widgets/sliver_grid_timeline.dart';

import 'list_view_time_increment.dart';
import 'list_view_timeline.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //body: ListViewTimeline(),
      body: ListViewTimeIncrement(),
    );
  }
}
