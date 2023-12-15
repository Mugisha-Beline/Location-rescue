
import 'package:app/pages/feedback_page.dart';
import 'package:flutter/material.dart';
import '../datamanagers/database_manager.dart';

class MapPage extends StatelessWidget {
  final List<LocationItem> locationItems;

  const MapPage({Key? key, required this.locationItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black,
            height: 1.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        title: const Text(
          'map view',
          textAlign: TextAlign.center,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // GoogleMap widget
            Container(
              width: screenWidth,
              height: screenHeight / 2,
              color: Colors.grey, // Placeholder color
              child: Center(
                child: Text('GoogleMap Placeholder'),
              ),
            ),

            // Additional content container
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Button for more details about the hotel
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality to handle more details about the hotel
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('MORE DETAILS ABOUT HOTEL'),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      primary: const Color(0xFFe6aa07),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      elevation: 4.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Check the Google Map below.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),

                  // Button to indicate 'DONE'
                  SizedBox(
                    width: 200.0,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                FeedbackPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('DONE'),
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
          ],
        ),
      ),
      // FloatingActionButton for feedback
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the FeedbackPage
          Navigator.of(context).pushReplacementNamed('/feedback');
        },
        child: Icon(Icons.feedback),
      ),
    );
  }
}
