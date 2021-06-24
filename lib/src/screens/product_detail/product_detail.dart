import 'package:centicbids/components/appbar/custom_appbar.dart';
import 'package:centicbids/src/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

class ProductDetail extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  final assetPath, itemDescription,heroTag, name;
  final int itemPrice;

  ProductDetail({this.name,this.assetPath, this.itemPrice, this.itemDescription,this.heroTag});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        title: Text(
            auth?.currentUser?.email??"",
            style: TextStyle(
                color: Colors.white
            )
        ),
        actions: [
          //If user is logged in show logout else login icon
          auth.currentUser?.email != null?
          IconButton(
            key:const ValueKey("logout"),
            onPressed: () {
              auth.signOut().then((value) => Navigator.of(context)
                  .pushReplacement(
                  MaterialPageRoute(builder: (context) => Login())));
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
          ):
          IconButton(
            key:const ValueKey("login"),
            onPressed: () {
              auth.signOut().then((value) => Navigator.of(context)
                  .pushReplacement(
                  MaterialPageRoute(builder: (context) => Login())));
            },
            icon: Icon(Icons.person, color: Colors.white),
          )
      ],),

      body: ListView(
          children: [
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0,right: 5.0),
                  child: IconButton(
                    key:const ValueKey("back"),
                    onPressed:() async => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.orange),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Text(
                      name,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 42.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF17532))
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.0),
      Hero(
          tag: heroTag,
          child: Container(
              height: 150.0,
              width: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(assetPath),
                      fit: BoxFit.contain)))),
            SizedBox(height: 20.0),
            Center(
              child: Text('Base Price : \$ ${itemPrice.toString()}',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF17532))),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(itemDescription,
                    style: TextStyle(
                        color: Color(0xFF575E67),
                        fontFamily: 'Varela',
                        fontSize: 24.0)),
              ) ,
            ),
           
            SizedBox(height: 20.0),
          ]
      ),

    );
  }
}