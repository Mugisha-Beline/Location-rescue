import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Hello World Demo Application',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // Inner UI of the application
      home: const MyHomePage(title: 'Home page'),
    );
  }
}
 

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      
      body: const Center(
          // Sets the content of the Application
          child: Text(
        'Welcome to GeeksForGeeks!',
      )),
    );
  }
}