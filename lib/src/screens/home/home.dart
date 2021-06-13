import 'package:centicbids/components/appbar/custom_appbar.dart';
import 'package:centicbids/components/cardlayout/cardlayout.dart';
import 'package:centicbids/src/screens/item_detail/item_detail.dart';
import 'package:centicbids/src/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final auth = FirebaseAuth.instance;

@override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:Text("CenticBids",style: Theme.of(context).textTheme.headline6,),actions: [
        IconButton(
          onPressed: (){
                  widget.auth.signOut().then((value) =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Login() ))
                  );
          }
          ,
              icon: Icon(Icons.exit_to_app,color: Color(0xFF545D68)),
            )
      ],),

      body:
      ListView(
        padding: EdgeInsets.only(left: 20),
      children: <Widget>[
        SizedBox(height: 15.0),
        Text("Bids",style: Theme.of(context).textTheme.headline4,),
          SizedBox(height: 15.0),

          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount:2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[

                  CustomCard(name:"Cookie mint" ,basePrice: '\$3.99',
                    currentBid:"\$3.99" ,
                    imagePath: "assets/cookiemint.jpg",remainingTime: "13h:55 Mins:34s"),
                  CustomCard(name:"Cookie mint" ,basePrice: '\$3.99',
                    currentBid:"\$3.99" ,remainingTime: "13h:55 Mins:34s",
                    imagePath: "assets/cookiecream.jpg",),

                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),

      // Center(
      //   child: RaisedButton(
      //     child: Text("Logout"),
      //     onPressed: (){
      //       widget.auth.signOut();
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Login() ));
      //     },
      //   ),
      // ),
    );
  }
}
