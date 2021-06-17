
import 'package:centicbids/common/model/product_model.dart';
import 'package:centicbids/src/screens/item_detail/item_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductDetailsLoadingState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductDetailsLoadedState extends HomeState {

  List<ProductModel> productDetails;
  ProductDetailsLoadedState({@required this.productDetails});

  @override
  // TODO: implement props
  List<Object> get props => null;
}