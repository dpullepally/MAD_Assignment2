import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_line/model/user_model.dart';
import 'package:flutter_stream_line/screens/posts_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bio_screen.dart';
import 'login_screen.dart';
import 'package:flutter_stream_line/screens/bio_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final postUsernameEditingController = new TextEditingController();
  final postLineEditingController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc("CWd0wFkEWKc4NIjGZExqJ00AhrC2")
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


    final firstNameField = TextFormField(
        autofocus: false,
        controller: postUsernameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Username Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          postUsernameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          hintText: "Enter username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: postLineEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Comment cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          postLineEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          hintText: "Post comment",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));



    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: SafeArea(
    child: SingleChildScrollView(child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,

              ),
              SizedBox(
                height: 250,
                child: Image.asset("assets/images/scenery2.png", fit: BoxFit.contain),
              ),

              firstNameField,
              secondNameField,
           Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  this.loggedInUser.postIsLiked = "Liked";
                  postDetailsToFirestore();
                },
                  child: Container(
                    height: 50,
                    child: Image.asset("assets/images/like.png", fit: BoxFit.contain),
                  )
              ),GestureDetector(
                  onTap: () {
                    postDetailsToFirestore();
                  },
                  child: Container(
                    height: 30,
                    child: Image.asset("assets/images/post_comment.png", fit: BoxFit.contain),
                  )
              ),
            ],
          ),
              SizedBox(
                height: 60,
              ),
              ActionChip(
                  label: Text("Create your own feed"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => PostsScreen()));
                  }),
              ActionChip(
                  label: Text("Logout"),
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
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference databaseReference = database.ref("Users");

    UserModel userModel = UserModel();

    // writing all the values'
    userModel.email = loggedInUser.email;
    userModel.uid = loggedInUser.uid;
    print("User details-->" + loggedInUser.uid.toString());
    print("User details-->" + databaseReference.path);

    userModel.firstName = loggedInUser.firstName;
    userModel.secondName = loggedInUser.secondName;
    userModel.userRole = loggedInUser.userRole;
    userModel.registrationTime = loggedInUser.registrationTime;

    userModel.postTime = formattedDate;
    userModel.postLine = postLineEditingController.text;
    userModel.postUsername = postUsernameEditingController.text;
    userModel.postIsLiked = loggedInUser.postIsLiked;

    await firebaseFirestore
        .collection("users")
        .doc(loggedInUser.uid)
        .set(userModel.toMap());

    // await databaseReference.child(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Comment created successfully :) ");

  }
}
