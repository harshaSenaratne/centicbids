import 'package:centicbids/common/database_provider/database_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class BaseDao {
  FirebaseFirestore _firestore = DatabaseProvider.firestore;
  CollectionReference collection;

  BaseDao(collectionName) {
    collection = _firestore.collection(collectionName);
  }

  Query BaseQuery() {
    return collection;
  }
}
