import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery/splash_screen.dart';
import 'package:get/get.dart';
const Color darkFontGrey = Color.fromRGBO(62, 68, 71, 1);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA8wyXLHNtZSx0M-2-vXo70GC795IC2W0I",
        authDomain: "grocery-79244.firebaseapp.com",
        projectId: "grocery-79244",
        appId: "1:349103359427:android:6aa02127d7edca09e1a976",
        messagingSenderId: "349103359427",
        storageBucket: "grocery-79244.appspot.com",
      ),
    );
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Grocery",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: darkFontGrey,
          ),
          backgroundColor: Colors.transparent,
        ),
        fontFamily: "sans_regular",
      ),
      home: SplashScreen(),
    );
  }
}
