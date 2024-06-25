import 'package:flutter/material.dart';
import 'package:streams_exercises/features/chat/chat_message.dart';
import 'package:streams_exercises/features/chat/chat_repository.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.chatRepository,
  });

  final ChatRepository chatRepository;
  final Stream<ChatMessage> chatmessages = ChatRepository().getMessageStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Center(
        child: StreamBuilder<ChatMessage>(
          stream: chatRepository.getMessageStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Icon(Icons.error));
            } else if (snapshot.hasData) {
              final message = snapshot.data;
              return Center(child: Text('Message: ${message?.content}'));
            } else {
              return const Center(child: Icon(Icons.error));
            }
          },
        ),
      ),
    );
  }
}
