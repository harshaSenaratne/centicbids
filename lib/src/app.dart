import 'package:centicbids/common/constants/constants.dart';
import 'package:centicbids/common/shared_preferences/shared_preferences.dart';
import 'package:centicbids/src/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final auth = FirebaseAuth.instance;

  String pushToken = '';

  String _messageText = "Waiting for message...";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Initialize shared preference
    PreferenceUtils.init();

    //Firebase push notification configuration
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "$message";
        });
        print(" $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "$message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "$message";
        });
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    // Saving push notification token to the shared preferences
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        pushToken = token;
      });
      PreferenceUtils.setString(APP_CONST.SHARED_PREFERENCE_PUSH_TOKEN, pushToken);
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login App",
      theme: ThemeData(
        accentColor: Colors.orange,
        primarySwatch: Colors.blue
      ),

      home: HomeBlocProvider(),
    );
  }
}
