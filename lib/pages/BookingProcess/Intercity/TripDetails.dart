import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:velocito/pages/HomePage.dart';
import 'package:velocito/pages/HomeScreen.dart';

import '../../../Models/user_model.dart';
import '../Ride/DriverDetails.dart';

class TripDetails extends StatefulWidget {
  final String from;
  final String to;
  final String trip;
  final String vec;
  final String deptdate;
  final String depttime;
  final String returndate;
  final String returntime;
  final String adult;
  final String child;
  final String dist;
  final String est;
  const TripDetails(
      {super.key,
      required this.from,
      required this.to,
      required this.trip,
      required this.vec,
      required this.deptdate,
      required this.depttime,
      required this.returndate,
      required this.returntime,
      required this.adult,
      required this.child, required this.dist, required this.est});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('IntercityRequests');
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("users");
  late DatabaseReference _userRef;
  String? sts;
  late String date;
  late String fromtime;
  late String totime;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    _userRef = FirebaseDatabase.instance.ref().child('Requests');
    sts = '';
    _userRef.child(user!.uid).onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as dynamic);
        setState(() {
          sts = data['STATUS'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Trip details',
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 450,
                child: Selection(),
              ),
            ],
          ),
        ]));
  }

  Material Selection() {
    return Material(
        elevation: 5,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Change',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    color: Color.fromRGBO(255, 51, 51, 0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  (widget.vec == "Sedan")
                                      ? "assets/taxi4.png"
                                      : "assets/taxi7.png",
                                  height: 50,
                                  width: 80,
                                ),
                              ]),
                              Row(children: [
                                Text(
                                  'Total cost : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  LineIcons.indianRupeeSign,
                                  size: 13,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  cost(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ]),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.vec}',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                              ),
                            ),
                            Container(
                              height: 20,
                              child: VerticalDivider(
                                color: Color.fromRGBO(255, 51, 51, 0.8),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                (widget.vec == 'Sedan')
                                    ? Text(
                                        '4 seats',
                                        style: TextStyle(
                                            fontFamily: 'Arimo',
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        '7 seats',
                                        style: TextStyle(
                                            fontFamily: 'Arimo',
                                            fontWeight: FontWeight.bold),
                                      )
                              ],
                            ),
                            Container(
                              height: 20,
                              child: VerticalDivider(
                                color: Color.fromRGBO(255, 51, 51, 0.8),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  '3 mins',
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking details',
                    style: TextStyle(
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child:
                      Text(
                        widget.from,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                        fontFamily: 'Arimo',
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                      ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.to,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Departure Date & Time',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${widget.deptdate} - ${widget.depttime}',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  if (widget.returndate != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 160,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Return Date & Time',
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    ': ',
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${widget.returndate} - ${widget.returntime}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Travellers',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                            Text(
                              ': ',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${widget.adult} Adults ${widget.child} Children',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Estimated trip time',
                    style: TextStyle(
                        fontFamily: 'Arimo', color: Colors.grey, fontSize: 13),
                  ),
                  Text(
                    widget.est,
                    style: TextStyle(
                        fontFamily: 'Arimo',
                        color: Color.fromRGBO(255, 51, 51, 0.8),
                        fontSize: 13),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 2,
                color: Color.fromRGBO(255, 51, 51, 0.9),
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    Map<String, String> Requests = {
                      'FROM': widget.from,
                      'TO': widget.to,
                      'VEHICLE': widget.vec,
                      'TRIP-TYPE': widget.trip,
                      'COST': cost(),
                      'PASSENGER-NAME': '${loggedInUser.name}',
                      'PASSENGER-NUMBER': '${loggedInUser.phoneno}',
                      'PASSENGER-ID': '${loggedInUser.uid}',
                      'STATUS': 'REQUESTED',
                      'CHILD': widget.child,
                      'ADULTS': widget.adult,
                      'DEPARTURE-TIME': widget.depttime,
                      'DEPARTURE-DATE': widget.deptdate,
                      'DISTANCE':'${widget.dist} km',
                      'ESTIMATED-TRAVEL':widget.est,
                      'RETURN-DATE': widget.returndate,
                      'RETURN-TIME': widget.returntime,
                      'DRIVER-NAME':' ',
                      'DRIVER-NUMBER':' ',
                      'VEHICLE-TYPE':' ',
                      'VEHICLE-MAKE':' ',
                      'VEHICLE-NMUMBER':' ',
                      'NOTIFICATION':'1',
                    };
                    dbRef.push().set(Requests);
                    Fluttertoast.showToast(
                        msg: "Cab requested, check for status");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    "Book",
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
        ));
  }

  String cost() {
    double fare = 0;
    if (widget.vec == 'Sedan') {

        fare = 200 +
            (double.parse(widget.dist) * (double.parse(widget.adult)) +
                (double.parse(widget.dist) * (double.parse(widget.child))) / 2);
        if(widget.trip!='One-way')
          fare=fare*2;
    } else {
      fare = 400 +
          (double.parse(widget.dist)  * (double.parse(widget.adult)) +
              (double.parse(widget.dist)  * (double.parse(widget.child)))/2);
      if(widget.trip!='One-way')
        fare=fare*2;
    }
    return fare.toStringAsFixed(2);
  }
}
