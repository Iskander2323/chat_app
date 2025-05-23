import 'package:chat_app/components/chat/bloc/chat_bloc.dart';
import 'package:chat_app/components/custom/widget/message_bubble_widget.dart';
import 'package:chat_app/components/data/model/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({
    super.key,
    required this.name,
    required this.userEmail,
    required this.userId,
  });
  final String name;
  final String userEmail;
  final String userId;

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  TextEditingController _messageController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<ShowMessage> _localMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: BlocListener<ChatBloc, ChatState>(
        listenWhen:
            (previous, current) =>
                previous.messagesList.length != current.messagesList.length,
        listener: (context, state) {
          final newMessages = state.messagesList;
          if (newMessages.length > _localMessages.length) {
            final addedMessage = newMessages.first;
            _localMessages.insert(0, addedMessage);
            _listKey.currentState?.insertItem(0);
          }
        },
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state.messagesList.isNotEmpty) {
              _localMessages = List.from(state.messagesList);
            }
            return SafeArea(
              child: Column(
                children: [
                  if (state.messagesList.isNotEmpty) ...[
                    Expanded(
                      child: AnimatedList(
                        key: _listKey,
                        reverse: true,
                        initialItemCount: _localMessages.length,
                        itemBuilder: (context, index, animation) {
                          final msg = _localMessages[index];
                          return SizeTransition(
                            sizeFactor: animation,
                            child: MessageBubbleWidget(
                              message: msg.message,
                              senderId: msg.senderId,
                              currentUserId: state.currentUserId,
                            ),
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
      ),
    );
  }
}
