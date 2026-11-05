import '../entities/surah.dart';
import '../repo/smart_quran_repository.dart';

class GetSurahsUseCase {
  final SmartQuranRepository repository;

  GetSurahsUseCase({required this.repository});

  Future<List<Surah>> call() {
    return repository.getSurahs();
  }
}
