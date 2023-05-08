import 'package:elevator_system/screens/HomeScreen.dart';
import 'package:elevator_system/screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(const MainApp());
  await http.post(Uri.http('localhost:8080', '/api/startSystem'));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: MainPage()),
    );
  }
}
