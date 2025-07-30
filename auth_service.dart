import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class AuthService {
  Future<Map<String, dynamic>> loginAdmin({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}login/admin'),
        body: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Login user
Future<Map<String, dynamic>> loginUser({
  required String username,
  required String password,
}) async {
  try {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}login/user'),
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'success': false, 'message': 'Server error: ${response.statusCode}'};
    }
  } catch (e) {
    return {'success': false, 'message': 'Error: $e'};
  }
}

/// Register user
  Future<Map<String, dynamic>> register({
    required String fullname,
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}register'),
        body: {
          'fullname': fullname,
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
