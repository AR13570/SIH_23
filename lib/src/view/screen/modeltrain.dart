import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';


class Classifier extends StatefulWidget {
  static const String id = 'catDogClassifier';

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
  late List _output;
  final picker = ImagePicker();

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
      if(!_loading &&_output != null)
      {
      }
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
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          title: Text(
            'Disease Classifier',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.004, 1],
                colors: [
                  Colors.teal,
                  Colors.tealAccent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    'Detect dissorder',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 28),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: _loading
                      ? Container(
                    width: 250,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/img1.png'),
                        SizedBox(height: 50),
                      ],
                    ),
                  )
                      : Container(
                      child: Column(
                        children: <Widget>[
                          Stack(
                              children: [
                                Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    color: Colors.white,
                                    height: 250,
                                    child: Image.file(_image),
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          _output != null
                              ? Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text('${_output[0]['label'].substring(2)}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                          )
                              : Container(),
                        ],
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          onPressed: pickImage,
                          icon: Icon(Icons.camera_alt_outlined,size: 35,color: Colors.white,)
                      ),
                      IconButton(
                          onPressed: pickGalleryImage,
                          icon: Icon(Icons.photo_library_outlined,size: 35,color: Colors.white,)
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _loading?Container()
                    :Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10),
                    child: _output != null
                        ? Container(
                      child: IconButton(
                          onPressed: (){
                          },
                          icon: Icon(Icons.info,size: 35,color: Colors.white,)
                      ),
                    )
                        :Container()
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
