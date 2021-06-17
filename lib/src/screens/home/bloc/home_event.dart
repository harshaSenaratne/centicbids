import 'package:centicbids/common/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HomeEvent extends Equatable {}

class FetchProductDetailsEvent extends HomeEvent {
  FetchProductDetailsEvent();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class ProductDetailsLoadedEvent extends HomeEvent {
  List<ProductModel>  products;

  ProductDetailsLoadedEvent({@required this.products});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}