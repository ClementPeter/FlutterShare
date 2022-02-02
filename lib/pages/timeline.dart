import 'package:flutter/material.dart';
import '../widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Initializing Firebase Cloud firestore database
FirebaseFirestore firestore = FirebaseFirestore.instance;

//Setting my collection variable
final userRef = firestore.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  //List to hold usernames
  List<dynamic> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  //Using Funtion to get Data from Firebase
  getUsers() async {
    QuerySnapshot snapshot = await userRef.get();
    setState(() {});
    users = snapshot.docs;

    snapshot.docs.forEach((QueryDocumentSnapshot doc) {
      print(doc.data());
      print(doc.exists);
      print(doc.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Container(
          child: ListView(
        children: users.map((users) => Text(users['username'])).toList(),
          
        
      )),
    );
  }
}
