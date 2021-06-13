import 'package:centicbids/src/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email , _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome To CenticBids",style: Theme.of(context).textTheme.headline5,)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
              child:
          TextField(
            keyboardType:TextInputType.emailAddress,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              hintText:"Email"
            ),
            onChanged:(value){
              setState(() {
                _email = value.toString();
              });
            },
          )),
          Padding(
              padding: EdgeInsets.all(8.0),
              child:
              TextField(
                style: Theme.of(context).textTheme.bodyText2,
                 obscureText:true,
                  decoration: InputDecoration(
                      hintText:"Password"
                  ),
                onChanged:(value){
                  setState(() {
                    _password = value.toString();
                  });
                },
              )
              
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text("Sign In",style: Theme.of(context).textTheme.button,),
                onPressed: (){
                auth.signInWithEmailAndPassword(email: _email, password: _password);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Home() ));
                }),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text("Sign Up",style: Theme.of(context).textTheme.button,),
                onPressed: (){
                  auth.createUserWithEmailAndPassword(email: _email, password: _password);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Home() ));

                },
              )

            ],
          )

        ],
      ),
    );
  }
}
