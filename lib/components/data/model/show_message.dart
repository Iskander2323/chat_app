import 'package:cloud_firestore/cloud_firestore.dart';

class ShowMessage {
  final String message;
  final String senderId;
  final Timestamp timestamp;

  const ShowMessage({
    required this.message,
    required this.senderId,
    required this.timestamp,
  });
}
