import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/CancellationPage.dart';
import 'package:velocito/pages/BookingProcess/OnTheWay.dart';
import 'package:velocito/pages/BookingProcess/PaymentOption.dart';

import '../../../Models/user_model.dart';

class DriverDetails extends StatefulWidget {
  const DriverDetails({super.key});

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("users");
  late DatabaseReference _userRef;
  String name = '';
  String phn='';
  String from='';
  String to='';
  String fromtime='';
  String totime='';
  String cost='';
  String type = '';
  String make = '';
  String num = '';
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
    name = '';
    phn = '';
    from = '';
    to = '';
    cost = '';
    _userRef.child(user!.uid).onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as dynamic);
        setState(() {
          name = data['DRIVER-NAME'];
          phn = data['DRIVER-NUMBER'];
          from = data['FROM'];
          to = data['TO'];
          fromtime = data['FROM-TIME'];
          totime = data['TO-TIME'];
          cost = data['COST'];
          type = data['VEHICLE-TYPE'];
          make = data['VEHICLE-MAKE'];
          num = data['VEHICLE-NUMBER'];
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
                  children: [Image.asset('assets/map.png')],
                ),
              ),
            ),
            Stack(clipBehavior: Clip.none, children: <Widget>[
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
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                          SizedBox(
                            height: 30,
                          ),
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
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Text(
                                        num,
                                        style: TextStyle(
                                            fontFamily: 'Arimo',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('${make} ${type}',
                                      style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black54,
                                          fontSize: 14))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          historyBox(),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromRGBO(255, 51, 51, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                            content: Container(
                                              height: 240,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset('assets/successful.png',height: 80,width: 80,),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Booking Successfull',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'Arimo',
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Your boooking has been confirmed',
                                                    style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Color.fromRGBO(160, 160, 160, 1.0),
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    'driver will pick you up soon',
                                                    style: TextStyle(
                                                        fontFamily: 'Arimo',
                                                        color: Color.fromRGBO(160, 160, 160, 1.0),
                                                        fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    height: 23,
                                                  ),
                                                  Divider(
                                                    color: Colors.black12,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _userRef.child(user!.uid).update(
                                                          {'PASSENGER-STATUS': 'CONFIRMED'});
                                                      _userRef
                                                          .child(user!.uid)
                                                          .update({'TRIP-STATUS': 'ONGOING'});
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OnTheWay()));
                                                    },
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        'Done',
                                                        style: TextStyle(
                                                            fontFamily: 'Arimo',
                                                            color: Color.fromRGBO(255, 51, 51, 1.0),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                                      });

                                },
                                child: Text(
                                  "Confirm booking",
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
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PhysicalModel(
                                elevation: 2,
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: InkWell(
                                    onTap: () async {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          phn);
                                    },
                                    child: Icon(
                                      LineIcons.phoneVolume,
                                      color: Color.fromRGBO(255, 51, 51, 0.8),
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                              PhysicalModel(
                                elevation: 2,
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CancellationPage()));
                                    },
                                    child: Icon(
                                      LineIcons.times,
                                      color: Color.fromRGBO(255, 51, 51, 0.8),
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
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40,
                          child: Image.asset('assets/driver.png'),
                        )),
                    Text(name,
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 16))
                  ],
                ),
              ),
            ]),
          ],
        ));
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
                                fromtime!,
                                style: TextStyle(
                                  fontFamily: 'Arimo',
                                ),
                              ),
                              Text(totime!,
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
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection:Axis.vertical,
                                  child: Text(
                                    from!,
                                    style: TextStyle(
                                        fontFamily: 'Arimo', color: Colors.grey),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection:Axis.vertical,
                                  child: Text(
                                    to!,
                                    style: TextStyle(
                                        fontFamily: 'Arimo', color: Colors.grey),
                                  ),
                                ),
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
