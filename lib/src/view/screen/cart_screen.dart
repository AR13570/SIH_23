import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:office_app_store/core/app_color.dart';
import 'package:office_app_store/core/app_style.dart';
import 'package:office_app_store/src/controller/office_furniture_controller.dart';
import 'package:office_app_store/src/model/messageModel.dart';
import 'package:office_app_store/src/view/widget/counter_button.dart';
import 'package:office_app_store/src/view/widget/empty_widget.dart';
import '../widget/bottom_bar.dart';
import '../widget/cart_list_view.dart';
import 'home_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Forum", style: h2Style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Obx(() => ListView(
              children: messageController.messages
                  .map((Message element) => ExpansionTile(
                        title: Text(element.message),
                        children: element.replies
                            .map((e) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.message),
                                    Text(e.likes.toString() + " likes")
                                  ],
                                ))
                            .toList(),
                      ))
                  .toList(),
            )));
  }
}
