import 'package:animationz/src/widgets/cat.dart';
import 'package:flutter/material.dart';

import '../widgets/cat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation; // animation object
  late AnimationController catController;

  @override
  initState() {
    // Life-cycle method
    super.initState();

    catController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    catAnimation = Tween(begin: 0.0, end: 100.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  tapBox() {
    // plays animation on tap
    if (catController.status == AnimationStatus.completed) {
      // animation completed
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      // animation stopped
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations ⛱')),
      body: GestureDetector(
        onTap: tapBox,
        child: buildAnimation(),
      ),
    );
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (BuildContext context, child) {
          return Container(
              margin: EdgeInsets.only(top: catAnimation.value),
              child: child // recreates the widget, cheap,
              );
        },
        child: const Cat() // create cat one time, expensive so do it once,
        );
  }
}
