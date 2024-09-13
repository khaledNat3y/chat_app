import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import '../../../core/helper/shared_preferences.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _userMessage = TextEditingController();

  static const apiKey = "AIzaSyBCb1wOnFEWNqedFftsQwJGc1YGw6G5Z3A";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.cacheInitialization().then((_) {
      loadMessagesFromPrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Room'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Messages(
                    isUser: message.isUser,
                    message: message.message,
                    date: DateFormat('HH:mm').format(message.date),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      controller: _userMessage,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepOrange),
                            borderRadius: BorderRadius.circular(50)),
                        label: const Text("Ask Gemini..."),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(15),
                    iconSize: 30,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.deepPurple),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        const CircleBorder(),
                      ),
                    ),
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            )
          ],
        ));
  }
  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    // Add the user's message
    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    // Save updated messages to SharedPreferences
    await saveMessagesToPrefs();

    // Send the message to the AI model
    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    // Add AI response
    setState(() {
      _messages.add(Message(
        isUser: false,
        message: response.text ?? "",
        date: DateTime.now(),
      ));
    });

    // Save updated messages to SharedPreferences
    await saveMessagesToPrefs();
  }
  Future<void> saveMessagesToPrefs() async {
    final List<String> messagesToSave = _messages.map((message) {
      return '${message.isUser}|${message.message}|${message.date.toIso8601String()}';
    }).toList();

    await SharedPreferencesHelper.setData(key: 'chat_messages', value: messagesToSave);
  }
  Future<void> loadMessagesFromPrefs() async {
    final List<String>? savedMessages = SharedPreferencesHelper.getData(key: 'chat_messages') as List<String>?;

    if (savedMessages != null) {
      setState(() {
        _messages.addAll(savedMessages.map((savedMessage) {
          final parts = savedMessage.split('|');
          return Message(
            isUser: parts[0] == 'true',
            message: parts[1],
            date: DateTime.parse(parts[2]),
          );
        }).toList());
      });
    }
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? Colors.deepPurple : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          bottomLeft: isUser ? const Radius.circular(30) : Radius.zero,
          topRight: const Radius.circular(30),
          bottomRight: isUser ? Radius.zero : const Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}
// AIzaSyBCb1wOnFEWNqedFftsQwJGc1YGw6G5Z3A
