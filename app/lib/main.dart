import 'package:app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SignIn Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route or add it to your routes map
      initialRoute: '/signup',
      routes: {
        '/login': (context) => const LoginPage(), // loginPage route
        '/signup': (context) => const SignUpPage(),
        // Add more routes here as needed
      },
    );
  }
}
