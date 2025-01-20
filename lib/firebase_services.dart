import 'package:firebase_database/firebase_database.dart';

class FirebaseServices {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  /// Add feedback to the Firebase Realtime Database
  Future<void> addFeedback(String name, String email, String feedback) async {
    try {
      await _dbRef.child("feedbacks").push().set({
        "name": name,
        "email": email,
        "feedback": feedback,
        "timestamp": DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Error adding feedback: $e');
    }
  }

  /// Get a real-time stream of feedback sorted by timestamp
  Query getFeedbackStream() {
    return _dbRef.child("feedbacks").orderByChild("timestamp");
  }
}

/// Feedback Model Class
class FeedbackModel {
  final String name;
  final String email;
  final String feedback;
  final String timestamp;

  FeedbackModel({
    required this.name,
    required this.email,
    required this.feedback,
    required this.timestamp,
  });

  /// Factory method to create a FeedbackModel from a map
  factory FeedbackModel.fromMap(Map<dynamic, dynamic> map) {
    return FeedbackModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      feedback: map['feedback'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }

  /// Convert FeedbackModel to a map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "feedback": feedback,
      "timestamp": timestamp,
    };
  }
}

/// Helper to parse the real-time feedback stream into a list of FeedbackModel objects
Stream<List<FeedbackModel>> parseFeedbackStream(Query query) {
  return query.onValue.map((event) {
    final feedbackList = <FeedbackModel>[];
    final data = event.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      data.forEach((key, value) {
        feedbackList.add(FeedbackModel.fromMap(value));
      });
    }

    return feedbackList;
  });
}
