import 'package:flutter/material.dart';

//Custom AppBar that changes per screen
AppBar header(context,{bool isAppTitle = false, String titleText}) {
  return AppBar(
    title: Text(
      isAppTitle ? "Flutter Share" : titleText,
      style: TextStyle(
        fontFamily: isAppTitle ? "Signatra": "",
        fontSize:  isAppTitle ? 50: 20,
      )
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
