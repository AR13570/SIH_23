import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:lottie/lottie.dart';
import 'package:office_app_store/core/app_style.dart';
import 'package:office_app_store/src/view/screen/bottom_navbar.dart';
import 'package:office_app_store/src/view/widget/bottom_bar.dart';

class Classifier extends StatefulWidget {
  static const String id = 'catDogClassifier';

  const Classifier({super.key});

  @override
  _Classifier createState() => _Classifier();
}

class _Classifier extends State<Classifier> {
  /*_CatDogClassifierState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton("02eb10e51a43084a1477f095cc91d6662e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }*/
  bool _loading = true;
  late File _image;
  List? _output;
  final picker = ImagePicker();
  var Disease_cure = {
    "Apple Scab": ['captan', 'mancozeb', 'myclobutanil'],
    "Apple Black Rot": ['captan', 'mancozeb', 'myclobutanil'],
    "Apple Cedar Rust": ['myclobutanil', 'mancozeb'],
    "Apple Healthy": ['Healthy Apple'],
    "Blueberry Healthy": ['Healthy Blueberry'],
    "Cherry Powdery Mildew": [
      'Bonide Sulfur Plant Fungicide',
      'Monterey LG3308 Liqui-Cop Copper'
    ],
    "Cherry Healthy": ['Healthy Cherry'],
    "Corn Cercospora Leaf Spot | Gray Leaf Spot": [
      'Quilt Xcel (Azoxystrobin + Propiconazole)',
      'Trivapro (Benzovindiflupyr + Azoxystrobin + Propiconazole)'
    ],
    "Corn Common Rust": [
      'Aproach Prima (Picoxystrobin + Cyproconazole)',
      'Tilt (Propiconazole)'
    ],
    "Corn Northern Leaf Blight": ['Delaro (Prothioconazole + Trifloxystrobin)'],
    "Corn Healthy": ['Healthy corn'],
    "Grape Black Rot": ['Mancozeb', 'Myclobutanil'],
    "Grape Esca | Black Measles": ['Tebuconazole', 'Endura'],
    "Grape Leaf Blight | Isariopsis Leaf Spot": ['Fluopyram'],
    "Grape Healthy": ['Healthy Grape'],
    "Orange Haunglongbing | Citrus Greening": ['Streptomycin'],
    "Peach Bacterial Spot": ['Kocide', 'Cuprofix Ultra 40 Disperss'],
    "Peach Healthy": ['Healthy fruit'],
    "Pepper Bell Bacterial Spot": ['Cuprofix Ultra 40 Disperss'],
    "Pepper Bell Healthy": ['Healthy crop'],
    "Potato Early Blight": ['Mancozeb', 'Chlorothalonil'],
    "Potato Late Blight": ['chlorothalonil', 'metalaxyl'],
    "Potato Healthy": ['Healthy potato'],
    "Raspberry Healthy": ['Healthy raspberry'],
    "Soybean Healthy": ['Healthy soybean'],
    "Squash Powdery Mildew": ['Myclobutanil'],
    "Strawberry Leaf Scorch": ['Propiconazole', 'Tebuconazole'],
    "Strawberry Healthy": ['Healthy fruit'],
    "Tomato Bacterial Spot": ['Kocide', 'Copper-Count-N'],
    "Tomato Early Blight": ['Chlorothalonil', 'Mancozeb'],
    "Tomato Late Blight": ['Metalaxyl'],
    "Tomato Leaf Mold": ['Cuprofix Ultra 40 Disperss'],
    "Tomato Septoria Leaf Spot": ['Kocide', 'Copper-Count-N'],
    "Tomato Spider Mites | Two-Spotted Spider Mite": ['Avid'],
    "Tomato Target Spot": ['Azoxystrobin'],
    "Tomato Yellow Leaf Curl Virus": ['No cure once a plant is infected'],
    "Tomato Mosaic Virus": ['Aphids to combat insects'],
    "Tomato Healthy": ['Healthy tomato']
  };
  var disease_prevention = {
    "Apple Scab": [
      "Choose resistant varieties when possible.",
      "Rake under trees and destroy infected leaves to reduce fungal spores available for reinfection next spring.",
      "Water in the evening or early morning hours (avoid overhead irrigation) to allow leaves to dry before infection can occur.",
      "Spread a 3- to 6-inch layer of compost under trees, away from the trunk, to prevent fungal spore splashing.",
      "For best control, spray liquid copper soap two weeks before symptoms normally appear. Alternatively, start at the first sign of disease and repeat every 7-10 days up to blossom drop."
    ],
    "Apple Black Rot": [
      "Prune and remove cankers at least 15 inches below the infected area and burn or bury them.",
      "Prune during the dormant season to minimize infection risk.",
      "Take precautions if bark is damaged by hail or branches break during windstorms.",
      "Use copper-based fungicide for protection against black rot and fire blight."
    ],
    "Apple Cedar Rust": [
      "Choose resistant cultivars when available.",
      "Rake and dispose of fallen leaves and debris from under trees.",
      "Remove galls from infected junipers; consider removing juniper plants entirely.",
      "Apply weekly preventative, disease-fighting fungicides starting at bud break to protect against spores from juniper hosts. Additional applications are not usually needed."
    ],
    "Apple Healthy": ["Maintain overall tree health for disease resistance."],
    "Blueberry Healthy": [
      "Maintain overall plant health for disease resistance."
    ],
    "Cherry Powdery Mildew": [
      "Disinfect pruning tools before use.",
      "Prune and discard diseased parts immediately.",
      "Apply fungicides per label instructions to protect remaining leaves throughout the season."
    ],
    "Cherry Healthy": ["Maintain overall tree health for disease resistance."],
    "Corn Cercospora Leaf Spot Gray Leaf Spot": [
      "Irrigate deeply but infrequently.",
      "Avoid post-emergent weed killers during disease activity.",
      "Use low to medium nitrogen fertilizer levels.",
      "Improve air circulation and light levels in the cornfield.",
      "Mow at the appropriate height and only when grass is dry."
    ],
    "Corn Common Rust": [
      "Plant corn with resistance to the fungus.",
      "If symptoms appear, promptly spray with a suitable fungicide."
    ],
    "Corn Northern Leaf Blight": [
      "Fungicides are most effective when applied at disease onset.",
      "Disease onset varies by growth stage, so monitor closely for optimal timing."
    ],
    "Corn Healthy": ["Maintain overall plant health for disease resistance."],
    "Grape Black Rot": [
      "Use Mancozeb or Nova fungicides to control black rot."
    ],
    "Grape Esca Black Measles": [
      "No effective control method exists; remove infected berries, leaves, and trunk and destroy them.",
      "Protect prune wounds with wound sealant, essential oil, or suitable fungicides."
    ],
    "Grape Leaf Blight Isariopsis Leaf Spot": [
      "Apply dormant sprays to reduce inoculum levels.",
      "Cut out infected parts of the plant.",
      "Maintain good canopy management and scouting practices.",
      "Use protectant and systemic fungicides.",
      "Consider fungicide resistance and monitor weather conditions."
    ],
    "Grape Healthy": ["Maintain overall vine health for disease resistance."],
    "Orange Haunglongbing Citrus Greening": [
      "Control ACP (Asian Citrus Psyllid) to prevent the spread of Citrus Greening Disease.",
      "Spray lemon trees with Neem oil insecticide, targeting both upper and lower leaf surfaces if necessary.",
      "Treat mold growth with liquid copper fungicide as needed."
    ],
    "Peach Bacterial Spot": [
      "Distinguish from peach scab and manage accordingly.",
      "Remove and destroy infected fruit and pruned tissue.",
      "Consider copper-based fungicides if necessary."
    ],
    "Peach Healthy": ["Maintain overall tree health for disease resistance."],
    "Pepper Bell Bacterial Spot": [
      "Select resistant varieties and use disease-free seed and transplants.",
      "Treat seeds with a bleach solution before planting.",
      "Mulch with organic material and avoid overhead watering.",
      "Remove and discard infected plant parts and debris at the end of the season.",
      "Apply fixed copper (organic fungicide) every 10-14 days for disease control.",
      "Rotate peppers to a different location if infections are severe and use soil cover before planting."
    ],
    "Pepper Bell Healthy": [
      "Maintain overall pepper plant health for disease resistance."
    ],
    "Potato Early Blight": [
      "Plant potato varieties resistant to the disease.",
      "Avoid overhead irrigation and ensure good plant spacing."
    ],
    "Potato Late Blight": [
      "Manage late blight with prophylactic sprays of mancozeb and systemic fungicides at disease onset."
    ],
    "Potato Healthy": [
      "Maintain overall potato plant health for disease resistance."
    ],
    "Raspberry Healthy": [
      "Maintain overall plant health for disease resistance."
    ],
    "Soybean Healthy": [
      "Maintain overall soybean plant health for disease resistance."
    ],
    "Squash Powdery Mildew": [
      "Spray a mixture of baking soda and liquid, non-detergent soap on plants.",
      "Consider using mouthwash as an alternative treatment."
    ],
    "Strawberry Leaf Scorch": [
      "Practice proper garden sanitation to remove infected debris.",
      "Frequently establish new strawberry transplants and create new plantings.",
      "Older plants are more susceptible to severe infection."
    ],
    "Strawberry Healthy": [
      "Maintain overall strawberry plant health for disease resistance."
    ],
    "Tomato Bacterial Spot": [
      "Use pathogen-free seed or transplants and soak seeds in a bleach solution.",
      "Avoid overhead watering and handle plants when dry.",
      "Sterilize tools and rotate with copper-based fungicides for disease control."
    ],
    "Tomato Early Blight": [
      "Prune or stake plants for better air circulation.",
      "Keep soil clean and use organic compost as mulch.",
      "Apply copper-based fungicides early or when symptoms appear."
    ],
    "Tomato Late Blight": [
      "Clean up garden debris and fallen fruit.",
      "Inspect plants regularly and use fungicides with maneb, mancozeb, chlorothanolil, or fixed copper."
    ],
    "Tomato Leaf Mold": [
      "Use calcium chloride-based sprays or organic fungicides."
    ],
    "Tomato Septoria Leaf Spot": [
      "Remove diseased leaves and improve air circulation.",
      "Use mulch, drip irrigation, and avoid overhead watering.",
      "Control weeds and practice crop rotation."
    ],
    "Tomato Spider Mites | Two-Spotted Spider Mite": [
      "Avoid weedy fields and prevent early-season, broad-spectrum insecticide applications.",
      "Do not over-fertilize, and monitor for pest populations."
    ],
    "Tomato Target Spot": [
      "Practice proper sanitation and plant care.",
      "Remove infected branches, keep plots weed-free, and do not use overhead irrigation.",
      "Use fungicidal sprays and consider crop rotation."
    ],
    "Tomato Yellow Leaf Curl Virus": [
      "Use virus- and whitefly-free transplants, treat seeds, and inspect plants for whitefly adults and eggs.",
      "Spray with appropriate insecticides to control whiteflies."
    ],
    "Tomato Mosaic Virus": [
      "Use certified disease-free seed or treat your own seed.",
      "Inspect transplants prior to purchase and wash hands when handling plants."
    ],
    "Tomato Healthy": [
      "Maintain overall tomato plant health for disease resistance."
    ]
  };

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  List<String> getCureList(String key) {
    return Disease_cure[key] ?? ['No cure found'];
  }

  List<String> getDiseaseList(String key) {
    return disease_prevention[key] ?? ['No cure found'];
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 8,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _output = output!;
      if (!_loading && _output != null) {}
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/models/model.tflite',
      labels: 'assets/models/Labels.txt',
    );
  }

  /*loadModel() async {
    await Tflite.loadModel(
      model: 'assets/catanddog/model_unquant.tflite',
      labels: 'assets/catanddog/labels.txt',
    );
  }*/

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {});
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FarmEz',
            style: TextStyle(
                color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Lottie.asset(
                        'assets/images/home_screen_animation.json',
                      ),
                    ),
                    Obx(() {
                      return Expanded(
                        child: Text("Hello, ${loggedInUser.value.name}",
                            style: h1Style),
                      );
                    }),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Plant Disease Detection',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: _loading
                      ? Container(
                          width: 200,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/img1.png',
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                          children: <Widget>[
                            Stack(children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                              ),
                              Center(
                                child: Container(
                                  color: Colors.white,
                                  height: 250,
                                  child: Image.file(_image),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 30,
                            ),
                            _output != null
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                        '${_output!.length > 0 ? _output![0]['label'] : ""}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  )
                                : Container(),
                          ],
                        )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          IconButton(
                              onPressed: pickImage,
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 35,
                                color: Colors.black,
                              )),
                          const Text('Camera',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: pickGalleryImage,
                              icon: const Icon(
                                Icons.photo_library_outlined,
                                size: 35,
                                color: Colors.black,
                              )),
                          const Text('Gallery',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // _loading
                //     ? Container()
                //     : Container(
                //         width: MediaQuery.of(context).size.width,
                //         margin: const EdgeInsets.only(top: 10),
                //         child: _output != null
                //             ? Container(
                //                 child: IconButton(
                //                     onPressed: () {},
                //                     icon: const Icon(
                //                       Icons.info,
                //                       size: 35,
                //                       color: Colors.black,
                //                     )),
                //               )
                //             : Container()),
                _output != null
                    ? Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Plant Protection Chemicals:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   itemCount:
                            //       getCureList(_output![0]['label']).length,
                            //   itemBuilder: (context, index) {
                            //     final cure =
                            //         getCureList(_output![0]['label'])[index];
                            //     return ListTile(
                            //       title: Text(
                            //         cure,
                            //         style: const TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 16.0,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: getCureList(_output![0]['label'])
                                    .map((element) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          margin: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.lightGreen),
                                            //color: Colors.lightGreen,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            element,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.lightGreen),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 20), // Add some spacing
                            // Display disease prevention information here
                            const Text(
                              'Disease Prevention Steps:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //   padding: const EdgeInsets.all(10),
                            //   //margin:EdgeInsets.all(8.0),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.lightGreen),
                            //     //color: Colors.lightGreen,
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   child:
                            //
                            // ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: getDiseaseList(_output![0]['label'])
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final int index = entry.key;
                                  final String element = entry.value;
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.lightGreen),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: // Add some spacing between number and text
                                        Text(
                                      '${index + 1}. ' + element,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey.shade500),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )

                            // Text(
                            //   disease_prevention[_output![0]['label']] ??
                            //       'No prevention information available',
                            //   style: const TextStyle(
                            //     color: Colors.black,
                            //     fontSize: 16.0,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.green.shade500,
                        Colors.green.shade500,
                        Colors.green.shade200
                      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green.shade300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'New to Farming?',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          controller.switchBetweenBottomNavigationItems(2);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Text(
                                "Click here",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
