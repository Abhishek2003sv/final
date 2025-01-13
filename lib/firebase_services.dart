import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add feedback to Firestore
  Future<void> addFeedback(String name, String feedback, String message) async {
    try {
      await _firestore.collection('feedback').add({
        'name': name,
        'feedback': feedback,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error adding feedback: $e');
    }
  }
}
