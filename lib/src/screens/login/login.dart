import 'package:centicbids/common/services/auth_service.dart';
import 'package:centicbids/components/custom_toast/custom_toast.dart';
import 'package:centicbids/src/screens/home/home.dart';
import 'package:centicbids/src/screens/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email , _password;
  final auth = FirebaseAuth.instance;
  FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Initialize flutter toast
    fToast = FToast(context);
  }

  //Display toast message
  _showToast({String message, Color color,IconData icon}) {
    fToast.showToast(
      child: CustomToast(
        toastColor: color,
        toastMessage: message,
        icon:icon ,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text('Centic',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                      child: Text('Bids',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        key: const ValueKey("username"),
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Varela',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        onChanged:(value) {
                          setState(() {
                            _email = value.toString();
                          });

                        } ,
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        key: const ValueKey("password"),
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Varela',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        onChanged: (value){
                          setState(() {
                            _password = value.toString();
                          });
                        },
                      ),
                      SizedBox(height: 5.0),
                      SizedBox(height: 40.0),
                      Container(
                        height: 40.0,
                        child: GestureDetector(
                          key: const ValueKey("login"),
                          onTap: () async{
                            final String retVal = await Auth(auth: auth).signIn(
                              email:_email ,
                              password: _password,
                            );
                            if (retVal == "Success") {
                              _showToast(message:"Login Successful",color: Colors.green,icon: Icons.check );
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeBlocProvider()));
                            } else {
                                 _showToast(message:"Login Failed",color: Colors.red,icon: Icons.new_releases );
                            }
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Varela'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New to CenticBids ?',
                    style: TextStyle(fontFamily: 'Varela'),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    key: const ValueKey("register"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp() ));

                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),

              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 5.0),
                  InkWell(
                    key: const ValueKey("continue without login"),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeBlocProvider() ));

                    },
                    child: Text(
                      'Continue Without Login',
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ));
  }
}
