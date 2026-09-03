import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/localization/cubits/locale_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BlocProvider(create: (_) => LocaleCubit(), child: const IslamiApp()));
}
