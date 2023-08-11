import 'package:flutter/material.dart';

class DriverDetails extends StatefulWidget {
  const DriverDetails({super.key});

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Arriving',
            style: TextStyle(
                fontFamily: 'Arimo',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(62, 73, 88, 1.0)),
          ),
          centerTitle: true,
          toolbarHeight: 50,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [Image.asset('assets/map.png')],
                  ),
                ),
              ),
              Stack(
                  fit:StackFit.passthrough,
                  children:<Widget> [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 550,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(),
                      ),
                    )),
                Positioned(
                  height: -30,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      color: Color.fromRGBO(255, 51, 51, 0.2),
                      size: 45,
                    ),
                  ),
                ),
              ]

              ),
            ],
          ),
        ]));
  }
}
