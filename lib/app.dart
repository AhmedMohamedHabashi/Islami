import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/app_router.dart';
import 'core/localization/cubits/locale_cubit.dart';
import 'core/localization/cubits/locale_state.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/utils/app_responsive.dart';

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResponsive.init(
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,

            builder: (context, child) {
              return Directionality(
                textDirection: state.locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,

                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
