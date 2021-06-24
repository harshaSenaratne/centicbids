import 'package:centicbids/common/dao/base_dao.dart';
import 'package:centicbids/common/database_provider/database_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpDao extends BaseDao {
  SignUpDao() : super("users");
  FirebaseFirestore _firestore = DatabaseProvider.firestore;

  //Saving push token to the user collection
  Future<bool> addPushToken({String uid, String pushToken})async{
    await _firestore.collection("users").doc(uid).update({'token': pushToken}).then((value) => true);
  }

}