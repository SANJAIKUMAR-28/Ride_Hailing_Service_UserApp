import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:velocito/pages/BookingProcess/CancellationPage.dart';
import 'package:velocito/pages/BookingProcess/PaymentOption.dart';


import '../../Models/user_model.dart';

class OnTheWay extends StatefulWidget {
  const OnTheWay({super.key,});

  @override
  State<OnTheWay> createState() => _OnTheWayState();
}

class _OnTheWayState extends State<OnTheWay> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Requests');
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
  final CollectionReference ref = FirebaseFirestore.instance.collection("users");
  late DatabaseReference _userRef;

  String sts='';
  String from='';
  String to='';
  String fromtime='';
  String totime='';
  String num='';
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
          sts=data['TRIP-STATUS'];
          from=data['FROM'];
          to=data['TO'];
          fromtime=data['FROM-TIME'];
          totime=data['TO-TIME'];
          num=data['DRIVER-NUMBER'];
        });
      }
    });
checksts();

  }
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
                height: 280,
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
                        SizedBox(height: 20,),
                        Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 2,
                          color: Color.fromRGBO(255, 51, 51, 0.9),
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => CancellationPage()));
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
                                fromtime,
                                style: TextStyle(
                                  fontFamily: 'Arimo',
                                ),
                              ),
                              Text(totime,
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
                                  from,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Arimo', color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  to,
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
  checksts(){
    Timer(Duration(seconds: 1), () async
    {
      if(sts=="ARRIVED"){
        showDialog(barrierDismissible:false,context: context, builder: (context) {
          return AlertDialog(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/cararrived.png',
                      height: 100,
                      width: 60,
                    ),
                    SizedBox(height: 20,),
                    Text('Your taxi has arrived',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            SizedBox(
                              width:100,
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(255, 51, 51, 0.9),
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => PaymentOption()));
                                  },
                                  child:  Text(
                                    "I\'m coming",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Arimo',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    await FlutterPhoneDirectCaller.callNumber(num);
                                  },
                                  child:  Text(
                                    "Call",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13,
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
              )
          );
        });
      }
      else{
        return checksts();
      }
    });
  }
}
