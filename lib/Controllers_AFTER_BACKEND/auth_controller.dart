import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/services/api_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Check if user is logged in
  void checkLoginStatus() {
    // Check if token exists in storage
    // For now, we'll use a simple approach
    final token = ApiService.token;
    isLoggedIn.value = token != null;
  }

  // Register user
  Future<void> register(String username, String email, String password) async {
    try {
      isLoading.value = true;

      final response = await ApiService.post('/auth/register', {
        'username': username,
        'email': email,
        'password': password,
      });

      if (response['success']) {
        final data = response['data'];
        ApiService.setToken(data['token']);
        user.value = data;
        isLoggedIn.value = true;

        Get.snackbar(
          'Success',
          'Registration successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Login user
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await ApiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response['success']) {
        final data = response['data'];
        ApiService.setToken(data['token']);
        user.value = data;
        isLoggedIn.value = true;

        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout user
  void logout() {
    ApiService.token = null;
    isLoggedIn.value = false;
    user.value = {};
    Get.offAllNamed('/login');
  }

  // Get current user
  Future<void> getCurrentUser() async {
    try {
      final response = await ApiService.get('/auth/me');
      if (response['success']) {
        user.value = response['data'];
      }
    } catch (e) {
      print('Error getting user: $e');
    }
  }
}
