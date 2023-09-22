import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CropRecommendationScreen extends StatelessWidget {
  final CropRecommendationController controller = Get.put(CropRecommendationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Recommendation',
        style: TextStyle(
            color: Colors.black
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: controller.districtController,
              decoration: InputDecoration(labelText: 'Enter District'),
            ),
            TextField(
              controller: controller.monthController,
              decoration: InputDecoration(labelText: 'Enter Current Month'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.fetchRecommendation();
              },
              child: Text('Get Crop Recommendation'),
            ),
            SizedBox(height: 16),
            Obx(() {
              final recommendation = controller.result.value;
              if (recommendation.isEmpty) {
                return Text('No recommendation available');
              } else {
                return Text('Recommendation: $recommendation');
              }
            }),
          ],
        ),
      ),
    );
  }
}

class CropRecommendationController extends GetxController {
  TextEditingController districtController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  RxString result = RxString('');

  void fetchRecommendation() async {
    final district = districtController.text;
    final month = monthController.text;

    final apiUrl = 'http://192.168.89.132:5000/crop'; // Update with your API endpoint
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'district': district,
        'month': month,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final wholeYearCrop = data['whole_year_crop'] ?? 'No recommendation available';
      final topCrop = data['top_crop'] ?? 'No top crop recommendation available';

      result.value = 'Whole Year Crop: $wholeYearCrop\nTop Crop: $topCrop';
    } else {
      result.value = 'Error: Unable to fetch recommendation${response.statusCode}';
    }
  }
}
