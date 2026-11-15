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
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void initState() {
    super.initState();
    if (widget.pulsing) _c.repeat();
  }

  @override
  void didUpdateWidget(covariant PulsingDot old) {
    super.didUpdateWidget(old);
    if (old.pulsing == widget.pulsing) return;
    widget.pulsing ? _c.repeat() : _c.reset();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return SizedBox(
      width: s * 2.4,
      height: s * 2.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.pulsing)
            AnimatedBuilder(
              animation: _c,
              builder: (_, __) {
                final t = Curves.easeOut.transform(_c.value);
                final d = s + s * 1.4 * t;
                return Container(
                  width: d,
                  height: d,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withValues(alpha: 0.35 * (1 - t)),
                  ),
                );
              },
            ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: s,
            height: s,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              boxShadow: widget.pulsing
                  ? [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.5),
                        blurRadius: s,
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
