import 'package:flutter/material.dart';
class CustomAppBar extends AppBar {
  CustomAppBar({Key key, Widget title, elevation:0.0, List<Widget> actions,bool automaticallyImplyLeading })
      : super(key: key, title: title, elevation:elevation, actions: actions,automaticallyImplyLeading: automaticallyImplyLeading,
    backgroundColor:Colors.green,
  );
}
