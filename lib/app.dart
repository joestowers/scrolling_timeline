import 'package:flutter/material.dart';
import './widgets/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrolling Timeline',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Scrolling Timeline'),
    );
  }
}
