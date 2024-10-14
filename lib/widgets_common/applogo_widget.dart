import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart'; 

Widget applogowidget() {
  return ClipOval( 
    child: Image.asset(
      "assets/images/1.jpeg",
      width: 90, 
      height: 90, 
      fit: BoxFit.cover, 
    ).box
      .color(Colors.white) 
      .padding(const EdgeInsets.all(8)) 
      .rounded 
      .make(),
  );
}
