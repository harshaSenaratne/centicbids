import 'package:centicbids/common/services/auth_service.dart';
import 'package:centicbids/common/shared_preferences/shared_preferences.dart';
import 'package:centicbids/components/custom_toast/custom_toast.dart';
import 'package:centicbids/src/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String _email , _password;
  final auth = FirebaseAuth.instance;
  FToast fToast;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreferenceUtils.init();
    fToast = FToast(context);

  }

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
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'JOIN',
                    style:
                    TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                  child: Text('CenticBids',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold)),
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
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                      onChanged:(value) {
                        setState(() {
                          _email = value.toString();
                        });
                      }
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                      key: const ValueKey("password"),
                      decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Varela',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                      onChanged:(value) {
                        setState(() {
                          _password = value.toString();
                        });
                      }
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          key: const ValueKey("createAccount"),
                          onTap: () async{
                            final String retVal =
                                await Auth(auth:auth).createAccount(
                              email: _email,
                              password: _password,
                            );
                            if (retVal == "Success") {
                              _showToast(message: "User created",color: Colors.green,icon: Icons.check,);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => Login()));

                            } else {
                                 _showToast(message: retVal ,color: Colors.red,icon: Icons.new_releases,);
                            }
                          },
                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Varela'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:
                        Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Varela')),
                        ),


                      ),
                    ),
                  ),
                ],
              )),

        ]));
  }
}
