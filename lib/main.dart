import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              var response = await http.get(Uri.parse('http://localhost:8000/contacts/all/'));
              print(response.body);
            }, 
            child: Text('Hit API'),
          ),
        ),
      ),
    );
  }
}
