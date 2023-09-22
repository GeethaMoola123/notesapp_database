
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{
  static CustomTextField(
      TextEditingController controller,
      String text,
      IconData iconData){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24)
        ),
      ),
    );
  }
}
//import html
//import js