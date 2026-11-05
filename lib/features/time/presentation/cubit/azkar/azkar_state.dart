import 'package:islami/features/time/domain/entities/azkar_category_entity.dart';

abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarLoaded extends AzkarState {
  final List<AzkarCategoryEntity> categoriesList;

  AzkarLoaded({required this.categoriesList});
}

class AzkarError extends AzkarState {
  final String message;

  AzkarError({required this.message});
}
