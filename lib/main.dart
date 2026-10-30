import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/app.dart';
import 'package:islami/core/di/injection_container.dart';
import 'package:islami/core/localization/cubits/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(BlocProvider(create: (_) => LocaleCubit(), child: const IslamiApp()));
}
