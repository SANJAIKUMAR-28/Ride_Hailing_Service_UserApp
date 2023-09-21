import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';

import '../../../Models/user_model.dart';
import '../../HomeScreen.dart';

class DailiesDetails extends StatefulWidget {
  final String from;
  final String to;
  final String fromdate;
  final String pickuptime;
  final String todatedate;
  final String repickuptime;
  final String totaldays;
  final String dist;
  final String est;
  const DailiesDetails({super.key, required this.from, required this.to, required this.fromdate, required this.pickuptime, required this.todatedate, required this.repickuptime, required this.dist, required this.est, required this.totaldays});

  @override
  State<DailiesDetails> createState() => _DailiesDetailsState();
}

class _DailiesDetailsState extends State<DailiesDetails> {
  DatabaseReference dbRef =
  FirebaseDatabase.instance.ref().child('DailiesRequests');
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
                                  "assets/taxi4.png",
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
                              'Sedan',
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
                                Text(
                                  '4 seats',
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
                              'From & To date',
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
                        '${widget.fromdate} - ${widget.todatedate}',
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
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
                                    'Pickup & Re-pickup time',
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
                              '${widget.pickuptime} - ${widget.repickuptime}',
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
                              'Total days',
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
                        '${widget.totaldays} Days',
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
                      'COST': cost(),
                      'PASSENGER-NAME': '${loggedInUser.name}',
                      'PASSENGER-NUMBER': '${loggedInUser.phoneno}',
                      'PASSENGER-ID': '${loggedInUser.uid}',
                      'STATUS': 'REQUESTED',
                      'PICKUP-TIME': widget.pickuptime,
                      'FROM-DATE': widget.fromdate,
                      'TO-DATE': widget.todatedate,
                      'REPICKUP-TIME': widget.repickuptime,
                      'TOTAL-DAYS':widget.totaldays,
                    };
                    dbRef.push().set(Requests);
                    Fluttertoast.showToast(
                        msg: "Cab requested, check for status in profile page");
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
      fare = 200 + (double.parse(widget.dist)*2);

    return fare.toStringAsFixed(2);
  }
}
