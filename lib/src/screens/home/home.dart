import 'package:centicbids/common/model/product_model.dart';
import 'package:centicbids/components/appbar/custom_appbar.dart';
import 'package:centicbids/components/cardlayout/cardlayout.dart';
import 'package:centicbids/src/screens/home/bloc/home_bloc.dart';
import 'package:centicbids/src/screens/home/bloc/home_event.dart';
import 'package:centicbids/src/screens/home/bloc/home_state.dart';
import 'package:centicbids/src/screens/home/repository/home_repo.dart';
import 'package:centicbids/src/screens/item_detail/item_detail.dart';
import 'package:centicbids/src/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class HomeBlocProvider extends StatelessWidget {
  const HomeBlocProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homebloc = HomeBloc()..add(FetchProductDetailsEvent());
    return BlocProvider(create: (context) => homebloc, child: Home());

  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  HomeRepo homeRepo = HomeRepo();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialog(
      {BuildContext context, ProductModel selectedProduct}) async {
    return await showDialog(context: context,
        builder: (context){
          final TextEditingController _textEditingController = TextEditingController();
          return StatefulBuilder(builder: (context,setState){
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        controller: _textEditingController,
                        validator: (value){
                          if(value.isEmpty){
                            return "Place your bid to proceed";
                          }
                          else if (selectedProduct.currentBid >int.parse(value)){
                            return "Amount should exceed current bid";
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(hintText: "Place Your Bid"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Current Highest Bid : \$${selectedProduct.currentBid}" ),
                        ],
                      )
                    ],
                  )),
              actions: <Widget>[
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      // Do something like updating SharedPreferences or User Settings etc.
                      selectedProduct.currentBid  = int.parse(_textEditingController.value.text);
                      homeRepo.placeBid(bidDetails:selectedProduct);
                     // Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }


  userVerification({String imagePath,String basePrice,String name}) {
    // if ( auth.currentUser != null) {
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context) => BidDetail(
    //           assetPath: imagePath,
    //           cookieprice:basePrice,
    //           cookiename:name
    //       )));
    // } else {
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context) => Login(
    //       )
    //   ));
    //
    //       }
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => BidDetail(
            assetPath: imagePath,
            cookieprice:basePrice,
            cookiename:name
        )));
  }

  calculateRemainingTime(Timestamp product_endtime){
    int x = product_endtime.toDate().difference(DateTime.now()).inSeconds;
    return x;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "CenticBids",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) => Navigator.of(context)
                  .pushReplacement(
                      MaterialPageRoute(builder: (context) => Login())));
            },
            icon: Icon(Icons.exit_to_app, color: Color(0xFF545D68)),
          )
        ],
      ),

      body: BlocBuilder<HomeBloc, HomeState>(
    // ignore: missing_return
    builder: (context, state) {
        if(state is ProductDetailsLoadedState){
          print("state--> ${state.productDetails}");
          return     ListView(
            padding: EdgeInsets.only(left: 20),
            children: <Widget>[
              SizedBox(height: 15.0),
              Text(
                "Bids",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 15.0),
              Container(
                  padding: EdgeInsets.only(right: 15.0),
                  width: MediaQuery.of(context).size.width - 30.0,
                  height: MediaQuery.of(context).size.height - 50.0,
                  child: GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 0.8,
                    children: state.productDetails.map((value) {
                      return  CustomCard(
                        name: value.name,
                        basePrice:  value.basePrice,
                        currentBid: value.currentBid,
                        imagePath: "assets/cookiemint.jpg",
                        remainingTime:calculateRemainingTime(value.bidEndDateTime).toString(),
                        ontap:() async =>  await showInformationDialog(context: context,selectedProduct: value)
                            //userVerification(name:"Cookie mint",basePrice: "\$3.99" ,imagePath:value.imagePath ),
                      );
                    }).toList()

                  )),
              SizedBox(height: 15.0)
            ],
          );

    }
        else {
       return   Container();
        }

      }
      )


    );
  }
}
