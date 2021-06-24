import 'dart:async';
import 'package:centicbids/src/screens/home/bloc/home_event.dart';
import 'package:centicbids/src/screens/home/bloc/home_state.dart';
import 'package:centicbids/src/screens/home/repository/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(ProductDetailsLoadedState(productDetails: []));
  HomeRepo homeRepo = HomeRepo();
  StreamSubscription streamSubscription;


  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // // TODO: implement mapEventToState
    if (event is FetchProductDetailsEvent) {
      yield*  _mapProductDetailData();
    }
    else if(event is ProductDetailsLoadedEvent){
      yield ProductDetailsLoadedState(productDetails: event.products);
    }
  }

  Stream<HomeState> _mapProductDetailData() async* {
    streamSubscription?.cancel();
    yield ProductDetailsLoadingState();
    streamSubscription = homeRepo.fetchProductDetails().listen((eve) async {
      add(ProductDetailsLoadedEvent(products: eve));
    });
  }
  

}