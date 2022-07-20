import 'dart:math';

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
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  initState() {
    // Life-cycle method
    super.initState();

    boxController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(CurvedAnimation(parent: boxController, curve: Curves.linear));
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();

    catController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    catAnimation = Tween(begin: -40.0, end: -80.0).animate(
        CurvedAnimation(parent: catController, curve: Curves.easeInOutBack));
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
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap()
            ],
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
            left: 0.0,
            right: 0.0,
            top: catAnimation.value,
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

  Widget buildLeftFlap() {
    return Positioned(
        left: 4.0,
        child: AnimatedBuilder(
            animation: boxAnimation,
            child: Container(
              height: 5.0,
              width: 125.0,
              color: Colors.brown.shade300,
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: boxAnimation.value,
                alignment: Alignment.topLeft,
                child: child,
              );
            }));
  }

  Widget buildRightFlap() {
    return Transform.rotate(
        angle: pi * 0.6,
        alignment: Alignment.topRight,
        child: Container(
          height: 5.0,
          width: 125.0,
          color: Colors.brown.shade300,
        ));
  }
}
