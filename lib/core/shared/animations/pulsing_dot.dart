import 'package:flutter/material.dart';

/// نقطة بتنبض بهالة بتكبر وتختفي لما [pulsing] = true.
class PulsingDot extends StatefulWidget {
  final bool pulsing;
  final Color color;
  final double size;

  const PulsingDot({
    super.key,
    required this.pulsing,
    required this.color,
    required this.size,
  });

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    if (widget.pulsing) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant PulsingDot oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pulsing == widget.pulsing) return;

    if (widget.pulsing) {
      _controller.repeat();
    } else {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return SizedBox(
      width: size * 2.4,
      height: size * 2.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.pulsing)
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                final t = Curves.easeOut.transform(_controller.value);
                final diameter = size + size * 1.4 * t;

                return Container(
                  width: diameter,
                  height: diameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withValues(alpha: 0.35 * (1 - t)),
                  ),
                );
              },
            ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              boxShadow: widget.pulsing
                  ? [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.5),
                        blurRadius: size,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
