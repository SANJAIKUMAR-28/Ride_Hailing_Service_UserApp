import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocito/LoginSignup/Signup.dart';
import 'package:velocito/pages/HomeScreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;
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
              hintText: "Enter your email",
              hintStyle: TextStyle(fontFamily: 'Arimo'),
              border: InputBorder.none),
        ));
    final passwordField = Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(196, 196, 196, 0.2),
        child: TextFormField(
          autofocus: false,
          controller: passwordEditingController,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(fontFamily: 'Arimo'),
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
    final loginButton = Material(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(255, 51, 51, 0.9),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          signIn(emailEditingController.text, passwordEditingController.text);
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
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/loginimg.png',
                    fit: BoxFit.fill,
                    height: 200,
                    width: 250,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  emailField,
                  SizedBox(
                    height: 15,
                  ),
                  passwordField,
                  SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 195,
                    ),
                    InkWell(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(255, 51, 51, 1.0),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    ),
                  ]),
                  SizedBox(height: 40),
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
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
                                  builder: (context) => Signup()));
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

  SignInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    print(userCredential.user?.displayName);
  }

  void signIn(String email, String password) async {
    setState(() {
      loading = true;
    });
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        setState(() {
          loading = false;
        });
      });
    }
  }
}
