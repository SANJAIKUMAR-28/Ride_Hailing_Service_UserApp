import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/Ride/DriverDetails.dart';
import 'package:velocito/pages/BookingProcess/Ride/VehicleSelection.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import '../../../Models/user_model.dart';
class RideOptions extends StatefulWidget {
  final String img;
  final String cost;
  final String vec;
  final String seats;
  final String time;
  final String from;
  final String to;
  final String dist;
  const RideOptions({super.key, required this.img, required this.cost, required this.vec, required this.seats, required this.time, required this.from, required this.to, required this.dist});

  @override
  State<RideOptions> createState() => _RideOptionsState();
}

class _RideOptionsState extends State<RideOptions> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Requests');
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
  final CollectionReference ref = FirebaseFirestore.instance.collection("users");
  late DatabaseReference _userRef;
  String? sts;
  late String date;
  late String fromtime;
  late String totime;
  @override
  void initState() {
    super.initState();
    DateTime dateTime=DateTime.now();
    String day= "${dateTime.day}";
    String month="${dateTime.month}";
    String year="${dateTime.year}";
    date =datefunc(day,month,year);
    fromtime="${dateTime.hour}:${dateTime.minute}";
    String est='24';
    totime=TimeEstimation(fromtime,est);
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
          sts= data['STATUS'];
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
            'Ride options',
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
                    children: [
                      Image.asset('assets/map.png')
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 320,
                child: Selection(),

              ),

            ],
          ),

        ])
    );

  }
  Material Selection() {
    return Material(
        elevation: 5,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)),
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
                    onPressed: () {

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            InkWell(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => VehicleSelection(from: widget.from, to: widget.to,)));
                              },
                              child:
                            Text('Change',style: TextStyle(fontFamily: 'Arimo',color:Color.fromRGBO(255, 51, 51, 0.8),fontSize: 12,fontWeight: FontWeight.bold),),)
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      "${widget.img}",
                                      height: 50,
                                      width: 80,

                                    ),
                                  ]),
                              Row(
                                  children:[
                                    Text('Total cost : ',style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Arimo',
                                        color:
                                        Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    Icon(LineIcons.indianRupeeSign,size: 13,color: Colors.black,),
                                    SizedBox(width: 2,),
                                    Text('${widget.cost}',style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Arimo',
                                        color:
                                        Colors.black,
                                        fontWeight: FontWeight.bold),),
                                  ]
                              ),

                            ]),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${widget.vec}',style: TextStyle(fontFamily: 'Arimo',),),
                            Container(
                              height: 20,
                              child: VerticalDivider(
                                color: Color.fromRGBO(255, 51, 51, 0.8),
                              ),
                            ),
                            Row(children: [
                              Icon(Icons.person,color: Colors.black,),
                              SizedBox(width: 5,),
                              Text('${widget.seats} seats',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold),)
                            ],),
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
                                padding: EdgeInsets.only(left: 5,right: 5),
                                child: Text('3 mins',style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' Estimated trip time',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey,fontSize: 13),),
                  Text(' 24 min',style: TextStyle(fontFamily: 'Arimo',color:Color.fromRGBO(255, 51, 51, 0.8),fontSize: 13),)
                ],
              ),
              SizedBox(height: 20,),
              Material(
                borderRadius: BorderRadius.circular(15),
                elevation: 2,
                color: Color.fromRGBO(255, 51, 51, 0.9),
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    Map<String, String> Requests = {
                      'FROM':widget.from,
                      'TO':widget.to,
                      'VEHICLE':widget.vec ,
                      'COST':widget.cost ,
                      'PASSENGER-NAME': '${loggedInUser.name}',
                      'PASSENGER-NUMBER':'${loggedInUser.phoneno}',
                      'STATUS':'REQUESTED',
                      'PASSENGER-STATUS':'INITIATED',
                      'DISTANCE':widget.dist,
                      'SEATS':widget.seats,
                      'TIME':widget.time,
                      'FROM-TIME':fromtime,
                      'TO-TIME':totime,
                      'DATE':date,
                    };
                    dbRef.child('${loggedInUser.uid}').set(Requests);

                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        content:Container(
                          height: 600,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Stack(
                      alignment: Alignment.center,
                      children:[
                        InkWell(
                        child:Lottie.asset("assets/searching.json"),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {

                          print(sts);

                          }
                        ),
                        Image.asset("assets/loadcar.png",
                        height: 80,
                          width: 50,
                        ),
                        ]

                        ),
                        SizedBox(height: 250,),
                        Text("Searching for a driver",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 18),)
                      ]

                        )
                      )
                      );

                    });
                    //
                  checksts();
                  },
                  child:  Text(
                    "Book ride",
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
  checksts(){
    Timer(Duration(seconds: 1), () async
    {
      if(sts=="ACCEPTED"){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => DriverDetails()));
      }
      else{
        return checksts();
      }
    });
  }
  String datefunc(String day,String mnth,String year){
    String date='';
    String month='';
    if(mnth=='1'||mnth=='01'){
      month='JANUARY';
    }else if(mnth=='2'||mnth=='02'){
      month='FEBRUARY';
    }
    else if(mnth=='3'||mnth=='03'){
      month='MARCH';
    }
    else if(mnth=='4'||mnth=='04'){
      month='APRIL';
    }
    else if(mnth=='5'||mnth=='05'){
      month='MAY';
    }
    else if(mnth=='6'||mnth=='06'){
      month='JUNE';
    }
    else if(mnth=='7'||mnth=='07'){
      month='JULY';
    }
    else if(mnth=='8'||mnth=='08'){
      month='AUGUST';
    }
    else if(mnth=='9'||mnth=='09'){
      month='SEPTEMBER';
    }
    else if(mnth=='10'){
      month='OCTOBER';
    }
    else if(mnth=='11'){
      month='NOVEMBER';
    }
    else {
      month='DECEMBER';
    }
    date='${day} '+'${month} '+year;
    return date;
  }
  String TimeEstimation(String from,String est){
    String estimatedTime='';
    if(int.parse(est)>0&&int.parse(est)<60){
      String min=from.substring(3);
      estimatedTime=from.substring(0,3)+(int.parse(min)+int.parse(est)).toString();
    }
    return estimatedTime;
  }
}
