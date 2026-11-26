import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// بيصغّر الـ child شوية وقت الضغط ويشغّل [onTap].
/// لو [haptic] بـ true بيدي اهتزاز خفيف عند الـ tap.
class PressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double pressedScale;
  final bool haptic;

  const PressScale({
    super.key,
    required this.child,
    this.onTap,
    this.pressedScale = 0.9,
    this.haptic = false,
  });

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _pressed = false;

  void _set(bool v) {
    if (widget.onTap != null) setState(() => _pressed = v);
  }

  void _handleTap() {
    if (widget.haptic) HapticFeedback.lightImpact();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      onTap: widget.onTap == null ? null : _handleTap,
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
