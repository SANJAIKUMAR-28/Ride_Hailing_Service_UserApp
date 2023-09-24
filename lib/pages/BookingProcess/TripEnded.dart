import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/HomeScreen.dart';

import '../../Models/user_model.dart';

class TripEnded extends StatefulWidget {
  const TripEnded({super.key});

  @override
  State<TripEnded> createState() => _TripEndedState();
}

class _TripEndedState extends State<TripEnded> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("users");
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Requests');
  DatabaseReference dbRef1 = FirebaseDatabase.instance.ref().child('History');
  String from='';
  String to='';
  String cost='';
  String driver='';
  String driverphn='';
  String vec='';
  String dist='';
  String seats='';
  String time='';
  String fromtime='';
  String totime='';
  String date='';
  String driverid='';
  String payment='';
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
    dbRef.child(user!.uid).onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as dynamic);
        setState(() {
          from = data['FROM'];
          to = data['TO'];
          cost = data['COST'];
          driver = data['DRIVER-NAME'];
          driverphn = data['DRIVER-NUMBER'];
          vec = data['VEHICLE'];
          seats = data['SEATS'];
          time = data['TIME'];
          fromtime = data['FROM-TIME'];
          totime = data['TO-TIME'];
          date = data['DATE'];
          driverid = data['DRIVER-ID'];
          payment = data['PAYMENT-TYPE'];
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 450,
                    width: 300,
                    child: Material(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor:
                                  Color.fromRGBO(196, 196, 196, 0.2),
                              child: Icon(
                                Icons.check,
                                color: Color.fromRGBO(255, 51, 51, 0.7),
                                size: 45,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Your trip has ended',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Arimo',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black)),
                            SizedBox(
                              height: 20,
                            ),
                            historyBox(),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Material(
                                color: Color.fromRGBO(196, 196, 196, 0.2),
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          (payment == "Card")
                                              ? Image.asset(
                                                  'assets/cardimg.png',
                                                  height: 30,
                                                  width: 30,
                                                )
                                              : (payment == "Cash")
                                                  ? Image.asset(
                                                      'assets/cash.png',
                                                      height: 30,
                                                      width: 30,
                                                    )
                                                  : Image.asset(
                                                      'assets/gpay.png',
                                                      height: 30,
                                                      width: 30,
                                                    ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          (payment == 'Card')
                                              ? Text(
                                                  '**** **** 4226',
                                                  style: TextStyle(
                                                      fontFamily: 'Arimo',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromRGBO(
                                                          62, 73, 88, 1)),
                                                )
                                              : (payment == 'Cash')
                                                  ? Text(
                                                      'Cash',
                                                      style: TextStyle(
                                                          fontFamily: 'Arimo',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color.fromRGBO(
                                                              62, 73, 88, 1)),
                                                    )
                                                  : Text(
                                                      'Google pay',
                                                      style: TextStyle(
                                                          fontFamily: 'Arimo',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color.fromRGBO(
                                                              62, 73, 88, 1)),
                                                    ),
                                        ],
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              LineIcons.indianRupeeSign,
                                              size: 15,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              cost!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Arimo',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Image.asset('assets/clip.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(255, 51, 51, 0.9),
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      dbRef.child('${loggedInUser.uid}').remove();
                      Map<String, String> History = {
                        'FROM': from!,
                        'TO': to!,
                        'VEHICLE': vec!,
                        'COST': cost!,
                        'DRIVER-NAME': driver!,
                        'DRIVER-NUMBER': driverphn!,
                        'PASSENGER-NAME': '${loggedInUser.name}',
                        'PASSENGER-NUMBER': '${loggedInUser.phoneno}',
                        'STATUS': 'COMPLETED',
                        'SEATS': seats!,
                        'TIME': time!,
                        'DRIVER-ID': driverid!,
                        'FROM-TIME': fromtime!,
                        'TO-TIME': totime!,
                        'DATE': date!,
                      };
                      dbRef1.push().set(History);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Text(
                      "Done",
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
            ],
          ),
        ),
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
              borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 150,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 5),
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
                                child: Text(
                                  from!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Arimo', color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  to!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Arimo', color: Colors.grey),
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
