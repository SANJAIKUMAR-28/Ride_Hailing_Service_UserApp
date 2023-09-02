import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocito/LoginSignup/MobileLogin.dart';

import 'MobileOtp.dart';

class MobileSignUp extends StatefulWidget {
  const MobileSignUp({super.key});

  @override
  State<MobileSignUp> createState() => _MobileSignUpState();
}

class _MobileSignUpState extends State<MobileSignUp> {
  @override
  final _formkey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
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
            num: '${passwordEditingController.text}',
            name: emailEditingController.text,
            page: '2',
          ),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${passwordEditingController.text}',
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: emailEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Enter your email");
            }
            // if(!RegExp("^[a-zA-Z0-9+_.-]+@[bitsathy]+.[a-z]").hasMatch(value)){
            //   return("Please enter a valid email!");
            // }
            return null;
          },
          onSaved: (value) {
            emailEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.mail_outline,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Full name",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    final passwordField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: passwordEditingController,
          maxLength: 10,
          keyboardType: TextInputType.number,
          style: TextStyle(fontFamily: 'Arimo'),
          validator: (value) {
            if (value!.isEmpty) {
              return ("Password required");
            }
          },
          onSaved: (value) {
            passwordEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Phone number",
              counterText: '',
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              // suffixIcon: InkWell(
              //   onTap: _toggleview,
              //   child: Icon(
              //     _isHidden
              //         ?Icons.visibility_off_outlined
              //         :Icons.visibility_outlined,
              //     color: Color.fromRGBO(0, 0, 0, 1.0),
              //   ),
              // ),
              border: InputBorder.none),
        ));
    final loginButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
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
                "Next >",
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
                        'assets/signupimg.png',
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
                    'Sign Up',
                    style: TextStyle(
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Create your account with name and\nphone number',
                    style: TextStyle(fontFamily: 'Arimo', fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  emailField,
                  SizedBox(
                    height: 15,
                  ),
                  passwordField,
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  loginButton,
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already a member?",
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w900)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MobileLogin()));
                        },
                        child: Text(" Log In",
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
}
