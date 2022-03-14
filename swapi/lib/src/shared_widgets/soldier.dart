import 'package:flutter/material.dart';

class Soldier extends StatefulWidget {
  const Soldier({Key? key}) : super(key: key);

  @override
  State<Soldier> createState() => _SoldierState();
}

class _SoldierState extends State<Soldier> {
  double _containerHeigh = 0;
  double _containerWidth = 0;
  bool _visible = false;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(seconds: 3),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Image.asset("assets/soldier.gif"),
          ),
        ),
      ],
    );
  }

  startAnimation() {
    Future.delayed(const Duration(seconds: 5), () {
      _visible = !_visible;
      setState(() {});
    });
  }
}
