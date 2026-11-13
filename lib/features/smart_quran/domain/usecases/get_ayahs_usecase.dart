import 'package:injectable/injectable.dart';
import '../entities/ayah.dart';
import '../repo/smart_quran_repository.dart';

@lazySingleton
class GetAyahsUseCase {
  final SmartQuranRepository repository;

  GetAyahsUseCase({required this.repository});

  Future<List<Ayah>> call({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  }) {
    return repository.getAyahs(
      surahNumber: surahNumber,
      startAyah: startAyah,
      endAyah: endAyah,
    );
  }
}
