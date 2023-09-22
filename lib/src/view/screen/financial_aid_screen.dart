import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_app_store/src/controller/SubsidaryController.dart';

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
        child: ListView(
          children: [
            Obx(() {
              if (_c.subsidiaries.isEmpty) {
                return CircularProgressIndicator();
              } else {
                return ExpansionTile(
                  title: Text("Subidiaries"),
                  children: [
                    ListView.builder(
                      itemCount: _c.subsidiaries.length,
                      itemBuilder: (context, int index) => ExpansionTile(
                        title: Text(_c.subsidiaries[index].name),
                        subtitle: Text(_c.subsidiaries[index].web),
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
                    )
                  ],
                );
              }
            }),
            Obx(() {
              if (_c.interests.isEmpty) {
                return CircularProgressIndicator();
              } else {
                return ExpansionTile(
                  title: Text("Interests"),
                  children: [
                    ListView.builder(
                        itemCount: _c.interests.length,
                        itemBuilder: (context, int index) => ListTile(
                              title: Text(_c.interests[index].loanInfo),
                              subtitle: Text(_c.interests[index].interest),
                            ))
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
