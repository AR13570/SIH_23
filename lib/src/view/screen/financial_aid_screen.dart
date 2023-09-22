import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/controller/SubsidaryController.dart';
import 'package:url_launcher/url_launcher.dart';

class FinancialScreen extends StatelessWidget {
  FinancialScreen({super.key});

  SubsidaryController _c = Get.put(SubsidaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.green,
        title: const Text(
          'Financial Aid',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Center(
        child: Obx(() {
          if (_c.subsidiaries.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: _c.subsidiaries.length,
              itemBuilder: (context, int index) => Container( padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                    color: Colors.white12
                ),
                child: ExpansionTile(
                  trailing: Icon(
                      Icons.link
                  ),
                  title: InkWell(
                      onTap: () async {
                        String formattedUrl = _c.subsidiaries[index].web;
                        if (!formattedUrl.contains("http")) {
                          formattedUrl = "http://$formattedUrl";
                        }
                        final Uri url = Uri.parse(formattedUrl);
                        //final url = 'https://vikaspedia.in' + list[index].href;
                        await launchUrl(url);
                      },
                      child: Text(_c.subsidiaries[index].name,
                        style:TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 17
                        ),)),
                  subtitle: Text(_c.subsidiaries[index].web),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Column(
                        children: [
                          Text(_c.subsidiaries[index].data,
                            ),
                          Text(_c.subsidiaries[index].cinfo)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.download),
        backgroundColor: Colors.green,
        label: const Text("Interest Rates"),
        onPressed: () async {
          final Uri url = Uri.parse(
              "https://drive.google.com/uc?id=1TSZ5ENkrKQ1K_qJIuVbyGwAs2mqQWG6B&export=download");
          await launchUrl(url);
        },
      ),
    );
  }
}
