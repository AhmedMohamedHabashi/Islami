import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState(locale: Locale('ar')));

  void changeLanguage() {
    if (state.locale.languageCode == 'ar') {
      emit(const LocaleState(locale: Locale('en')));
    } else {
      emit(const LocaleState(locale: Locale('ar')));
    }
  }
}
