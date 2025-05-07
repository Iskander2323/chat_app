import 'package:chat_app/components/chat/bloc/chat_bloc.dart';
import 'package:chat_app/components/custom/widget/message_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({
    super.key,
    required this.userEmail,
    required this.userId,
  });

  final String userEmail;
  final String userId;

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userEmail)),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                if (state.messagesList.isNotEmpty) ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.messagesList.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return MessageBubbleWidget(
                          message: state.messagesList[index].message,
                          senderId: state.messagesList[index].senderId,
                          currentUserId: state.currentUserId,
                        );
                      },
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text('No messages yet.'),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          // Handle send message action
                          if (_messageController.text.isNotEmpty) {
                            context.read<ChatBloc>().add(
                              SendMessageEvent(
                                message: _messageController.text,
                              ),
                            );
                          }
                          _messageController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
