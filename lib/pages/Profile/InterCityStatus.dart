import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../Models/user_model.dart';

class InterCityStatus extends StatefulWidget {
  const InterCityStatus({super.key});

  @override
  State<InterCityStatus> createState() => _InterCityStatusState();
}

class _InterCityStatusState extends State<InterCityStatus> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  db.Query dbRef =
      db.FirebaseDatabase.instance.ref().child('IntercityRequests');
  db.DatabaseReference reference =
      db.FirebaseDatabase.instance.ref().child('IntercityRequests');
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
        title: const Text(
          'Status',
          style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: FirebaseAnimatedList(
        query: dbRef,
        itemBuilder: (BuildContext context, db.DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map request = snapshot.value as Map;
          request['key'] = snapshot.key;

          return listItem(request: request);
        },
      ),
    );
  }

  Padding historyBox(String from, String to, String fromtime, String totime,
      String date,String returntime,String returndate,String type, String sts) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: SizedBox(
          height: (type=='One-way')?200:240,
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
      ),
    );
  }
}
