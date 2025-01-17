import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  static String baseUrl = dotenv.env['API_URL']!;

  /// post
  static Future<dynamic> postApi(String endPoint, String? jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    // String requestBody = jsonData;
    debugPrint('POST 요청: $endPoint');

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
      if (response.statusCode == 200) {
        debugPrint('POST 요청 성공');
      } else {
        debugPrint('POST 요청 실패: (${response.statusCode})${response.body}');
      }

      // 예외 처리를 위한 status code 반환
      return response.statusCode;
    } catch (e) {
      debugPrint('POST 요청 중 예외 발생: $e');
      return;
    }
  }

  /// patch
  static Future<dynamic> patchApi(String endPoint, String? jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    // String requestBody = jsonData;
    debugPrint('PATCH 요청: $endPoint');

    try {
      final response =
          await http.patch(Uri.parse(apiUrl), headers: headers, body: jsonData);
      if (response.statusCode == 200) {
        debugPrint('PATCH 요청 성공');
      } else {
        debugPrint('PATCH 요청 실패: (${response.statusCode})${response.body}');
      }

      return response.statusCode;
    } catch (e) {
      debugPrint('PATCH 요청 중 예외 발생: $e');
      return;
    }
  }

  /// get
  static Future<dynamic> getApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('GET 요청: $endPoint');

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        debugPrint('GET 요청 성공');
        return jsonDecode(response.body);
      } else {
        debugPrint('GET 요청 실패: (${response.statusCode})${response.body}');
        return response;
      }
    } catch (e) {
      debugPrint('GET 요청 중 예외 발생: $e');
      return;
    }
  }

  /// delete
  static Future<dynamic> deleteApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('DELETE 요청: $endPoint');

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        debugPrint('DELETE 요청 성공');
      } else {
        debugPrint('DELETE 요청 실패: (${response.statusCode})${response.body}');
      }

      return response.statusCode;
    } catch (e) {
      debugPrint('DELETE 요청 중 예외 발생: $e');
      return;
    }
  }

  static Future<dynamic> testApi() async {
    dynamic response = await RemoteDataSource.getApi('api/test/health');
    print(response);
    return response;
  }
}
