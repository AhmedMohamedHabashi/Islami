import 'package:islami/features/home/domain/entities/surah_entity.dart';
import 'package:islami/features/home/domain/repositories/home_repository.dart';

class GetHomeRecentSurahsUseCase {
  final HomeRepository repository;

  GetHomeRecentSurahsUseCase({required this.repository});

  Future<List<SurahEntity>> call() {
    return repository.getRecentSurahs();
  }
}
