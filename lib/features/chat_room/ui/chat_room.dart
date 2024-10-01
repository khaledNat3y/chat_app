import 'package:chat_app/features/chat_room/ui/widgets/custom_chat_room_message.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import '../../../core/helper/shared_preferences.dart';
import '../../../core/theming/app_colors.dart';
import '../data/model/message_model.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _userMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // Add ScrollController

  static var apiKey = dotenv.env['API_KEY'];

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey as String);

  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.cacheInitialization().then((_) {
      loadMessagesFromPrefs();
    });
  }

  @override
  void dispose() {
    _userMessageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).chat_room),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      controller: _userMessageController,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(50)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.deepOrange),
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.blue),
                            borderRadius: BorderRadius.circular(50)),
                        label: Text(S.of(context).ask_gemini),
                        labelStyle: const TextStyle(color: AppColors.grey),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(15),
                    iconSize: 30,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(const CircleBorder()),
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
    final message = _userMessageController.text;
    _userMessageController.clear();

    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    _scrollToBottom();

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

    _scrollToBottom();

    await saveMessagesToPrefs();
  }
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> saveMessagesToPrefs() async {
    final List<String> messagesToSave = _messages.map((message) {
      return '${message.isUser}|${message.message}|${message.date.toIso8601String()}';
    }).toList();

    await SharedPreferencesHelper.setData(key: 'chat_messages', value: messagesToSave);
  }

  Future<void> loadMessagesFromPrefs() async {
    final List<String>? savedMessages = SharedPreferencesHelper.getData(key: 'chat_messages') as List<String>?;

    if (savedMessages != null && savedMessages.isNotEmpty) {
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
      _scrollToBottom();
    }
  }
}
