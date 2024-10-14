import 'package:grocery/firebase_consts.dart';
import 'package:grocery/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';
import 'package:grocery/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [

            "Welcome to GroceryMart!"
                .text
                .fontFamily("sans_bold")
                .size(28) 
                .bold 
                .make(), 

            20.heightBox, 

          
            Container(
              width: 300.0, 
              height: 300.0, 
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                border:
                    Border.all(color: Colors.black, width: 5), 
              ),
              child: ClipOval(
                child: applogowidget(), 
              ),
            ),

            20.heightBox, 
            "Grocery".text.fontFamily("sans_bold").size(22).black.make(),
            5.heightBox,
            "Version 1.0.0".text.black.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
