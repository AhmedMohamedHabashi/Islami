import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/recitation_report_cubit.dart';
import 'recitation_report_body.dart';

class RecitationReportView extends StatelessWidget {
  const RecitationReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecitationReportCubit(),
      child: const RecitationReportBody(),
    );
  }
}
