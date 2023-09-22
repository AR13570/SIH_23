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
        title: const Text(
          'Financial Aid',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Center(
        child: Obx(() {
          if (_c.subsidiaries.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: _c.subsidiaries.length,
              itemBuilder: (context, int index) => ExpansionTile(
                title: Text(_c.subsidiaries[index].name),
                subtitle: InkWell(
                  child: Text(_c.subsidiaries[index].web),
                  onTap: () async {
                    String formattedUrl = _c.subsidiaries[index].web;
                    if (!formattedUrl.contains("http")) {
                      formattedUrl = "http://$formattedUrl";
                    }
                    final Uri url = Uri.parse(formattedUrl);
                    //final url = 'https://vikaspedia.in' + list[index].href;
                    await launchUrl(url);
                  },
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      children: [
                        Text(_c.subsidiaries[index].data),
                        Text(_c.subsidiaries[index].cinfo)
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.download),
        onPressed: () async {
          final Uri url = Uri.parse("");
          await launchUrl(url);
        },
      ),
    );
  }
}
