import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocito/LoginSignup/Login.dart';
import 'package:velocito/LoginSignup/SignupOTP.dart';
import 'package:email_otp/email_otp.dart';

import '../Models/user_model.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  EmailOTP myauth = EmailOTP();
  final _formkey = GlobalKey<FormState>();
  final nameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  bool _isHidden = true;
  bool _isHidden2 = true;
  @override
  Widget build(BuildContext context) {
    final nameField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: nameEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Name cannot be empty");
            }

            return null;
          },
          onSaved: (value) {
            nameEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon:
                  Icon(Icons.person_outline_rounded, color: Colors.grey),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Full Name",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
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
              hintText: "Email ID",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    final phoneField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: phoneEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty) {
              return ("Enter your mobile.no");
            }
            if (value.length > 10) {
              return ("Please enter a number less than 10 characters");
            }
            return null;
          },
          onSaved: (value) {
            phoneEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.phone_android_outlined,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Phone Number",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    final passwordField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: passwordEditingController,
          style: TextStyle(fontFamily: 'Arimo'),
          obscureText: _isHidden,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please enter valid password(Min. 6 character");
            }
          },
          onSaved: (value) {
            passwordEditingController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Password",
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
    final signupButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            myauth.setConfig(
                appEmail: "teamrogue2025@gmail.com",
                appName: "Velocito",
                userEmail: emailEditingController.text,
                otpLength: 6,
                otpType: OTPType.digitsOnly);
            if (await myauth.sendOTP() == true) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("OTP has been sent"),
              ));
              Navigator.pushAndRemoveUntil(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => SignupOTP(
                            mail: emailEditingController.text.trim(),
                            password: passwordEditingController.text,
                            name: nameEditingController.text.trim(),
                            phn: phoneEditingController.text.trim(),
                            myauth: myauth,
                          )),
                  (route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Oops, OTP send failed"),
              ));
            }
          }
        },
        child: Text(
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
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/signupimg.png',
                    fit: BoxFit.fill,
                    height: 200,
                    width: 250,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  nameField,
                  SizedBox(
                    height: 15,
                  ),
                  emailField,
                  SizedBox(
                    height: 15,
                  ),
                  phoneField,
                  SizedBox(
                    height: 15,
                  ),
                  passwordField,
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black38,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        'or continue with',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black38,
                            fontFamily: 'Arimo'),
                      ),
                      Expanded(
                          child: Divider(
                              color: Colors.black38, indent: 10, endIndent: 10))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Image.asset(
                          'assets/google.png',
                          height: 25,
                          width: 25,
                        ),
                        onTap: () {
                          SignInWithGoogle();
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: Image.asset(
                          'assets/fb.png',
                          height: 25,
                          width: 25,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: Image.asset(
                          'assets/apple.png',
                          height: 25,
                          width: 25,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  signupButton,
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
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

  SignInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = user.displayName;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    print(userCredential.user?.displayName);
  }
}
