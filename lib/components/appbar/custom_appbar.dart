import 'package:flutter/material.dart';
class CustomAppBar extends AppBar {
  CustomAppBar({Key key, Widget title, elevation:0.0, List<Widget> actions})
      : super(key: key, title: title, elevation:elevation, actions: actions);
}
