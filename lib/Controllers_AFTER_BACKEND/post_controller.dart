import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:insta_clone2/Controllers_AFTER_BACKEND/auth_controller.dart';
import 'package:insta_clone2/services/api_service.dart';

class PostController extends GetxController {
  var isLoading = false.obs;
  var posts = [].obs;
  var currentPage = 1.obs;
  var hasMore = true.obs;
  String? userId;

  @override
  void onInit() {
    super.onInit();
    // Get user ID from auth controller
    final authController = Get.find<AuthController>();
    userId = authController.user['_id'];
  }

  // Create a new post
  Future<void> createPost({
    required List<File> mediaFiles,
    String caption = '',
    String location = '',
    List<String> tags = const [],
  }) async {
    try {
      isLoading.value = true;

      final fields = {
        'caption': caption,
        'location': location,
        'tags': tags.join(','),
      };

      final response = await ApiService.multipartPost(
        '/posts',
        mediaFiles,
        fields,
      );

      if (response['success']) {
        // Add new post to the beginning of the list
        posts.insert(0, response['data']);

        Get.snackbar(
          'Success',
          'Post created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.back(); // Go back to previous screen
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

  // Get posts for feed
  Future<void> getPosts({bool refresh = false}) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        hasMore.value = true;
        posts.clear();
      }

      if (!hasMore.value && !refresh) return;

      isLoading.value = true;

      final response = await ApiService.get(
        '/posts?page=${currentPage.value}&limit=10',
      );

      if (response['success']) {
        final newPosts = response['data'];
        final pagination = response['pagination'];

        if (refresh) {
          posts.value = newPosts;
        } else {
          posts.addAll(newPosts);
        }

        hasMore.value = currentPage.value < pagination['pages'];
        currentPage.value++;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load posts: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Like/unlike a post
  Future<void> likePost(String postId) async {
    try {
      final response = await ApiService.put('/posts/$postId/like', {});

      if (response['success']) {
        // Update the post in the list
        final index = posts.indexWhere((post) => post['_id'] == postId);
        if (index != -1) {
          posts[index]['likes'] = response['data']['likes'];
          posts[index]['isLiked'] = response['data']['isLiked'];
          posts.refresh();
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to like post: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Add comment to post
  Future<void> addComment(String postId, String text) async {
    try {
      final response = await ApiService.post('/posts/$postId/comment', {
        'text': text,
      });

      if (response['success']) {
        // Update the post in the list
        final index = posts.indexWhere((post) => post['_id'] == postId);
        if (index != -1) {
          posts[index]['comments'].add(response['data']);
          posts.refresh();
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add comment: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    try {
      final response = await ApiService.delete('/posts/$postId');

      if (response['success']) {
        posts.removeWhere((post) => post['_id'] == postId);

        Get.snackbar(
          'Success',
          'Post deleted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete post: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
