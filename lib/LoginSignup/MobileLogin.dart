import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocito/LoginSignup/MobileOtp.dart';

import 'MobileSignUp.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final _formkey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  String _verificationId = '';

  Future<void> verifyPhoneNumber() async {
    final PhoneVerificationCompleted verified =
        (PhoneAuthCredential authResult) {
      _auth.signInWithCredential(authResult);
      // Perform any further actions upon successful verification
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      // Handle verification failure
      print('Verification failed: ${authException.message}');
    };

    final PhoneCodeSent smsSent =
        (String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
      // Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MobileOtp(
            verificationId: _verificationId,
            num: '+91 ${emailEditingController.text}',
            name: '',
            page: '1',
          ),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${emailEditingController.text}',
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  @override
  Widget build(BuildContext context) {
    final phoneField = TextFormField(
      maxLength: 10,
      autofocus: false,
      controller: emailEditingController,
      style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Enter your mobile no");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          counterText: '',
          hintText: "00 00 00 00 00",
          hintStyle: TextStyle(fontFamily: 'Arimo'),
          border: InputBorder.none),
    );
    final loginButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          setState(() {
            loading = true;
          });
          verifyPhoneNumber();
        },
        child: loading
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Text(
                "Continue",
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/loginimg.png',
                        fit: BoxFit.fill,
                        height: 200,
                        width: 250,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Log in',
                    style: TextStyle(
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Please confirm your country code and \nenter your phone number.',
                    style: TextStyle(fontFamily: 'Arimo', fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/ind.png",
                          height: 20,
                          width: 22,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'India',
                          style: TextStyle(fontFamily: 'Arimo'),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '+91',
                        style: TextStyle(
                            fontFamily: 'Arimo', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 10,
                        child: VerticalDivider(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(width: 150, child: phoneField)
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  loginButton,
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("New member?",
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w900)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MobileSignUp()));
                        },
                        child: Text(" Register now",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 51, 51, 1.0),
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    setState(() {
      loading = true;
    });
    if (_formkey.currentState!.validate()) {}
  }
}
