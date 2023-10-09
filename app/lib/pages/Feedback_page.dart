import 'package:flutter/material.dart';

void main() {
  runApp(const FeedbackPage());
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FEEDBACK FORM'),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4.0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.black,
            height: 1.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Feedback',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Feedback..........',
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: screenWidth,  // Adjusted to screen width
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.create),
                label: const Text('CREATE FEEDBACK'),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: const Color(0xFFe6aa07),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  elevation: 4.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
