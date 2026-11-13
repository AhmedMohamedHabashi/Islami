import 'package:injectable/injectable.dart';
import '../entities/surah.dart';
import '../repo/smart_quran_repository.dart';

@lazySingleton
class GetSurahsUseCase {
  final SmartQuranRepository repository;

  GetSurahsUseCase({required this.repository});

  Future<List<Surah>> call() {
    return repository.getSurahs();
  }
}
