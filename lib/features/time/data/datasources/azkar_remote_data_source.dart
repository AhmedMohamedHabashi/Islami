import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/network/endpoints.dart';
import 'package:islami/features/azkar/data/models/zekr_model.dart';

@LazySingleton()
class AzkarRemoteDataSource {
  final Dio dio;

  AzkarRemoteDataSource(@Named('azkarDio') this.dio);

  Future<List<ZekrModel>> fetchAllAzkar() async {
    final response = await dio.get(Endpoints.azkarItems);

    if (response.statusCode == 200) {
      final List data = response.data['items'];
      return data.map((json) => ZekrModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load azkar from server');
    }
  }
}
