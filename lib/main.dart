import 'package:assignment3/screen/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline Capabilities Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemScreen(),
    );
  }
}
