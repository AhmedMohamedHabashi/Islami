import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    return await dio.post(path, data: data);
  }
}
