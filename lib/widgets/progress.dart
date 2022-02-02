import 'package:flutter/material.dart';

Container circularProgress(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top:10.0),
    child: CircularProgressIndicator(),
  );
}

Container linearProgress(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(bottom:10.0),
    child: LinearProgressIndicator(),
  );
}


