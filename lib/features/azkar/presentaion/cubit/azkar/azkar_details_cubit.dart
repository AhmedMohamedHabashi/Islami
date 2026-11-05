import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/exceptions.dart';
import 'package:islami/features/azkar/domain/usecases/get_zkars_by_category_usecase.dart';
import 'package:islami/features/azkar/presentaion/cubit/azkar/azkar_details_state.dart';

@injectable
class AzkarDetailsCubit extends Cubit<AzkarDetailsState> {
  final GetZkarsByCategoryUseCase getZkarsByCategoryUseCase;

  AzkarDetailsCubit(this.getZkarsByCategoryUseCase)
    : super(AzkarDetailsInitial());

  Future<void> fetchZkars(String categoryName) async {
    emit(AzkarDetailsLoading());

    try {
      final zkarsList = await getZkarsByCategoryUseCase(categoryName);
      emit(AzkarDetailsLoaded(zkarsList: zkarsList));
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(Object e) {
    if (e is NetworkException) {
      emit(AzkarDetailsError(message: AppErrors.networkError));
    } else if (e is AppTimeoutException) {
      emit(AzkarDetailsError(message: AppErrors.timeoutError));
    } else if (e is ServerException) {
      emit(AzkarDetailsError(message: AppErrors.serverError));
    } else {
      emit(AzkarDetailsError(message: AppErrors.unexpectedError));
    }
  }
}
