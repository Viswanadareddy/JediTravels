import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginout/start.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginout/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<DocumentSnapshot> getUserData(String uid) async {
    User? user = FirebaseAuth.instance.currentUser;
    var data = await _firestore.collection('users').doc(user!.uid).get();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile Details',
              style: TextStyle(fontSize: 22, color: Constants.textColor)),
          backgroundColor: Constants.buttonColor,
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: getUserData(
            user!.uid,
          ),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return profileView(
                  snapshot.data!['name'], snapshot.data!['email']);
            }
          },
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView(String name, String email) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Stack(
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  'assets/avatar.jpg',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ))
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Constants.buttonColor),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: TextStyle(color: Constants.textColor),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Constants.background,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border:
                          Border.all(width: 1.0, color: Constants.textColor)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        email,
                        style: TextStyle(color: Constants.textColor),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Constants.background,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border:
                          Border.all(width: 1.0, color: Constants.textColor)),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Align(
                        child: TextButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartPage()),
                            (route) => false);
                      },
                      child: Text('Log Out',
                          style: TextStyle(
                              color: Constants.textColor, fontSize: 20)),
                    )),
                    decoration: BoxDecoration(
                        color: Constants.extraColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        )),
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
