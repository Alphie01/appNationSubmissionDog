import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

abstract class HTTP_Requests {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://dog.ceo/',
    receiveDataWhenStatusError: true,
  ));

  // CacheOptions ekleniyor
  static final DioCacheInterceptor _cacheInterceptor = DioCacheInterceptor(
    options: CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache,
      maxStale: Duration(days: 7),
    ),
  );

  static void init() {
    _dio.interceptors.add(_cacheInterceptor);
  }

  static Future<Map<String, dynamic>> sendGetRequest({
    List<String> params = const [],
    String? url,
  }) async {
    String uri = url ?? _dio.options.baseUrl;

    if (params.isNotEmpty) {
      uri += '?' + params.join('&');
    }
    try {
      Response response = await _dio.get(uri);
      return response.data;
    } catch (error) {
      return {'error': error.toString()};
    }
  }

  static Future<Map<String, dynamic>> sendPostRequest(
      Map<String, dynamic> data) async {
    try {
      var formData = FormData.fromMap(data);
      var response = await _dio.post(_dio.options.baseUrl, data: formData);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {'status': response.statusCode};
      }
    } catch (error) {
      return {'error': error.toString()};
    }
  }

  static Future<Map<String, dynamic>> postImagesWithDio(
      List<File> imageFiles, Map<String, dynamic>? data) async {
    String apiUrl = _dio.options.baseUrl;
    FormData formData;

    try {
      // FormData nesnesini oluştur
      if (data != null && data.isNotEmpty) {
        formData = FormData.fromMap(data);
      } else {
        formData = FormData();
      }

      // Resimleri ekle
      for (int i = 0; i < imageFiles.length; i++) {
        formData.files.add(MapEntry(
          'images[$i]',
          await MultipartFile.fromFile(
            imageFiles[i].path,
            filename: 'image_$i.jpg',
          ),
        ));
      }

      // POST isteği gönder
      var response = await _dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {
          'error':
              'Failed to upload images. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'error': 'Error uploading images: $e'};
    }
  }
}
