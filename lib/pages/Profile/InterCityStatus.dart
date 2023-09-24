import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';

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
 final db.Query dbRef = db.FirebaseDatabase.instance.ref().child('IntercityRequests');
  db.DatabaseReference reference =
      db.FirebaseDatabase.instance.ref().child('IntercityRequests');
 final db.Query DailiesRef = db.FirebaseDatabase.instance.ref().child('DailiesRequests');
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
  Future<void> _showNotification(String from,String to) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Replace with your channel ID
      'Your Channel Name', // Replace with your channel name
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Intercity Status', // Notification title
      'Your request from has been confirmed.\nHave a Happy Journey :)', // Notification body
      platformChannelSpecifics,
    );
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
                request['DRIVER-NAME'],
                request['DRIVER-NUMBER'],
                request['VEHICLE-TYPE'],
                request['VEHICLE-MAKE'],
                request['VEHICLE-NMUMBER'],
                request['STATUS'],
                request['key'],
              ),
            if(request['STATUS']=='CONFIRMED'&&request['NOTIFICATION']=='1')
              checksts(request['FROM'],request['TO'],request['key'])

          ],
        ),
      ),
    );
  }
  Widget listItem2({required Map request1}) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 6, right: 20, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (request1['PASSENGER-ID'] == '${loggedInUser.uid}')
              historyBoxDailies(
                request1['FROM'],
                request1['TO'],
                request1['PICKUP-TIME'],
                request1['REPICKUP-TIME'],
                request1['FROM-DATE'],
                request1['TO-DATE'],
                request1['STATUS'],
                request1['key'],
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
              ):
              SizedBox(
              height: MediaQuery.of(context).size.height,
              child:  FirebaseAnimatedList(
                query: DailiesRef,
                itemBuilder: (BuildContext context, db.DataSnapshot snapshot1,
                    Animation<double> animation, int index1) {
                  Map request1 = snapshot1.value as Map;
                  request1['key'] = snapshot1.key;
                    return listItem2(request1: request1);
                },
                ),
              ),
            ],
          ),
        ),
    );
  }

  Padding historyBox(String from, String to, String fromtime, String totime,
      String date,String returntime,String returndate,String type,String drivername,String drivernum,String vectype,String vecmake,String vecnum,String sts,String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: Stack(
          children: [
            SizedBox(
              height: (type=='One-way')?(sts!='COMPLETED')?240:200:(sts!='COMPLETED')?280:240,
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
                                  : ('${sts}' == 'CONFIRMED')?Row(
                                    children: [
                                      Text('${sts}',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(width: 5,),
                                      InkWell(
                                        onTap: (){
                                          showModalBottomSheet(isDismissible:false,context: context, builder: (context){

                                            return Stack(
                                                clipBehavior: Clip.none,
                                                children:<Widget> [
                                                  SizedBox(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 210,
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
                                                                          child: Text(vecnum,style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold),),
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 5,),
                                                                      Text('$vecmake $vectype',style: TextStyle(
                                                                          fontFamily: 'Arimo',
                                                                          color: Colors.black54,
                                                                          fontSize: 14
                                                                      ))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(height: 30,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  PhysicalModel(
                                                                    elevation: 2,
                                                                    shape: BoxShape.circle,
                                                                    color: Colors.transparent,
                                                                    child: CircleAvatar(
                                                                      radius: 30,
                                                                      backgroundColor: Colors.redAccent,
                                                                      child: InkWell(
                                                                        onTap: () async {
                                                                          await FlutterPhoneDirectCaller.callNumber(drivernum);
                                                                        },
                                                                        child: Icon(
                                                                          LineIcons.phoneVolume,
                                                                          color: Colors.white,
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
                                                                      backgroundColor: Colors.redAccent,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        child: Icon(
                                                                          LineIcons.times,
                                                                          color: Colors.white,
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
                                                        Text(drivername,style: TextStyle(
                                                            fontFamily: 'Arimo',
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black54,
                                                            fontSize: 16
                                                        ))
                                                      ],
                                                    ),
                                                  ),

                                                ]
                                            );
                                          });
                                        },
                                      child:Icon(Icons.remove_red_eye,color: Colors.redAccent,size: 18,)
                                      )
                                    ],
                                  ):Text('${sts}',
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
                                    Expanded(
                                      child: Text(
                                        from,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontFamily: 'Arimo', color: Colors.grey),
                                      ),
                                    ),
                                    Expanded(
                                      child:
                                    Text(
                                      to,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontFamily: 'Arimo', color: Colors.grey),
                                    ),
                                    )
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
            if(sts!="COMPLETED")
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
  Padding historyBoxDailies(String from, String to, String pickuptime, String repickuptime,
      String fromdate,String todate, String sts,String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: Stack(
          children: [
            SizedBox(
              height: (sts!='COMPLETED')?280:200,
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
                          Row(
                            children: [
                              InkWell(
                                splashColor:Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap:(){

                                },
                                child: Text(
                                  "ACKNOWLEDGE",
                                  style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent),
                                ),
                              ),
                              SizedBox(width: 5,),
                              InkWell(
                                  onTap: (){

                                  },
                                  child: Icon(Icons.info_outline,color: Colors.grey,size: 18,))
                            ],
                          ),
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
                        Row(
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
                        Expanded(
                          child: Text(
                            '$fromdate - $todate',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Arimo',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                      Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                width: 165,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pickup & Re-pickup Time',
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
                                '$pickuptime - $repickuptime',
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
            if(sts!="COMPLETED")
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
                                title: Text("Cancel service",
                                    style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Color.fromRGBO(
                                            255, 51, 51, 0.8),
                                        fontWeight: FontWeight.bold,fontSize: 18)),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text(
                                          "Are you sure want to cancel service?",
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
                                        reference1.child(key).remove();
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
                            Text('CANCEL SERVICE',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold,color: Colors.redAccent),),
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
checksts(String from,String to,String key){
    _showNotification(from,to);
    reference.child(key).update({'NOTIFICATION':'2'});
}
}
