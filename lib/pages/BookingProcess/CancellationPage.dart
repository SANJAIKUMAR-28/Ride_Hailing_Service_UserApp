import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocito/pages/HomeScreen.dart';

import '../../Models/user_model.dart';
import 'TripEnded.dart';

class CancellationPage extends StatefulWidget {
  const CancellationPage({super.key});

  @override
  State<CancellationPage> createState() => _CancellationPageState();
}

class _CancellationPageState extends State<CancellationPage> {
  bool val = false;
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("users");
  late DatabaseReference _userRef;
  String key = '';
  String name = '';
  String phn = '';
  String from = '';
  String to = '';
  String cost = '';
  String vec = '';
  String seats = '';
  String dist = '';
  String time = '';
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
    _userRef.child(user!.uid).onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as dynamic);
        setState(() {
          key = data['key'];
          name = data['DRIVER-NAME'];
          phn = data['DRIVER-NUMBER'];
          from = data['FROM'];
          to = data['TO'];
          cost = data['COST'];
          vec = data['VEHICLE'];
          seats = data['SEATS'];
          dist = data['DISTANCE'];
          time = data['TIME'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
        ),
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Please select the\nreason for cancellation:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(
              height: 70,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            val = !val;
                            val1 = false;
                            val2 = false;
                            val3 = false;
                            val4 = false;
                          });
                        },
                        child: (!val)
                            ? Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Don\'t want to share',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(62, 73, 88, 1),
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 30,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            val1 = !val1;
                            val = false;
                            val2 = false;
                            val3 = false;
                            val4 = false;
                          });
                        },
                        child: (!val1)
                            ? Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Can\'t contact the driver',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(62, 73, 88, 1),
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 30,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            val2 = !val2;
                            val1 = false;
                            val = false;
                            val3 = false;
                            val4 = false;
                          });
                        },
                        child: (!val2)
                            ? Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Driver is late',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(62, 73, 88, 1),
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 30,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            val3 = !val3;
                            val1 = false;
                            val2 = false;
                            val = false;
                            val4 = false;
                          });
                        },
                        child: (!val3)
                            ? Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Price is not reasonable',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(62, 73, 88, 1),
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 30,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            val4 = !val4;
                            val1 = false;
                            val2 = false;
                            val3 = false;
                            val = false;
                          });
                        },
                        child: (!val4)
                            ? Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pickup address is incorrect',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(62, 73, 88, 1),
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 30,
                  endIndent: 10,
                ),
                SizedBox(
                  height: 80,
                ),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(255, 51, 51, 0.9),
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      if (val) {
                        _userRef
                            .child('${loggedInUser.uid}')
                            .update({'PASSENGER-STATUS': 'CANCELLED'});
                        _userRef.child('${loggedInUser.uid}').update({
                          'REASON FOR CANCELLATION': 'Don\'t want to share'
                        });
                      }
                      if (val1) {
                        _userRef
                            .child('${loggedInUser.uid}')
                            .update({'PASSENGER-STATUS': 'CANCELLED'});
                        _userRef.child('${loggedInUser.uid}').update({
                          'REASON FOR CANCELLATION': 'Can\'t contact the driver'
                        });
                      }
                      if (val2) {
                        _userRef
                            .child('${loggedInUser.uid}')
                            .update({'PASSENGER-STATUS': 'CANCELLED'});
                        _userRef.child('${loggedInUser.uid}').update(
                            {'REASON FOR CANCELLATION': 'Driver is late'});
                      }
                      if (val3) {
                        _userRef
                            .child('${loggedInUser.uid}')
                            .update({'PASSENGER-STATUS': 'CANCELLED'});
                        _userRef.child('${loggedInUser.uid}').update({
                          'REASON FOR CANCELLATION': 'Price is not reasonable'
                        });
                      }
                      if (val4) {
                        _userRef
                            .child('${loggedInUser.uid}')
                            .update({'PASSENGER-STATUS': 'CANCELLED'});
                        _userRef.child('${loggedInUser.uid}').update({
                          'REASON FOR CANCELLATION':
                              'Pickup address is incorrect'
                        });
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                      Fluttertoast.showToast(msg: "Booking cancelled");
                    },
                    child: Text(
                      "Submit",
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
            )
          ],
        ),
      ),
    );
  }

  Padding ques(String ques, String num) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                val = !val;
              });
            },
            child: (!val)
                ? Icon(
                    Icons.circle_outlined,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.check_circle,
                    color: Color.fromRGBO(255, 51, 51, 0.9),
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '${ques}',
            style: TextStyle(
                fontFamily: 'Arimo',
                color: Color.fromRGBO(62, 73, 88, 1),
                fontSize: 15),
          )
        ],
      ),
    );
  }
}
