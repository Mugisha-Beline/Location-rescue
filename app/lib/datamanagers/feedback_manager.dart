import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackManager {
  final CollectionReference feedbackCollection = FirebaseFirestore.instance.collection('feedback');

  Future<bool> createFeedback(String feedbackText) async {
    try {
      await feedbackCollection.add({
        'text': feedbackText,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return true; // Return true if feedback creation is successful
    } catch (e) {
      print('Error creating feedback: $e');
      return false; // Return false if there's an error
    }
  }
}
