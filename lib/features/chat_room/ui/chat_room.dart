import 'dart:convert';

import 'package:chat_app/core/helper/extensions.dart';
import 'package:chat_app/core/theming/app_colors.dart';
import 'package:chat_app/core/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/shared_preferences.dart';

class ChatRoom extends StatefulWidget {
  final String? title;
  const ChatRoom({super.key, this.title});

  @override
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoom> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];
  bool isSentByMe = true;

  @override
  void initState() {
    super.initState();
    _loadMessages(); // Load messages when the chat screen is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.white,),

        ),
        backgroundColor: AppColors.blue,
        elevation: 0,
        surfaceTintColor: AppColors.white,
        title: Text(widget.title ?? 'Chat Room', style: AppTheme.font24WhiteMedium,),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Card(
              elevation: 5,
              color: AppColors.white,
              margin: EdgeInsets.all(10.w), // Use ScreenUtil for responsiveness
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSentByMe = message['isSentByMe'];

                    return Align(
                      alignment: isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft, // Align based on sender
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 15.w,
                        ),
                        decoration: BoxDecoration(
                          color: isSentByMe ? AppColors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          message['message'],
                          style: TextStyle(
                            color: isSentByMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: AppColors.blue,
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.blue,
                  iconSize: 28.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = messageController.text;
    if (message.isNotEmpty) {
      setState(() {
        messages.add({"message": message, "isSentByMe": isSentByMe});
        messageController.clear();
        isSentByMe = !isSentByMe;
      });
      _scrollToBottom();
      _saveMessages(); // Save messages after sending
    }
  }

  // Function to scroll to the bottom of the ListView
  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // Load messages from SharedPreferences
  void _loadMessages() async {
    // Retrieve saved messages
    List<String>? savedMessages = SharedPreferencesHelper.getData(key: 'chat_messages') as List<String>?;
    if (savedMessages != null) {
      setState(() {
        messages = savedMessages.map((msg) {
          final Map<String, dynamic> message = jsonDecode(msg);
          return message;
        }).toList();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  // Save messages to SharedPreferences
  void _saveMessages() async {
    List<String> messageStrings = messages.map((msg) {
      return jsonEncode(msg);
    }).toList();
    await SharedPreferencesHelper.setData(key: 'chat_messages', value: messageStrings);
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
