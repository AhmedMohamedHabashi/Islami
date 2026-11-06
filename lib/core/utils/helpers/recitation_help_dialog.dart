import 'package:flutter/material.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/dialogs/custom_info_dialog.dart';

class RecitationHelpDialog {
  static void show(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return CustomInfoDialog(
          title: l10n.recitationHelpTitle,
          message: l10n.recitationHelpMessage,
        );
      },
    );
  }
}
