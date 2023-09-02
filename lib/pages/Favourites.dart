import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../Models/user_model.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final tagController = new TextEditingController();
  final fromController = new TextEditingController();
  final toController = new TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getUserData() async {
    try {
      return await usersCollection.doc(user?.uid).get();
    } catch (e) {
      print('Error retrieving user data: $e');
      throw e; // Throw the error to handle it in the FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Favourites',
          style: TextStyle(fontFamily: 'Arimo', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 50,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: getUserData(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error retrieving data: ${snapshot.error}');
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text('User not found.');
            } else {
              DocumentSnapshot userSnapshot = snapshot.data!;

              // Get the reference to the "posts" subcollection
              CollectionReference postsCollection =
                  usersCollection.doc(user?.uid).collection('favourites');

              return StreamBuilder<QuerySnapshot>(
                stream: postsCollection.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error retrieving posts: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text(
                      'No favourites added.',
                      style: TextStyle(fontFamily: 'Arimo'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot fav = snapshot.data!.docs[index];
                        String id = snapshot.data!.docs[index].id;
                        return historyBox('${fav['tag']}', '${fav['from']}',
                            '${fav['to']}', id);
                      },
                    );
                  }
                },
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDialog();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 51, 51, 0.8),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Padding historyBox(String tag, String from, String to, String id) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(255, 245, 245, 1),
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
                        tag,
                        style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(62, 73, 88, 1.0)),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          "DELETE",
                          style: TextStyle(
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 51, 51, 0.9)),
                        ),
                        onTap: () {
                          deleteSubcollection(id);
                        },
                      )
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
                              style: TextStyle(
                                  fontFamily: 'Arimo', color: Colors.grey),
                            ),
                            Text(
                              to,
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

  Future<void> createSubcollection() async {
    // Reference to the parent collection document
    DocumentReference parentDocumentRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    // Reference to the subcollection
    CollectionReference favsubcollection =
        parentDocumentRef.collection('favourites');

    // Create documents within the subcollection
    await favsubcollection.add({
      'tag': tagController.text,
      'from': fromController.text,
      'to': toController.text,
    });

    print('Subcollection created successfully.');
  }

  void deleteSubcollection(String id) async {
    // Reference to the parent collection document
    DocumentReference parentDocumentRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    // Reference to the subcollection
    CollectionReference favsubcollection =
        parentDocumentRef.collection('favourites');

    // Create documents within the subcollection
    await favsubcollection.doc(id).delete();

    print('Deleted successfully.');
  }

  Padding addbox() {
    final fromfield = SizedBox(
      height: 30,
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: TextFormField(
            autofocus: false,
            controller: fromController,
            style: TextStyle(fontFamily: 'Arimo', fontSize: 13),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Enter your email");
              }
            },
            onSaved: (value) {
              fromController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "From",
                hintStyle: TextStyle(fontFamily: 'Arimo', fontSize: 13),
                border: InputBorder.none),
          )),
    );
    final tofield = SizedBox(
      height: 30,
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: TextFormField(
            autofocus: false,
            controller: toController,
            style: TextStyle(fontFamily: 'Arimo', fontSize: 13),
            keyboardType: TextInputType.text,
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
              toController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "To",
                hintStyle: TextStyle(fontFamily: 'Arimo', fontSize: 13),
                border: InputBorder.none),
          )),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: SizedBox(
          height: 140,
          child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            fromfield,
                            Divider(),
                            tofield,
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

  addDialog() {
    showDialog(
        context: context,
        builder: (context) {
          final tagfield = Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              elevation: 2,
              child: TextFormField(
                autofocus: false,
                controller: tagController,
                style: TextStyle(fontFamily: 'Arimo', fontSize: 13),
                keyboardType: TextInputType.text,
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
                  tagController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      LineIcons.tag,
                      color: Colors.grey,
                    ),
                    hintText: "Tag",
                    hintStyle: TextStyle(
                      fontFamily: 'Arimo',
                      fontSize: 13,
                    ),
                    border: InputBorder.none),
              ));
          return AlertDialog(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Tag',
                      style: TextStyle(
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(62, 73, 88, 1.0)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    tagfield,
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Add Location',
                      style: TextStyle(
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(62, 73, 88, 1.0)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    addbox(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: SizedBox(
                            width: 100,
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromRGBO(255, 51, 51, 0.9),
                              child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  createSubcollection();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Add",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Arimo',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
