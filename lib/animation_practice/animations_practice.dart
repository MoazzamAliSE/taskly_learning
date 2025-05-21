import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestAnimation extends StatelessWidget {
  const TestAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageAnimation(),
    );
  }
}

class HomePageAnimation extends StatefulWidget {
  const HomePageAnimation({super.key});

  @override
  State<HomePageAnimation> createState() => _HomePageAnimationState();
}

class _HomePageAnimationState extends State<HomePageAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Reset and restart the animation
          _controller.reset();
          _controller.forward();
        },
        child: const Icon(Icons.refresh),
      ),
      body: SizedBox.expand(
        child: Lottie.asset(
          'assets/Splash.json',
          controller: _controller,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
