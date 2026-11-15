import 'package:flutter/material.dart';

/// بيبدّل بين child وتاني بـ fade + slide خفيف. استخدم ValueKey على الـ child.
class FadeSlideSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const FadeSlideSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.4),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
