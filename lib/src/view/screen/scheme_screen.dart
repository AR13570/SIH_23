import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/core/app_color.dart';
import 'package:office_app_store/core/app_style.dart';
import 'package:office_app_store/src/view/screen/financial_aid_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/scheme_model.dart';
import '../../services/scheme_service.dart';
import '../../services/schemrscrapper_service.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreen createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> {
  bool loading = false;
  List<PackageModel> list = [];

  @override
  initState() {
    super.initState();
    getPackages();
  }

  Future<void> getPackages() async {
    list.clear();
    loading = true;
    setState(() {});
    final html = await HttpService.get();
    if (html != null) list = ScrapeService.run(html);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Government Schemes',
          style: h2Style,
        ),
      ),
      body: Stack(
        children: [
          loading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (ctx, index) => const Divider(
                    indent: 8,
                    endIndent: 8,
                  ),
                  itemBuilder: (ctx, index) => ListTile(
                    onTap: () async {
                      final Uri url = Uri.parse(list[index].href);
                      //final url = 'https://vikaspedia.in' + list[index].href;
                      await launchUrl(url);
                    },
                    title: Text(list[index].title),
                    subtitle: Text(list[index].desc),
                    //subtitle: Text(list[index].desc), // Display the href
                  ),
                ),
          Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => FinancialScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(Icons.monetization_on_rounded,
                        color: Colors.green,
                        size: screenHeight / 12
                        ,)
                    ),
                    Text("Financial Aid",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                // Container(
                //   margin: const EdgeInsets.all(10),
                //   padding: const EdgeInsets.all(10),
                //   width: screenWidth /5,
                //   height: screenHeight / 12,
                //   // decoration: BoxDecoration(
                //   //   color: AppColor.lightOrange,
                //   //   borderRadius: BorderRadius.circular(20),
                //   // ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       // Container(
                //       //   decoration: BoxDecoration(
                //       //     color: Colors.black12,
                //       //     borderRadius: BorderRadius.circular(20),
                //       //   ),
                //       //   child:
                //       Icon(Icons.monetization_on_rounded,
                //             color: Colors.green,
                //             size: screenHeight / 12
                //       ,),
                //       //),
                //       // SizedBox(width: screenWidth / 20),
                //       // const Text(
                //       //   "Financial Aid",
                //       //   style: h2Style,
                //       //   textAlign: TextAlign.center,
                //       // )
                //     ],
                //   ),
                // ),
              )),
        ],
      ),
    );
  }
}
