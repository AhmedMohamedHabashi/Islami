import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'smart_quran_state.dart';

class SmartQuranCubit extends Cubit<SmartQuranState> {
  SmartQuranCubit() : super(SmartQuranInitial());
}
