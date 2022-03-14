import 'package:flutter/material.dart';
import 'package:swapi/src/screens/detail/detail.dart';
import 'package:swapi/src/screens/home/home.dart';
import 'package:swapi/src/screens/login/login.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login': (_) => LoginPage(),
    'home': (_) => HomePage(),
    'detail': (_) => DetailPage(),
  };
}
