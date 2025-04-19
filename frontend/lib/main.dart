import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = 'Fetching...';

  @override
  void initState() {
    super.initState();
    _fetchHello();
  }

  Future<void> _fetchHello() async {
    // On Android emulator, use 10.0.2.2 to reach host machine's localhost
    final uri = Uri.parse('http://10.0.2.2:8000/hello');
    try {
      final resp = await http.get(uri);
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body);
        setState(() {
          _message = data['message'];
        });
      } else {
        setState(() => _message = 'Error ${resp.statusCode}');
      }
    } catch (e) {
      setState(() => _message = 'Failed to connect: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FastAPI ↔ Flutter')),
        body: Center(child: Text(_message, style: const TextStyle(fontSize: 24))),
      ),
    );
  }
}
