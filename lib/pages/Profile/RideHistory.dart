import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Models/user_model.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  db.Query dbRef = db.FirebaseDatabase.instance.ref().child('History');
  bool show=false;
  db.DatabaseReference reference =
      db.FirebaseDatabase.instance.ref().child('History');
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
    reference.onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as dynamic);
        if (data.isNotEmpty) {
          setState(() {
            show=true;
          });
        } 
      }
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
            if (request['PASSENGER-NAME'] == '${loggedInUser.name}' &&
                request['PASSENGER-NUMBER'] == '${loggedInUser.phoneno}')
              historyBox(request['FROM'], request['TO'], request['FROM-TIME'],
                  request['TO-TIME'], request['DATE'], request['STATUS'])
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
          'Ride history',
          style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
      ),
      body: (show)?SizedBox(
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
      ):Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
              "assets/nohistory.json",height: 300,width: 300),
          Text('No history!!',style: TextStyle(fontFamily: 'Arimo',color: Colors.grey[800],fontSize: 19),)
        ],
      )),
    );
  }

  Padding historyBox(String from, String to, String fromtime, String totime,
      String date, String sts) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        elevation: 2.0,
        child: SizedBox(
          height: 200,
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
                        date,
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(62, 73, 88, 1.0)),
                      ),
                      ('${sts}' == 'COMPLETED')
                          ? Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700))
                          : Text('${sts}',
                              style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700))
                    ]),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.black12,
                ),
                SizedBox(
                  height: 15,
                ),
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
    );
  }
}
