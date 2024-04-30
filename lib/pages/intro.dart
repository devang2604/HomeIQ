import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:home/pages/login_signup.dart';
import 'package:nice_buttons/nice_buttons.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late List<AnimatedTextExample> _examples;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {
      print('Tap Event');
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut.flipped,
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
      body: Stack(
        children: [
          // Set the background image to fill the entire screen
          Image.asset(
            "assets/background.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          // Use a semi-transparent overlay to ensure text is readable
          Container(
            color: Colors.black.withOpacity(0.4), // Adjust opacity as needed
          ),
          // Content that will appear on top of the background
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: Center(
                      key: const ValueKey('Typer'),
                      child: _examples[0].child,
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between sections
                  NiceButtons(
                    stretch: false,
                    progress: true,
                    gradientOrientation: GradientOrientation.Vertical,
                    onTap: (finish) {
                      Timer(const Duration(seconds: 2), () {
                        finish();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      });
                    },
                    child: const Text(
                      'Explore The Fashion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;

  AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

List<AnimatedTextExample> animatedTextExamples({VoidCallback? onTap}) {
  return <AnimatedTextExample>[
    AnimatedTextExample(
      label: 'Typer',
      color: Colors.white,
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            'Smarter Home, Smarter Life.',
            textStyle: const TextStyle(
              fontSize: 34.0,
              fontFamily: 'Niconne',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            speed: const Duration(milliseconds: 150),
          ),
        ],
        onTap: onTap,
        totalRepeatCount: 1,
      ),
    ),
  ];
}
