import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// أعمدة صوت متحركة. بتشتغل لما [active] = true.
class AudioWaveBars extends StatefulWidget {
  final bool active;
  final Color color;
  final int bars;
  final double minHeight;
  final double maxHeight;

  const AudioWaveBars({
    super.key,
    required this.active,
    required this.color,
    this.bars = 4,
    this.minHeight = 4,
    this.maxHeight = 14,
  });

  @override
  State<AudioWaveBars> createState() => _AudioWaveBarsState();
}

class _AudioWaveBarsState extends State<AudioWaveBars>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    if (widget.active) _c.repeat();
  }

  @override
  void didUpdateWidget(covariant AudioWaveBars old) {
    super.didUpdateWidget(old);
    if (old.active == widget.active) return;
    widget.active ? _c.repeat() : _c.reset();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.bars, (i) {
          final phase = (_c.value + i / widget.bars) % 1.0;
          final wave = 0.5 + 0.5 * math.sin(phase * 2 * math.pi);
          final h =
              widget.minHeight.h +
              (widget.maxHeight - widget.minHeight).h * wave;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 1.2.w),
            width: 2.5.w,
            height: h,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          );
        }),
      ),
    );
  }
}
