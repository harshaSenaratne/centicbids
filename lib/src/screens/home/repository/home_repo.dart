import 'package:centicbids/common/model/product_model.dart';
import 'package:centicbids/src/screens/home/dao/home_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepo {

  HomeDAO homeDAO = HomeDAO();
  final auth = FirebaseAuth.instance;


  Stream<List<ProductModel>> fetchProductDetails() {

    return homeDAO.fetchProducts();
  }

  Future<bool> placeBid({ProductModel bidDetails}) async{
    bidDetails.bidder.amount = bidDetails.currentBid;
    bidDetails.bidder.uid = auth.currentUser.uid ;
    try{
      await homeDAO.submit(bidDetails: bidDetails);
      return true;
    }
    catch(e){
      return false;
    }
  }


  }