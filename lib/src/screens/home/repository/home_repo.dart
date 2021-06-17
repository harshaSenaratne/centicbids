import 'package:centicbids/common/model/product_model.dart';
import 'package:centicbids/src/screens/home/dao/home_dao.dart';

class HomeRepo {

  HomeDAO homeDAO = HomeDAO();

  Stream<List<ProductModel>> fetchProductDetails() {

    return homeDAO.fetchProducts();
  }

  Future<bool> placeBid({ProductModel bidDetails}) async{
    final String user_id = "4aiU0iLkETflZwNVbLTSTuNssAr1";
    bidDetails.bidder.amount = bidDetails.currentBid;
    bidDetails.bidder.uid = user_id;

   await homeDAO.submit(bidDetails: bidDetails);

  }


  }