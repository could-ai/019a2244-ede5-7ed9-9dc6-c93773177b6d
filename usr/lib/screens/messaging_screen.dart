import 'package:flutter/material.dart';
import '../models/user_model.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final _messageController = TextEditingController();
  final List<Message> _messages = [
    // Mock messages
    Message(sender: 'Provider', content: 'Hello, I can help with your request!', timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
    Message(sender: 'You', content: 'Great, when can you start?', timestamp: DateTime.now().subtract(const Duration(minutes: 3))),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(
          sender: 'You',
          content: _messageController.text,
          timestamp: DateTime.now(),
        ));
      });
      _messageController.clear();
      // NOTE: Actual messaging requires Supabase real-time subscriptions and database
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return ListTile(
                      title: Text('${msg.sender}: ${msg.content}'),
                      subtitle: Text(msg.timestamp.toString()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(hintText: 'Type a message...'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}