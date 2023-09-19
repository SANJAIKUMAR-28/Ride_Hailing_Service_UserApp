import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Models/user_model.dart';

class InterCityStatus extends StatefulWidget {
  const InterCityStatus({super.key});

  @override
  State<InterCityStatus> createState() => _InterCityStatusState();
}

class _InterCityStatusState extends State<InterCityStatus> {
  bool intercity=true;
  bool dailies=false;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  db.Query dbRef =
      db.FirebaseDatabase.instance.ref().child('IntercityRequests');
  db.DatabaseReference reference =
      db.FirebaseDatabase.instance.ref().child('IntercityRequests');
  db.Query dbRef1 =
  db.FirebaseDatabase.instance.ref().child('DailiesRequests');
  db.DatabaseReference reference1 =
  db.FirebaseDatabase.instance.ref().child('DailiesRequests');
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    });
  }

  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 6, right: 20, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (request['PASSENGER-ID'] == '${loggedInUser.uid}')
              historyBox(
                  request['FROM'],
                  request['TO'],
                  request['DEPARTURE-TIME'],
                  request['DEPARTURE-TIME'],
                  request['DEPARTURE-DATE'],
                request['RETURN-TIME'],
                request['RETURN-DATE'],
                  request['TRIP-TYPE'],
                request['STATUS'],
                request['key'],
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Status',
              style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
            ),

          ],
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      color: Color.fromRGBO(255, 245, 245, 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.transparent,
                            width: (MediaQuery.of(context).size.width)/2,
                            child: Material(
                              color: Color.fromRGBO(255, 245, 245, 1.0),
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      intercity=!intercity;
                                      dailies=!dailies;
                                    });
                                  },
                                  child: Text('InterCity',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Arimo',color: (intercity)?Colors.redAccent:Colors.black),)),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: (MediaQuery.of(context).size.width)/2,
                            child: Material(
                              color: Color.fromRGBO(255, 245, 245, 1.0),
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                  onPressed: () {
                                  setState(() {
                                    dailies=!dailies;
                                    intercity=!intercity;
                                  });
                                  },
                                  child: Text('Dailies',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Arimo',color: (dailies)?Colors.redAccent:Colors.black),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 5,
                        child: Divider(
                          endIndent: (dailies)?0:MediaQuery.of(context).size.width/2,
                          indent: (intercity)?0:MediaQuery.of(context).size.width/2,
                          color: Colors.redAccent,
                        ),
                      ))
                ],
              ),
              (intercity)?
              Container(
                height: MediaQuery.of(context).size.height,
                child: FirebaseAnimatedList(
                  query: dbRef,
                  itemBuilder: (BuildContext context, db.DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map request = snapshot.value as Map;
                    request['key'] = snapshot.key;

                    return listItem(request: request);
                  },
                ),
              ): Container(
                height: MediaQuery.of(context).size.height,
                child: FirebaseAnimatedList(
                  query: dbRef1,
                  itemBuilder: (BuildContext context, db.DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map request = snapshot.value as Map;
                    request['key'] = snapshot.key;
                    if(!snapshot.exists){
                      return Text('No bookings!!',style: TextStyle(fontFamily: 'Arimo'),);
                    }
                    else {
                      return listItem(request: request);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }

  Padding historyBox(String from, String to, String fromtime, String totime,
      String date,String returntime,String returndate,String type, String sts,String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: Stack(
          children: [
            SizedBox(
              height: (type=='One-way')?240:280,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type,
                            style: TextStyle(
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(62, 73, 88, 1.0)),
                          ),
                          ('${sts}' == 'REQUESTED')
                              ? Text('${sts}',
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w700))
                              : ('${sts}' == 'CANCELLED')
                                  ? Text('${sts}',
                                      style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w700))
                                  : ('${sts}' == 'CONFIRMED')?Text('${sts}',
                                      style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.green,
                                          fontWeight: FontWeight.w700)):Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700)),
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black12,
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
                          '$date - $fromtime',
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    if(type!='One-way')
                      Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                '$returndate - $returntime',
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

                    SizedBox(height: 10,),
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
                                  'From',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                  ),
                                ),
                                Text('To',
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
                                      from,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontFamily: 'Arimo', color: Colors.grey),
                                    ),
                                    Text(
                                      to,
                                      overflow: TextOverflow.fade,
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
            Positioned(
              bottom: 0,
                right: 0,
                left: 0,
                child:
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 245, 245, 1),
                borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:  Radius.circular(10)) ,
                // border: Border(
                //   bottom: BorderSide(
                //     color: Colors.redAccent
                //   )
                // ),
              ),

              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          surfaceTintColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10)),
                          title: Text("Cancel trip",
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Color.fromRGBO(
                                      255, 51, 51, 0.8),
                                  fontWeight: FontWeight.bold,fontSize: 18)),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    "Are you sure want to cancel trip?",
                                    style: TextStyle(
                                        fontFamily: 'Arimo')),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No',
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Color.fromRGBO(
                                            255, 51, 51, 0.8),
                                        fontWeight:
                                        FontWeight.bold))),
                            TextButton(
                                onPressed: () async {
                                  reference.child(key).remove();
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(
                                      msg: "Trip Cancelled");
                                },
                                child: const Text('Yes',
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Color.fromRGBO(
                                            255, 51, 51, 0.8),
                                        fontWeight:
                                        FontWeight.bold)))
                          ],
                        );
                      });

                },
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('CANCEL TRIP',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.redAccent),),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
