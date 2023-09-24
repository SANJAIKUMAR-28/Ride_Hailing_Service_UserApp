import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as st;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/LoginSignup/SelectOption.dart';
import 'package:velocito/pages/Profile/InterCityStatus.dart';
import 'package:http/http.dart' as http;
import '../../Models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("users");
  late Map<String, dynamic> paymentIntent;
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
  }
  Future<void> _showNotification() async {
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
      'Title', // Notification title
      'Body', // Notification body
      platformChannelSpecifics,
    );
  }
  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();

      var gpay = st.PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      st.Stripe.instance.initPaymentSheet(
          paymentSheetParameters: st.SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Velocito",
            googlePay: gpay,
          ));

      displayPaymentSheet();
    } catch (e) {}
  }

  void displayPaymentSheet() async {
    try {
      await st.Stripe.instance.presentPaymentSheet();
      print("done");
    } catch (e) {
      print("failed");
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "1000",
        "currency": "INR",
      };

      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
            "Bearer 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",
            "Content-type": "application/x-www-form-urlencoded"
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(255, 51, 51, 0.8),
                    elevation: 2.0,
                    child: SizedBox(
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(255, 51, 51, 0.2),
                                  size: 45,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${loggedInUser.name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arimo',
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  (loggedInUser.phoneno != null)
                                      ? Text('${loggedInUser.phoneno}',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              color: Color.fromRGBO(
                                                  215, 215, 215, 1.0),
                                              fontSize: 12))
                                      : Text('Add mobile number',
                                          style: TextStyle(
                                              fontFamily: 'Arimo',
                                              color: Color.fromRGBO(
                                                  215, 215, 215, 1.0),
                                              fontSize: 12))
                                ],
                              ),
                            ]),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              onTap: () {
                                ref.doc(user!.uid).update({
                                  'phoneno': "7373994102",
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            //wallet
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber('9791745466');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Row(children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromRGBO(255, 51, 51, 0.03),
                                        child: Icon(
                                          LineIcons.phone,
                                          color:
                                              Color.fromRGBO(255, 51, 51, 0.8),
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Book by Call',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('Make call to a nearby driver',
                                              style: TextStyle(
                                                  fontFamily: 'Arimo',
                                                  color: Color.fromRGBO(
                                                      171, 171, 171, 1.0),
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ]),
                                    InkWell(
                                      child: const Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onTap: () async {

                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //Address
                            const SizedBox(
                              height: 25,
                            ),
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () async {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Row(children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromRGBO(255, 51, 51, 0.03),
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          color:
                                              Color.fromRGBO(255, 51, 51, 0.8),
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Address',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('Add your address',
                                              style: TextStyle(
                                                  fontFamily: 'Arimo',
                                                  color: Color.fromRGBO(
                                                      171, 171, 171, 1.0),
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ]),
                                    InkWell(
                                      child: const Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //forgot password
                            const SizedBox(
                              height: 25,
                            ),
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InterCityStatus()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Row(children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromRGBO(255, 51, 51, 0.03),
                                        child: Icon(
                                          Icons.backpack_outlined,
                                          color:
                                              Color.fromRGBO(255, 51, 51, 0.8),
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Intercity Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('Check you booking status',
                                              style: TextStyle(
                                                  fontFamily: 'Arimo',
                                                  color: Color.fromRGBO(
                                                      171, 171, 171, 1.0),
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ]),
                                    InkWell(
                                      child: const Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //log out
                            const SizedBox(
                              height: 25,
                            ),
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return AlertDialog(
                                          surfaceTintColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          title: Text("Log out",
                                              style: TextStyle(
                                                  fontFamily: 'Arimo',
                                                  color: Color.fromRGBO(
                                                      255, 51, 51, 0.8),
                                                  fontWeight: FontWeight.bold)),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const <Widget>[
                                                Text(
                                                    "Are you sure want to sign out?",
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
                                                  await GoogleSignIn()
                                                      .signOut();
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                  Navigator.of(context).pop();
                                                  Navigator.pushAndRemoveUntil(
                                                      (context),
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SelectOption()),
                                                      (route) => false);
                                                  Fluttertoast.showToast(
                                                      msg: "Signed out");
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Row(children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromRGBO(255, 51, 51, 0.03),
                                        child: Icon(
                                          Icons.logout_rounded,
                                          color:
                                              Color.fromRGBO(255, 51, 51, 0.8),
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Log Out',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('Log out from this device',
                                              style: TextStyle(
                                                  fontFamily: 'Arimo',
                                                  color: Color.fromRGBO(
                                                      171, 171, 171, 1.0),
                                                  fontSize: 12))
                                        ],
                                      ),
                                    ]),
                                    InkWell(
                                      child: const Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'More',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Arimo',
                        color: Colors.grey,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    child: Column(children: [
                      const SizedBox(
                        height: 25,
                      ),
                      //wallet
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
makePayment();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Row(children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Color.fromRGBO(255, 51, 51, 0.03),
                                  child: Icon(
                                    LineIcons.headset,
                                    color: Color.fromRGBO(255, 51, 51, 0.8),
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Help and Support',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('Customer support',
                                        style: TextStyle(
                                            fontFamily: 'Arimo',
                                            color: Color.fromRGBO(
                                                171, 171, 171, 1.0),
                                            fontSize: 12))
                                  ],
                                ),
                              ]),
                              InkWell(
                                child: const Icon(
                                  LineIcons.angleRight,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onTap: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      //ride history
                      const SizedBox(
                        height: 25,
                      ),
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            _showNotification();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Row(children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Color.fromRGBO(255, 51, 51, 0.03),
                                  child: Icon(
                                    LineIcons.info,
                                    color: Color.fromRGBO(255, 51, 51, 0.8),
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text('About the app',
                                        style: TextStyle(
                                            fontFamily: 'Arimo',
                                            color: Color.fromRGBO(
                                                171, 171, 171, 1.0),
                                            fontSize: 12))
                                  ],
                                ),
                              ]),
                              InkWell(
                                child: const Icon(
                                  LineIcons.angleRight,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onTap: () {},
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ]),
                  )
                ],
              ))),
    );
  }
}
