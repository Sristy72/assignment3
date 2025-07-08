import 'dart:convert';
import 'package:assignment3/model/item_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static Future<List<Item>> fetchPosts() async {
    var response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp'
      },
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Item.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
