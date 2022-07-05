import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_line/model/user_model.dart';
import 'package:flutter_stream_line/screens/home_screen.dart';
import 'package:flutter_stream_line/screens/posts_screen.dart';

import 'login_screen.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  _BioScreenState createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
    // User? user = FirebaseAuth.instance.currentUser;
    // DatabaseReference reference = FirebaseDatabase.instance.ref("Users").child((user?.uid).toString());
    //
    // reference.onValue.listen((event) {
    //   this.loggedInUser = UserModel.fromMap(event.snapshot.value);
    //   print("User details -->"+ event.snapshot.value.toString());
    //   setState(() {});
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Information"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${loggedInUser.firstName} ${loggedInUser.secondName} Bio                ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
              ),
              SizedBox(
                height: 10,
              ),

              Text("Email: ${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              Text("Username: ${loggedInUser.postUsername}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              Text("Role: ${loggedInUser.userRole}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              Text("Registration Time: ${loggedInUser.registrationTime}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),

              SizedBox(
                height: 250,
                child: Image.asset("assets/images/scenery1.png", fit: BoxFit.contain),
              ),

              Text("Post Time: ${loggedInUser.postTime}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),

              Text("Post Line: ${loggedInUser.postLine}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 250,
                child: Image.asset("assets/images/scenery3.png", fit: BoxFit.contain),
              ),

              Text("Post Time: 11:20:13",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),

              Text("Post Line: Nature's place",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 60,
              ),
              ActionChip(
                  label: Text("Go to Home Page"),
                  onPressed: () {
                    logout(context);
                  }),
            ],
          ),
        ),
      ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    // await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }

}
