import 'package:flutter/material.dart';
 
void main() {
  runApp(const MapApp());
}
 

class MapApp extends StatelessWidget {
  const MapApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Location Application',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // Inner UI of the application
      home: const MapPage(title: 'Google Map'),
    );
  }
}
 

class MapPage extends StatelessWidget {
  const MapPage({Key? key, required this.title}) : super(key: key);
  final String title;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      
      body: const Center(
          
          child: Text(
        'Here is a map to your location',
      )),
    );
  }
}