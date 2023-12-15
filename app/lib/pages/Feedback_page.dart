import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../datamanagers/feedback_manager.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController feedbackController = TextEditingController();
  FeedbackManager feedbackManager = FeedbackManager();

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
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
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Feedback..........',
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: screenWidth,
              child: ElevatedButton.icon(
                onPressed: () async {
                  String feedbackText = feedbackController.text.trim();

                  if (feedbackText.isNotEmpty) {
                    bool success =
                        await feedbackManager.createFeedback(feedbackText);

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Feedback created successfully.'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Navigator.pop(context);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Failed to create feedback. Please try again.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter your feedback.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
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