import 'package:flutter/material.dart';

class ElasticEntrance extends StatefulWidget {
  const ElasticEntrance({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.elasticOut,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<ElasticEntrance> createState() => _ElasticEntranceState();
}

class _ElasticEntranceState extends State<ElasticEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();
    _scale = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}
