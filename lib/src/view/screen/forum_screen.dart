import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/core/app_color.dart';
import 'package:office_app_store/src/controller/MessageController.dart';
import 'package:office_app_store/src/model/messageModel.dart';
import 'package:office_app_store/src/view/widget/message_widget.dart';
import 'package:office_app_store/src/view/widget/post_bottom_sheet.dart';
import '../../../core/app_style.dart';
import 'bottom_navbar.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Queries", style: h2Style),
      ),
      body: Stack(
        children: [
          Obx(() {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => MessageWidget(
                message: messageController.messages[index],
              ),
              separatorBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                color: Colors.grey,
                height: 1,
              ),
              itemCount: messageController.messages.length,
            );
          }),
          Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(PostBottomSheet(
                    messageType: MessageType.post,
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: screenWidth * 3 / 4,
                  height: screenHeight / 12,
                  decoration: BoxDecoration(
                    color: AppColor.lightOrange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.add,
                            color: Colors.yellowAccent,
                            size: screenHeight / 16),
                      ),
                      SizedBox(width: screenWidth / 20),
                      const Text(
                        "Post Quest",
                        style: h2Style,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
