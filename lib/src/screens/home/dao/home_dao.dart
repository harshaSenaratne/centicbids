import 'package:centicbids/common/dao/base_dao.dart';
import 'package:centicbids/common/database_provider/database_provider.dart';
import 'package:centicbids/common/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeDAO extends BaseDao {
  HomeDAO() : super("products");
  FirebaseFirestore _firestore = DatabaseProvider.firestore;

  Stream<List<ProductModel>> fetchProducts() {
    return BaseQuery().where("active",isEqualTo:true).snapshots().map((event)
    => event.docs.map((doc) => ProductModel.fromMap(doc.data())).toList());
  }

  Future<bool> submit({ProductModel bidDetails})async{
    await _firestore.collection("products").doc(bidDetails.id).set(bidDetails.toMap()).then((value) => true);
  }

}