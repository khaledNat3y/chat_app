import 'package:chat_app/features/chat_room/ui/widgets/custom_chat_room_message.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/helper/shared_preferences.dart';
import '../../../core/theming/app_colors.dart';
import '../data/models/message_model.dart';

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
          title: Text(AppLocalizations.of(context)!.chat_room),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return CustomChatRoomMessage(
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
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(50)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepOrange),
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: AppColors.blue),
                            borderRadius: BorderRadius.circular(50)),
                        label: Text(AppLocalizations.of(context)!.ask_gemini),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(15),
                    iconSize: 30,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(AppColors.primaryColor),
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

