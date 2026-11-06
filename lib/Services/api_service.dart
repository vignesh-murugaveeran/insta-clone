import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService {
  static const String baseUrl =
      'http://localhost:5000/api'; // Change to your backend URL
  static String? token;

  // Set authentication token
  static void setToken(String newToken) {
    token = newToken;
  }

  // Get headers with authentication
  static Map<String, String> getHeaders() {
    final headers = {'Content-Type': 'application/json'};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Handle API response
  static dynamic handleResponse(http.Response response) {
    final responseData = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseData;
    } else {
      throw Exception(responseData['message'] ?? 'Something went wrong');
    }
  }

  // POST request
  static Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: getHeaders(),
        body: json.encode(data),
      );
      return handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // GET request
  static Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: getHeaders(),
      );
      return handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // PUT request
  static Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: getHeaders(),
        body: json.encode(data),
      );
      return handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // DELETE request
  static Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: getHeaders(),
      );
      return handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Multipart request for file upload
  static Future<dynamic> multipartPost(
    String endpoint,
    List<File> files,
    Map<String, String> fields,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$endpoint'),
      );

      // Add headers
      request.headers.addAll(getHeaders());

      // Add fields
      fields.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add files
      for (var file in files) {
        var multipartFile = await http.MultipartFile.fromPath(
          'media', // Field name should match your backend
          file.path,
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(responseString);
      } else {
        throw Exception(
          json.decode(responseString)['message'] ?? 'Upload failed',
        );
      }
    } catch (e) {
      throw Exception('Upload error: $e');
    }
  }
}
