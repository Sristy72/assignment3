// screens/post_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/item_controller.dart';

class ItemScreen extends StatelessWidget {
  final ItemController controller = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline Posts')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.posts.isEmpty) {
          return Center(child: Text('No posts available'));
        }
        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
