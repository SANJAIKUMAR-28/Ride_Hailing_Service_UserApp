import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/PaymentOption.dart';
import 'package:velocito/pages/BookingProcess/Ride/VehicleSelection.dart';
import 'package:velocito/pages/Profile/RideHistory.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../Models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
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
                                  (loggedInUser.phoneno!=null)?
                                  Text('${loggedInUser.phoneno}',
                                      style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Color.fromRGBO(
                                              215, 215, 215, 1.0),
                                          fontSize: 12)):Text('Add mobile number',
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
                              onTap: () {},
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
                              height: 15,
                            ),
                            //wallet
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => PaymentOption()));
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
                                          LineIcons.creditCard,
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
                                            'My cards',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('Make changes to your cards',
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
                              height: 15,
                            ),
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => RideHistory()));
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
                                          LineIcons.history,
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
                                            'Ride History',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('View your trip history',
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
                                      onTap: () {

                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //Address
                            const SizedBox(
                              height: 15,
                            ),
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber('${loggedInUser.phoneno}');
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
                              height: 15,
                            ),
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {},
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
                                          LineIcons.key,
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
                                            'Forgot Password',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Arimo',
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text('Reset your password',
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
                              height: 15,
                            ),
                            Material(
                              color: Colors.white,
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () async {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      title: Text("Log out", style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Color.fromRGBO(255, 51, 51, 0.8),
                                          fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const<Widget>[
                                            Text(
                                                "Are you sure want to sign out?",
                                                style: TextStyle(
                                                    fontFamily: 'Arimo')),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                            child: const Text('No', style: TextStyle(
                                                fontFamily: 'Arimo',
                                                color: Color.fromRGBO(255, 51, 51, 0.8),
                                                fontWeight: FontWeight.bold))),
                                        TextButton(onPressed: () async {
                                          await GoogleSignIn().signOut();
                                          FirebaseAuth.instance.signOut();
                                          Navigator.of(context).pop();
                                          Fluttertoast.showToast(msg: "Signed out");
                                        },
                                            child: const Text('Yes', style: TextStyle(
                                                fontFamily: 'Arimo',
                                                color:Color.fromRGBO(255, 51, 51, 0.8),
                                                fontWeight: FontWeight.bold)))
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
                              height: 15,
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
                        height: 15,
                      ),
                      //wallet
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => VehicleSelection()));
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
                        height: 15,
                      ),
                      Material(
                        color: Colors.white,
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
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
                        height: 15,
                      ),
                    ]),
                  )
                ],
              ))),
    );
  }
}
