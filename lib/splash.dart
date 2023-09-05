import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocito/LoginSignup/Login.dart';
import 'package:velocito/LoginSignup/SelectOption.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState(){
    super.initState();

    Timer(Duration(seconds: 3), () =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectOption())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 51, 51, 0.9),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/splashimg.png',
              height: 250,
                width: 250,
              ),
              SizedBox(height: 25,),
              Text('Velocito',style: TextStyle(fontFamily: 'Nova',fontSize: 50,color: Colors.white),)
            ],
          ),
      ),
    );
  }
}
