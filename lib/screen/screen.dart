import 'dart:async';

import 'package:flutter/material.dart';
class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacementNamed('/');
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Container(
            alignment: Alignment.center,
          child:Image.asset('assets/images/food-delivery.jpg'),
          ),
      ],
    ),
      );

  }
}
