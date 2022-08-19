import 'dart:async';

import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../utils/routes.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1800),
    vsync: this,
  );
  late final Animation<AlignmentGeometry> offsetAnimationOne =
      Tween<AlignmentGeometry>(
    begin: const Alignment(-2, 0),
    end: const Alignment(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward();
    Timer(const Duration(milliseconds: 2000), ()=>Navigator.pushReplacementNamed(context, Routes.homePage),);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowUpAnimation(
            animationDuration: const Duration(milliseconds: 1400),
            curve: Curves.easeInOutBack,
            direction: Direction.horizontal,
            offset: -1,
            child: const Image(
              image: AssetImage('assets/images/ic_logo.png'),
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
