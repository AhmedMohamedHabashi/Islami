import 'package:islami/features/azkar/domain/entities/azkar_entity.dart';

abstract class AzkarDetailsState {}

class AzkarDetailsInitial extends AzkarDetailsState {}

class AzkarDetailsLoading extends AzkarDetailsState {}

class AzkarDetailsLoaded extends AzkarDetailsState {
  final List<ZekrEntity> zkarsList;
  AzkarDetailsLoaded({required this.zkarsList});
}

class AzkarDetailsError extends AzkarDetailsState {
  final message;
  AzkarDetailsError({required this.message});
}
