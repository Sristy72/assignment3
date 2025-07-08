// controllers/post_controller.dart
import 'package:assignment3/model/item_model.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../services/api_services.dart';
import '../services/sqlite_services.dart';

class ItemController extends GetxController {
  var posts = <Item>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }


  void fetchData() async {
    try {
      isLoading(true);
      if (await _hasInternet()) {
        var fetchedPosts = await ApiService.fetchPosts();
        posts(fetchedPosts);
        await DBService.clearPosts();
        await DBService.insertItems(fetchedPosts);
      } else {
        var cachedPosts = await DBService.getPosts();
        posts(cachedPosts);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }


  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
