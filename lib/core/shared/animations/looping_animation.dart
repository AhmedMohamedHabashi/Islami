import 'package:flutter/material.dart';

/// بيعمل controller بيكرر من 0 لـ 1 ويدّيك الـ animation في الـ builder.
class LoopingAnimation extends StatefulWidget {
  const LoopingAnimation({
    super.key,
    required this.duration,
    required this.builder,
  });

  final Duration duration;
  final Widget Function(BuildContext context, Animation<double> animation)
  builder;

  @override
  State<LoopingAnimation> createState() => _LoopingAnimationState();
}

class _LoopingAnimationState extends State<LoopingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller);
}
