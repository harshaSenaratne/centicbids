import 'package:centicbids/common/model/product_model.dart';
import 'package:centicbids/src/screens/home/dao/home_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepo {

  HomeDAO homeDAO = HomeDAO();
  final auth = FirebaseAuth.instance;

//Retrieve products
  Stream<List<ProductModel>> fetchProductDetails() {
    return homeDAO.fetchProducts();
  }

  //Submit bid amount
  Future<bool> placeBid({ProductModel bidDetails}) async{
    bidDetails.bidder.amount = bidDetails.currentBid;
    bidDetails.bidder.uid = auth.currentUser.uid ;
    return  await homeDAO.submit(bidDetails: bidDetails);
  }


  }