import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/svg_logo.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo Display'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SVGImage(
              width: 200,
              height: 200,
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 800))
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: const Duration(milliseconds: 600),
                ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Taskly',
              style: Theme.of(context).textTheme.headlineSmall,
            )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 400))
                .slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
}
