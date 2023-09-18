import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/core/app_color.dart';
import 'package:office_app_store/src/view/screen/messagepost.dart';
import 'package:office_app_store/src/view/widget/empty_widget.dart';
import 'package:office_app_store/src/view/widget/furniture_list_view.dart';
import '../../../core/app_style.dart';
import 'home_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("USER QUERIES", style: h2Style),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               /* controller.favoriteFurnitureList.isNotEmpty
               ? FurnitureListView(
                        isHorizontal: false,
                        furnitureList: controller.favoriteFurnitureList,
                      )
                    : const EmptyWidget(type: EmptyWidgetType.favorite, title: "Empty"),*/
                GestureDetector(
                  onTap:() {
          Get.to(() => MessagePostingScreen());
          },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: screenWidth*3/4,
                    height: screenHeight/12,
                    decoration: BoxDecoration(
                      color: AppColor.lightOrange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         Container(
                           child: Icon(
                            Icons.add,
                            color: Colors.yellowAccent,
                            size: screenHeight/16
                        ),
                           decoration: BoxDecoration(
                             color: Colors.black12,
                             borderRadius: BorderRadius.circular(20),
                           ),
                         ),
                        SizedBox(width: screenWidth/20),
                        Container(child:
                        const Text("POST QUERY",
                        style: h2Style,)
                        )
                      ],
                    ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
