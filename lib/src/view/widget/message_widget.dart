import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/model/messageModel.dart';
import 'package:office_app_store/src/view/widget/bottom_bar.dart';
import 'package:office_app_store/src/view/widget/post_bottom_sheet.dart';
import 'package:office_app_store/src/view/widget/reply_widget.dart';

import '../screen/bottom_navbar.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ExpansionTile(
        //collapsedBackgroundColor: Colors.grey.shade300,
        textColor: Colors.black,
        backgroundColor: Colors.grey,
        childrenPadding: const EdgeInsets.all(15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message.message,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                InkWell(
                  child: const Chip(label: Text("Reply")),
                  onTap: () {
                    Get.bottomSheet(PostBottomSheet(
                      messageType: MessageType.reply,
                      messageId: message.messageId,
                    ));
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                Chip(
                  label: Text("${message.likes.length}"),
                  deleteIcon: Icon(
                    !message.likes.contains(loggedInUser.value.phone)
                        ? Icons.thumb_up
                        : Icons.thumb_down,
                    size: 17,
                  ),
                  onDeleted: () {
                    messageController.like(
                      messageType: MessageType.post,
                      messageId: message.messageId,
                    );
                  },
                ),
              ],
            )
          ],
        ),
        subtitle: message.replies.isNotEmpty
            ? Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: Text(
                    "${message.replies.length} ${message.replies.length > 1 ? "replies" : "reply"}",
                    style: TextStyle(color: Colors.blueAccent.shade200),
                  ),
                ),
              )
            : null,
        trailing: null,
        children: message.replies.isNotEmpty
            ? message.replies
                .map((Reply reply) => ReplyWidget(
                      reply: reply,
                      messageId: message.messageId,
                      selected: reply.likes.contains(loggedInUser.value.phone),
                    ))
                .toList()
            : [
                const Text(
                  "No comments yet",
                  textAlign: TextAlign.center,
                )
              ],
      );
    });
  }
}
