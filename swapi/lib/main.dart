import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapi/src/providers/character_provider.dart';
import 'package:swapi/src/providers/login_provider.dart';
import 'package:swapi/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CharacterProvider(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SWAPI',
        initialRoute: 'login',
        routes: getApplicationRoutes(),
        theme: ThemeData(
          fontFamily: 'Orbitron',
          primaryColor: Color.fromRGBO(238, 219, 0, 1),
        ),
      ),
    );
  }
}
