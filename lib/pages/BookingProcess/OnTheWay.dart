import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/RateDriver.dart';
import 'package:velocito/pages/BookingProcess/Ride/DriverDetails.dart';

class OnTheWay extends StatefulWidget {
  const OnTheWay({super.key});

  @override
  State<OnTheWay> createState() => _OnTheWayState();
}

class _OnTheWayState extends State<OnTheWay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'On the way',
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [Image.asset('assets/map1.png')],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 320,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        historyBox(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Material(
                            color: Color.fromRGBO(196, 196, 196, 0.2),
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/cardimg.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(width: 10,),
                                      Text('**** **** 4226',style: TextStyle(fontFamily: 'Arimo',fontSize: 12,fontWeight: FontWeight.w700,color: Color.fromRGBO(62, 73 ,88, 1)),)
                                    ],
                                  ),
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[
                                        Icon(LineIcons.indianRupeeSign,size: 15,color: Colors.black,),
                                        SizedBox(width: 2,),
                                        Text('106.98',style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Arimo',
                                            color:
                                            Colors.black,
                                            fontWeight: FontWeight.bold),),
                                      ]
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 2,
                          color: Color.fromRGBO(255, 51, 51, 0.9),
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => RateDriver()));
                            },
                            child:  Text(
                              "Cancel booking",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Arimo',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding historyBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(151, 173, 182, 0.2)),
            borderRadius: BorderRadius.circular(10),
          ),
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
      ),
    );
  }
}
