// Import Flutter's material design library.
// This gives us access to widgets like Center, Container, etc.
import 'package:flutter/material.dart';

// ------------------------------------------------------------
// 1️⃣ This widget demonstrates a simple animation (fade in & out)
// ------------------------------------------------------------
class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  // The createState() method creates the mutable part of the widget
  // where all the animation logic and variables will live.
  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

// ------------------------------------------------------------
// 2️⃣ This class handles all the animation logic
// ------------------------------------------------------------
// We add "with SingleTickerProviderStateMixin" — this mixin
// helps the widget act as a "TickerProvider", which gives
// a time signal (a tick) to the animation controller
// so that it knows how fast to move or update.
class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  // Declare an AnimationController variable.
  // 'late' means we’ll initialize it later in initState().
  late final AnimationController _controller;

  // ------------------------------------------------------------
  // 3️⃣ initState() is called only once — when the widget is created.
  // ------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController.
    // This controller will manage the timing of the animation.
    // It needs two things:
    //   - vsync: this → connects the animation to the screen refresh
    //   - duration: how long one full animation cycle takes
    _controller =
        AnimationController(
            vsync:
                this, // ensures efficient performance by syncing to screen refresh
            duration: const Duration(seconds: 2), // one cycle lasts 2 seconds
          )
          // The '..repeat(reverse: true)' means:
          // Start the animation and keep repeating it.
          // After reaching the end (opacity = 1), reverse it back (opacity = 0).
          ..repeat(reverse: true);
  }

  // ------------------------------------------------------------
  // 4️⃣ dispose() is called automatically when the widget is removed
  // from the screen. We use it to clean up resources.
  // ------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose(); // stop animation & free memory
    super.dispose();
  }

  // ------------------------------------------------------------
  // 5️⃣ The build() method builds the UI part of the widget.
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Center(
      // FadeTransition widget automatically applies
      // a fading effect (opacity animation) to its child.
      //
      // 'opacity: _controller' means it will use the animation values
      // from the controller (from 0.0 to 1.0) to change opacity.
      child: FadeTransition(
        opacity: _controller,

        // The widget that will fade in and out.
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.indigo, // fill color
            borderRadius: BorderRadius.circular(12), // rounded corners
          ),
        ),
      ),
    );
  }
}
