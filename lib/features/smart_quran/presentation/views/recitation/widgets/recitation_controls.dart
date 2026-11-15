import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';

class RecitationControls extends StatelessWidget {
  final VoidCallback onFinish;
  final VoidCallback onListen;
  final bool isEnabled;

  const RecitationControls({
    super.key,
    required this.onFinish,
    required this.onListen,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: CustomActionButton(
            title: l10n.listenToAyah,
            icon: Icons.volume_up_rounded,
            onPressed: onListen,
            isEnabled: isEnabled,
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: CustomActionButton(
            title: l10n.finishRecitation,
            icon: Icons.check_circle_outline_rounded,
            onPressed: onFinish,
            isPrimary: true,
            isEnabled: isEnabled,
          ),
        ),
      ],
    );
  }
}
