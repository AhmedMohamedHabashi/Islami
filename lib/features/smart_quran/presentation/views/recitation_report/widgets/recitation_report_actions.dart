import 'package:flutter/material.dart';
import 'package:islami/config/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/utils/app_sizes.dart';

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

        SizedBox(height: AppSizes.size12H),

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
