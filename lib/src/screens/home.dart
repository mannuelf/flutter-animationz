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
    } else if (catController.status == AnimationStatus.forward) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.reverse) {
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⛱ Animations ⛱')),
      body: GestureDetector(
        onTap: tapBox,
        child: Center(
          child: Stack(
            children: [buildCatAnimation(), buildBox()],
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (BuildContext context, child) {
          return Positioned(
            bottom: catAnimation.value,
            child: child!,
          );
        },
        child: const Cat() // create cat one time, expensive so do it once,
        );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown.shade300,
    );
  }
}
