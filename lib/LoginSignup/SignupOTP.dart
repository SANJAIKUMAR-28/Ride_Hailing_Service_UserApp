import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocito/LoginSignup/Login.dart';
import 'package:velocito/LoginSignup/Signup.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:async';

import '../Models/user_model.dart';

class SignupOTP extends StatefulWidget {
  final String mail;
  final String password;
  final String name;
  final String phn;
  final EmailOTP myauth;
  const SignupOTP(
      {super.key,
      required this.mail,
      required this.password,
      required this.name,
      required this.phn,
      required this.myauth});

  @override
  State<SignupOTP> createState() => _SignupOTPState();
}

class _SignupOTPState extends State<SignupOTP> {
  final _auth = FirebaseAuth.instance;
  final first = new TextEditingController();
  final second = new TextEditingController();
  final third = new TextEditingController();
  final fourth = new TextEditingController();
  final fifth = new TextEditingController();
  final sixth = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late FocusNode firstNode;
  late FocusNode secondNode;
  late FocusNode thirdNode;
  late FocusNode fourthNode;
  late FocusNode fifthNode;
  late FocusNode sixthNode;
  late Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    firstNode = FocusNode();
    secondNode = FocusNode();
    thirdNode = FocusNode();
    fourthNode = FocusNode();
    fifthNode = FocusNode();
    sixthNode = FocusNode();

    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstfield = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          textAlign: TextAlign.center,
          maxLength: 1,
          autofocus: false,
          focusNode: firstNode,
          controller: first,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.phone,
          onChanged: ((value) {
            if (value.length >= 1) {
              firstNode.unfocus();
              FocusScope.of(context).requestFocus(secondNode);
            }
          }),
          onSaved: (value) {
            first.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              border: InputBorder.none,
              counterText: ''),
        ));
    final secondfield = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          focusNode: secondNode,
          textAlign: TextAlign.center,
          maxLength: 1,
          autofocus: false,
          controller: second,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.phone,
          onChanged: ((value) {
            if (value.length >= 1) {
              secondNode.unfocus();
              FocusScope.of(context).requestFocus(thirdNode);
            }
            if (value.length == 0) {
              secondNode.unfocus();
              FocusScope.of(context).requestFocus(firstNode);
            }
          }),
          onSaved: (value) {
            second.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              border: InputBorder.none,
              counterText: ''),
        ));
    final thirdfield = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          textAlign: TextAlign.center,
          maxLength: 1,
          autofocus: false,
          focusNode: thirdNode,
          controller: third,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.phone,
          onChanged: ((value) {
            if (value.length >= 1) {
              thirdNode.unfocus();
              FocusScope.of(context).requestFocus(fourthNode);
            }
            if (value.length == 0) {
              thirdNode.unfocus();
              FocusScope.of(context).requestFocus(secondNode);
            }
          }),
          onSaved: (value) {
            third.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              border: InputBorder.none,
              counterText: ''),
        ));
    final fourthfield = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          textAlign: TextAlign.center,
          maxLength: 1,
          autofocus: false,
          focusNode: fourthNode,
          controller: fourth,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.phone,
          onChanged: ((value) {
            if (value.length >= 1) {
              fourthNode.unfocus();
              FocusScope.of(context).requestFocus(fifthNode);
            }

            if (value.length == 0) {
              fourthNode.unfocus();
              FocusScope.of(context).requestFocus(thirdNode);
            }
          }),
          onSaved: (value) {
            fourth.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              border: InputBorder.none,
              counterText: ''),
        ));
    final fifthfield = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          textAlign: TextAlign.center,
          maxLength: 1,
          autofocus: false,
          focusNode: fifthNode,
          controller: fifth,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.phone,
          onChanged: ((value) {
            if (value.length >= 1) {
              fifthNode.unfocus();
              FocusScope.of(context).requestFocus(sixthNode);
            }
            if (value.length == 0) {
              fifthNode.unfocus();
              FocusScope.of(context).requestFocus(fourthNode);
            }
          }),
          onSaved: (value) {
            fifth.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              border: InputBorder.none,
              counterText: ''),
        ));
    final sixthfield = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          textAlign: TextAlign.center,
          maxLength: 1,
          autofocus: false,
          focusNode: sixthNode,
          controller: sixth,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.phone,
          onChanged: ((value) {
            if (value.length == 0) {
              sixthNode.unfocus();
              FocusScope.of(context).requestFocus(fifthNode);
            }
          }),
          onSaved: (value) {
            sixth.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              border: InputBorder.none,
              counterText: ''),
        ));
    final verifyButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (await widget.myauth.verifyOTP(
                  otp: otpmerge(first.text, second.text, third.text,
                      fourth.text, fifth.text, sixth.text)) ==
              true) {
            signUp(widget.mail, widget.password);
            Fluttertoast.showToast(
              msg: 'OTP Verified and Account created Successfully',
            );
          } else {
            Fluttertoast.showToast(msg: 'Invalid OTP ! !');
          }
        },
        child: Text(
          "Verify",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 17,
              fontFamily: 'Arimo',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Almost there',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.bold),
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Please enter the 6-digit code sent to your email ',
                    style: TextStyle(fontFamily: 'Arimo')),
                TextSpan(
                    text: '${widget.mail}',
                    style: TextStyle(
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 51, 51, 1.0))),
                TextSpan(
                    text: ' for verification',
                    style: TextStyle(fontFamily: 'Arimo'))
              ])),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: firstfield,
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: secondfield,
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: thirdfield,
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: fourthfield,
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: fifthfield,
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: sixthfield,
                )
              ]),
              SizedBox(
                height: 40,
              ),
              verifyButton,
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Didn\'t receive any code?",
                      style: TextStyle(
                          fontFamily: 'Arimo', fontWeight: FontWeight.w900)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(" Resend again",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 51, 51, 1.0),
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Request new code in 00:${_start}s',
                style: TextStyle(fontFamily: 'Arimo', color: Colors.grey),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: CircleBorder(eccentricity: 0.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Signup()));
        },
        backgroundColor: Colors.black,
        child: Icon(
          LineIcons.angleLeft,
          color: Colors.white,
        ),
      ),
    );
  }

  String otpmerge(String firstNum, String secondNum, String thirdNum,
      String fourthNum, String fifthNum, String sixthNum) {
    String otp =
        firstNum + secondNum + thirdNum + fourthNum + fifthNum + sixthNum;
    print(otp);
    return otp;
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {passDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }

  passDetailsToFirestore() async {
    //calling firestore
    //calling user model
    //calling values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = widget.name;
    userModel.phoneno = widget.phn;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully !!");
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
