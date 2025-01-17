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

  static Future<dynamic> postloginApi(String endPoint, String? jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    // String requestBody = jsonData;
    debugPrint('POST 요청: $endPoint');

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
      if (response.statusCode == 200) {
        debugPrint('POST 요청 성공 ${response.body}');
      } else {
        debugPrint('POST 요청 실패: (${response.statusCode})${response.body}');
      }

      // 예외 처리를 위한 status code 반환
      return response.body;
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
        print(response.body);
        print(jsonDecode(response.body)['success']);
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

  static Future<dynamic> getApiCode(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('GET 요청: $endPoint');

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        debugPrint('GET 요청 성공');

        return true;
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

  /// 이메일로 비번 받기기
  static Future<dynamic> authSignUpApi(String? email, String jsonData) async {
    String endPoint = 'api/auth/join/email'; // api/auth/join/email?email=value&
    // if (email != null) {
    //   endPoint = 'api/auth/join/email/$email';
    // }
    dynamic response = await postApi(endPoint, jsonData);
    return response;
  }

  static Future<dynamic> checkCodeApi(String? email, String? code) async {
    String endPoint = 'api/auth/verify/email?email=$email&code=$code';
    String jsonData = '';
    dynamic response = await getApiCode(endPoint);
    if (response) {
      print("코드 인증 성공ㅇ;ㅣㅇ;ㄹ");
    }
  }

  static Future<dynamic> saveNickNameApi(String jsonData) async {
    String endPoint = 'api/users/nickname';

    dynamic response = await patchApi(endPoint, jsonData);
    return response;
  }

  static Future<dynamic> loginApi(String jsonData) async {
    String endPoint = 'api/login';
    dynamic response = await postloginApi(endPoint, jsonData);
    // final data = jsonDecode(response.body);
    // print(jsonDecode(response.body));
    return response;
  }

  static Future<dynamic> levelUpApi(String jsonData) async {
    String endPoint = 'api/users/level-up';
    dynamic response = await postApi(endPoint, jsonData);
    // final data = jsonDecode(response.body);
    // print(jsonDecode(response.body));
    return response;
  }

  static Future<dynamic> fetchUserData(String sessionKey) async {
    final url = Uri.parse('$baseUrl/api/users/me');
    final headers = {'Authorization': sessionKey}; // sessionKey 전달

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return response.body; // JSON 문자열 반환
      } else {
        print('API 호출 실패: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('API 호출 에러: $e');
      return null;
    }
  }
}
