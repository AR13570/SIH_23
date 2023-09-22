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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => FinancialScreen());
        },
        label: Text('Financial Aid'),
        icon: Icon(Icons.monetization_on_outlined),
        backgroundColor: Colors.green,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 80, top: 20),
              itemCount: list.length,
              separatorBuilder: (ctx, index) => const Divider(
                indent: 8,
                endIndent: 8,
              ),
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                  color: Colors.white12
                ),
                child: ListTile(
                  onTap: () async {
                    final Uri url = Uri.parse(list[index].href);
                    //final url = 'https://vikaspedia.in' + list[index].href;
                    await launchUrl(url);
                  },
                  title: Text(list[index].title,
                  style: TextStyle(
                    color: Colors.blueGrey
                      ,
                        fontSize: 17

                  ),),
                  trailing:  Icon(
                      Icons.link
                  ),
                  subtitle: Text(list[index].desc,
                    style: TextStyle(
                        color: Colors.black38
                        ,


                    ),),

                  //subtitle: Text(list[index].desc), // Display the href
                ),
              ),
            ),
    );
  }
}
