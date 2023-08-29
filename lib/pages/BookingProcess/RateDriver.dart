import 'package:flutter/material.dart';
import 'package:velocito/pages/BookingProcess/RatingScreen.dart';

import 'PaymentOption.dart';
import 'TripEnded.dart';

class RateDriver extends StatefulWidget {
  const RateDriver({super.key});

  @override
  State<RateDriver> createState() => _RateDriverState();
}

class _RateDriverState extends State<RateDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Rate driver',
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Image.asset('assets/map.png')
                  ],
                ),
              ),
            ),
            Stack(
                clipBehavior: Clip.none,
                children:<Widget> [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                child: Divider(
                                  thickness: 3,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5,right: 5),
                                          child: Text('TN 39 BR 1446',style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text('Volkswagen Jeta',style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black54,
                                          fontSize: 14
                                      ))
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 30,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                SizedBox(
                                  width:140,
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color.fromRGBO(255, 51, 51, 0.9),
                                    child: MaterialButton(
                                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                      minWidth: MediaQuery.of(context).size.width,
                                      onPressed: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => RatingScreen()));
                                      },
                                      child:  Text(
                                        "Rate",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Arimo',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                    SizedBox(
                                      width: 140,
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        child: MaterialButton(
                                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                          minWidth: MediaQuery.of(context).size.width,
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => TripEnded()));
                                          },
                                          child:  Text(
                                            "Skip",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                ),
                                    ),
                                    ]
                                ),
                              ),

                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    top: -40,
                    child:
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child:
                            CircleAvatar(
                              radius: 40,
                              child:Image.asset('assets/driver.png'),)
                        ),
                        Text('Prithvi',style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 16
                        ))
                      ],
                    ),
                  ),

                ]
            ),
          ],
        )
    );
  }
}
