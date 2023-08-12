import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/PaymentOption.dart';

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
                  height: 500,
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
                          SizedBox(height: 40,),
                              historyBox(),
                          SizedBox(height: 40,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30),
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromRGBO(255, 51, 51, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => PaymentOption()));
                                },
                                child:  Text(
                                  "Make payment",
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
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PhysicalModel(
                                elevation:2,
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                child:
                              CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    await FlutterPhoneDirectCaller.callNumber('7373994102');
                                  },
                                  child:Icon(
                                  LineIcons.phoneVolume,
                                  color:
                                  Color.fromRGBO(255, 51, 51, 0.8),
                                  size: 25,
                                ),
                              ),
                              ),
                              ),
                              PhysicalModel(
                                elevation:2,
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                child:
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                  Colors.white,
                                  child: InkWell(
                                    onTap: (){

                                    },
                                    child:Icon(
                                    LineIcons.times,
                                    color:
                                    Color.fromRGBO(255, 51, 51, 0.8),
                                    size: 25,
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          )
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
  Padding historyBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: SizedBox(
          height: 150,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '18:45',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                              ),
                            ),
                            Text('19:00',
                                style: TextStyle(
                                  fontFamily: 'Arimo',
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Color.fromRGBO(255, 51, 51, 0.8),
                              size: 10,
                            ),
                            Container(
                              height: 60,
                              child: VerticalDivider(
                                color: Colors.black54,
                                thickness: 2,
                                indent: 2,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          child: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '59/Amman Street,Tirupur,641603',
                                  style: TextStyle(
                                      fontFamily: 'Arimo', color: Colors.grey),
                                ),
                                Text(
                                  'Bannari Amman Institute of Technology,Sathy',
                                  style: TextStyle(
                                      fontFamily: 'Arimo', color: Colors.grey),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

