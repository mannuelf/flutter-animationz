import 'package:animationz/src/widgets/cat.dart';
import 'package:flutter/material.dart';

import '../widgets/cat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Animation<double>? catAnimation;
  AnimationController? catController;

  @override
  initState() {
    // Life-cycle method

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aminations')),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation() {
    return const Cat();
  }
}
