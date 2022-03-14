import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  double _containerHeigh = 10;
  double _containerWidth = 10;

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
        AnimatedContainer(
          duration: const Duration(seconds: 6),
          curve: Curves.ease,
          width: _containerWidth,
          height: _containerHeigh,
          // width: MediaQuery.of(context).size.width * 0.8,
          // height: MediaQuery.of(context).size.height * 0.2,
          child: Center(child: Image.asset("assets/logo.png")),
        ),
      ],
    );
  }

  startAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _containerWidth = MediaQuery.of(context).size.width * 0.8;
      _containerHeigh = MediaQuery.of(context).size.height * 0.2;
      setState(() {});
    });
  }
}
