import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestLogoScreen extends StatelessWidget {
  const TestLogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('SVG Repeat Pattern Demo')),
        body: Stack(
          children: [
            // Debug container to show if the grid is rendering
            Container(
              color: Colors.grey[200],
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blue.withOpacity(0.1),
                    child: SvgPicture.asset(
                      'assets/nuncmitto1.svg',
                      fit: BoxFit.cover,
                      placeholderBuilder: (context) => const SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                      // Add error builder to see if there are any loading issues
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading SVG: $error');
                        return Container(
                          color: Colors.red.withOpacity(0.2),
                          child: Center(
                            child: Text(
                              'Error: ${error.toString().split('\n')[0]}',
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            // Debug text to show if the screen is rendering
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.7),
                child: const Text(
                  'Debug Info',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'SVG is repeated as a background pattern!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
