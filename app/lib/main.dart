import 'package:app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SignIn Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route or add it to your routes map
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), // loginPage route
        '/'
        // Add more routes here as needed
      },
    );
  }
}
