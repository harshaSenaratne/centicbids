import 'package:centicbids/src/screens/home/home.dart';
import 'package:centicbids/src/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;


  // Widget validateUser(){
  //   if(auth.currentUser?.uid !=null){
  //     return HomeBlocProvider();
  //   }
  //   else{
  //     return HomeBlocProvider();
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Login App",
      theme: ThemeData(
        accentColor: Colors.orange,
        primarySwatch: Colors.blue
      ),

      home: HomeBlocProvider(),
    );
  }
}
