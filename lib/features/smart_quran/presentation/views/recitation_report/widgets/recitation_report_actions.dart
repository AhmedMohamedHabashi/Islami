import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';

class RecitationReportActions extends StatelessWidget {
  final VoidCallback onApprove;
  final VoidCallback onRetry;

  const RecitationReportActions({
    super.key,
    required this.onApprove,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomActionButton(
          title: l10n.recitationApproveButton,
          icon: Icons.check_rounded,
          onPressed: onApprove,
          isPrimary: true,
        ),

        SizedBox(height: 12.h),

        CustomActionButton(
          title: l10n.recitationRetryButton,
          icon: Icons.refresh_rounded,
          onPressed: onRetry,
          isPrimary: false,
        ),
      ],
    );
  }
}
