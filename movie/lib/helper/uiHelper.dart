// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
String moviesTitle1 = "Trendler";
String hintTitle = "Film ara";
String appTitle = "Movies";
class customPadding extends StatelessWidget {
  const customPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(8));
  }
}

class CustomText extends StatelessWidget  {
  const CustomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(moviesTitle1, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),);
  }
}