import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart'; // ضيف الـ import ده
import 'package:islami/core/shared/widgets/surah_details/surah_details_view.dart';

class AzkarDetailsView extends StatelessWidget {
  const AzkarDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final Map<String, dynamic> args =
        GoRouterState.of(context).extra as Map<String, dynamic>;
    final zekrItem = args['zekr'];
    final String computedTitle = args['title'];

    return SurahDetailsView(
      appBarTitle: l10n.azkarTitle,
      itemTitle: computedTitle,
      content: zekrItem.zekr,
    );
  }
}
