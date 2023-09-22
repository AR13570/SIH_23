import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:office_app_store/core/app_theme.dart';
import 'package:office_app_store/src/view/screen/bottom_navbar.dart';
import 'package:office_app_store/src/view/screen/phone.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? 'home' // User is already logged in, navigate to your main screen
          : 'phone', // User is not logged in, navigate to the phone verification screen
      routes: {
        'home': (context) => BottomNavBar(),
        'phone': (context) => MyPhone(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
