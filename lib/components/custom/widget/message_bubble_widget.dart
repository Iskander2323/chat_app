import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    super.key,
    required this.message,
    required this.senderId,
    required this.currentUserId,
  });

  final String message;
  final String senderId;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = senderId == currentUserId;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * 0.7, // max 70% of screen
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue[200] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  isCurrentUser ? const Radius.circular(12) : Radius.zero,
              bottomRight:
                  isCurrentUser ? Radius.zero : const Radius.circular(12),
            ),
          ),
          child: Text(message, style: const TextStyle(fontSize: 16.0)),
        ),
      ),
    );
  }
}
