import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/exceptions.dart';
import 'package:islami/features/time/domain/usecases/get_azkar_categories_usecase.dart';
import 'package:islami/features/time/presentation/cubit/azkar/azkar_state.dart';

@injectable
class AzkarCubit extends Cubit<AzkarState> {
  final GetAzkarCategoriesUseCase getAzkarCategoriesUseCase;

  AzkarCubit({required this.getAzkarCategoriesUseCase}) : super(AzkarInitial());

  Future<void> fetchAzkarCategories() async {
    emit(AzkarLoading());

    try {
      final categoriesList = await getAzkarCategoriesUseCase();

      emit(AzkarLoaded(categoriesList: categoriesList));
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(Object e) {
    if (e is NetworkException) {
      emit(AzkarError(message: AppErrors.networkError));
    } else if (e is AppTimeoutException) {
      emit(AzkarError(message: AppErrors.timeoutError));
    } else if (e is ServerException) {
      emit(AzkarError(message: AppErrors.serverError));
    } else {
      emit(AzkarError(message: AppErrors.unexpectedError));
    }
  }
}
