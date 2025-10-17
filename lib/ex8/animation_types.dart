// Import Flutter Material library for animation and UI widgets
import 'package:flutter/material.dart';

// ==============================
// 🎬 SLIDE + FADE DEMO WIDGET
// ==============================
//
// This widget shows a Flutter logo that slides in from the left
// and keeps fading in and out (appearing/disappearing repeatedly).
class SlideFadeDemo extends StatefulWidget {
  const SlideFadeDemo({super.key});

  @override
  State<SlideFadeDemo> createState() => _SlideFadeDemoState();
}

// ==============================
// 🔁 STATE CLASS — where animation logic lives
// ==============================
//
// 'TickerProviderStateMixin' is used because animations need a "ticker"
// (something that ticks every frame, like a clock) to update smoothly.
class _SlideFadeDemoState extends State<SlideFadeDemo>
    with TickerProviderStateMixin {
  // AnimationControllers are objects that manage the timing of an animation.
  // You can think of them as “remote controls” for the animation — play, stop, repeat, etc.
  late final AnimationController _slideController;
  late final AnimationController _fadeController;

  // Called when the widget is first created (before UI appears)
  @override
  void initState() {
    super.initState();

    // -------------------------------
    // 🟦 SLIDE ANIMATION CONTROLLER
    // -------------------------------
    // Controls the horizontal sliding motion.
    _slideController = AnimationController(
      vsync: this, // uses the TickerProvider for smooth animation
      duration: const Duration(milliseconds: 800), // total animation time
    )..forward(); // start playing immediately once screen loads

    // -------------------------------
    // 🟨 FADE ANIMATION CONTROLLER
    // -------------------------------
    // Controls the fading in/out (opacity)
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true); // loops back and forth (fade in → fade out)
  }

  // Called when widget is removed — must dispose animations to free memory.
  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // -------------------------------
  // 🎨 BUILD METHOD (UI)
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        // position defines where the widget starts and ends on the screen
        position:
            Tween<Offset>(
              begin: const Offset(-1, 0), // starts from left side (off-screen)
              end: Offset.zero, // ends at original position (center)
            ).animate(
              CurvedAnimation(
                parent: _slideController, // controlled by slide controller
                curve: Curves.easeOut, // smooth deceleration motion
              ),
            ),

        // Inside the SlideTransition, we also apply FadeTransition
        child: FadeTransition(
          // opacity goes from 0 → 1 → 0 repeatedly (handled by controller)
          opacity: _fadeController,
          // The widget being animated — Flutter logo
          child: const FlutterLogo(size: 120),
        ),
      ),
    );
  }
}
