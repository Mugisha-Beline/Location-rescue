import 'package:flutter/material.dart';

void main() {
  runApp(const DetailsPageApp());
}

class DetailsPageApp extends StatelessWidget {
  const DetailsPageApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const DetailsPage(title: 'Places and Description'),
    );

}
}


class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.title}) : super(key: key);
  final String title;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

      body:
/* https://docs.flutter.dev/ui/layout */
      
       GridView.count(
        
        crossAxisCount: 2,
        children: List.generate(4, (index){
          return Center(
            child: Text('Hotel Name $index',
            style: Theme.of(context).textTheme.headlineSmall,),);
        }), ),);
  }
}