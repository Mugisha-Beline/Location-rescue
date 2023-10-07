import 'package:flutter/material.dart';

void main() {
  runApp(const DescriptionScreenApp());
}

class DescriptionScreenApp extends StatelessWidget {
  const DescriptionScreenApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location App',
      theme: ThemeData(
        primarySwatch: Color.fromARGB(255, 45, 116, 192),
      ),
      home: const DescriptionScreenApp(title: 'Places and Description'),
    );

}
}


/* This class is similar to MyApp instead it
returns Scaffold Widget */
class DescriptionScreenApp extends StatelessWidget {
  const DescriptionScreenApp({Key? key, required this.title}) : super(key: key);
  final String title;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // Sets the content to the
      // center of the application page
      body: const Center(
          // Sets the content of the Application
          child: Text(
        'Welcome to YOur location provider!',
      )),
    );
  }
}