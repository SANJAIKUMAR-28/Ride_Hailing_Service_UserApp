import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocito/pages/BookingProcess/OnTheWay.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velocito/pages/BookingProcess/RateDriver.dart';

import '../../Models/user_model.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({super.key});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  late Map<String, dynamic> paymentIntent;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("users");
  late DatabaseReference _userRef;
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
  }

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();

      var gpay = PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
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
      await Stripe.instance.presentPaymentSheet();
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
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Payment option',
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
                      Image.asset('assets/map.png'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Material(
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Select payment',
                            style: TextStyle(
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(62, 73, 88, 1.0)),
                          ),
                          SizedBox(height: 12),
                          Material(
                              elevation: 4,
                              shadowColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                splashColor: Colors.black.withOpacity(0.2),
                                onPressed: () {
                                  _userRef
                                      .child(user!.uid)
                                      .update({'PAYMENT-TYPE': 'Gpay'});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RateDriver()));
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          "assets/gpay.png",
                                          height: 27,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Gpay",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arimo',
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.60),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ]),
                              )),
                          SizedBox(height: 12),
                          Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                splashColor: Colors.black.withOpacity(0.2),
                                onPressed: () {
                                  _userRef
                                      .child(user!.uid)
                                      .update({'PAYMENT-TYPE': 'Card'});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RateDriver()));

                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          "assets/card.png",
                                          height: 27,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Cards",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arimo',
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.60),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ]),
                              )),
                          SizedBox(height: 12),
                          Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                splashColor: Colors.black.withOpacity(0.2),
                                onPressed: () {
                                  _userRef
                                      .child(user!.uid)
                                      .update({'PAYMENT-TYPE': 'Cash'});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RateDriver()));
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          "assets/cash.png",
                                          height: 27,
                                          width: 27,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Cash",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Arimo',
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.60),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                      Icon(
                                        LineIcons.angleRight,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ]),
                              )),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ]));
  }
}
