import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/app.dart';
import 'package:islami/config/di/injection_container.dart';
import 'package:islami/config/localization/cubits/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(BlocProvider(create: (_) => LocaleCubit(), child: const IslamiApp()));
}
