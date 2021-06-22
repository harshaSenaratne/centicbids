
import 'package:centicbids/common/constants/constants.dart';
import 'package:centicbids/common/shared_preferences/shared_preferences.dart';
import 'package:centicbids/src/screens/signup/dao/signup_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth;
  SignUpDao signUpDao = SignUpDao();
  String pushToken = PreferenceUtils.getString(APP_CONST.SHARED_PREFERENCE_PUSH_TOKEN);

  Auth({this.auth});

  Stream<User> get user => auth.authStateChanges();

  Future<String> createAccount({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      ).then((value) =>    signUpDao.addPushToken(uid:value.user.uid,pushToken: pushToken));
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
}