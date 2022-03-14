import 'package:flutter/material.dart';
import 'package:swapi/src/shared_widgets/logo.dart';
import 'package:swapi/src/shared_widgets/soldier.dart';

class BackGround extends StatelessWidget {
  const BackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Logo(),
          const SizedBox(
            height: 10,
          ),
          Soldier()
        ],
      ),
    );
  }
}
