import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseProvider {
  static FirebaseFirestore firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
  );
}