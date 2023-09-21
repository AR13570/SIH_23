import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/view/screen/bottom_navbar.dart';
import 'package:office_app_store/src/view/widget/bottom_bar.dart';

class PostBottomSheet extends StatelessWidget {
  final MessageType messageType;
  final String? messageId;
  PostBottomSheet({super.key, required this.messageType, this.messageId});

  final TextEditingController _messageTextController =
      TextEditingController(text: "random text ${Random().nextInt(100)}");
  final RxBool isExpert = false.obs;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.6,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              loggedInUser.value.name,
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.comment),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Add a comment...',
                      ),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (messageType == MessageType.post) {
                  messageController.postMessage(
                      message: _messageTextController.text,
                      name: loggedInUser.value.name,
                      isExpert: loggedInUser.value.isExpert);
                } else {
                  messageController.postReply(
                      message: _messageTextController.text,
                      name: loggedInUser.value.name,
                      isExpert: loggedInUser.value.isExpert,
                      messageId: messageId!);
                }
              },
              child: Text(messageType == MessageType.post ? 'Post' : 'Reply'),
            ),
          ],
        ),
      ),
    );
  }
}
