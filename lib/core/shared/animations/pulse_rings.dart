import 'package:flutter/material.dart';

/// موجات بتكبر وتختفي حوالين أي عنصر. بتشتغل بس لما [active] = true.
class PulseRings extends StatefulWidget {
  final bool active;
  final Color color;
  final double size;
  final int rings;
  final Duration duration;

  const PulseRings({
    super.key,
    required this.active,
    required this.color,
    required this.size,
    this.rings = 2,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<PulseRings> createState() => _PulseRingsState();
}

class _PulseRingsState extends State<PulseRings>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    if (widget.active) _c.repeat();
  }

  @override
  void didUpdateWidget(covariant PulseRings old) {
    super.didUpdateWidget(old);
    if (old.active == widget.active) return;
    if (widget.active) {
      _c.repeat();
    } else {
      _c.stop();
      _c.value = 0;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: List.generate(widget.rings, (i) {
          final t = Curves.easeOut.transform((_c.value + i / widget.rings) % 1);
          final s = widget.size * (1 + 0.55 * t);
          return Container(
            width: s,
            height: s,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.color.withValues(alpha: 0.45 * (1 - t)),
                width: 2,
              ),
            ),
          );
        }),
      ),
    );
  }
}
