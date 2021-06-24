import 'package:centicbids/common/model/product_model.dart';
import 'package:centicbids/components/appbar/custom_appbar.dart';
import 'package:centicbids/components/cardlayout/cardlayout.dart';
import 'package:centicbids/components/custom_toast/custom_toast.dart';
import 'package:centicbids/src/screens/home/bloc/home_bloc.dart';
import 'package:centicbids/src/screens/home/bloc/home_event.dart';
import 'package:centicbids/src/screens/home/bloc/home_state.dart';
import 'package:centicbids/src/screens/home/repository/home_repo.dart';
import 'package:centicbids/src/screens/product_detail/product_detail.dart';
import 'package:centicbids/src/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

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
  UserCredential user;
  HomeRepo homeRepo = HomeRepo();
  FToast fToast;
  var uuid = Uuid();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _showToast({String message, Color color,IconData icon}) {
    fToast.showToast(
      child: CustomToast(
        toastColor: color,
        toastMessage: message,
        icon:icon ,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  // Display dialog box to enter the bidding amount
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
                          else if(selectedProduct.basePrice >int.parse(value)){
                            return "Bid amount should exceed base price";

                          }
                          else if (selectedProduct.currentBid >int.parse(value) || selectedProduct.currentBid == int.parse(value)){
                            return "Bid amount should exceed current price";
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
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      selectedProduct.currentBid  = int.parse(_textEditingController.value.text);
                      await homeRepo.placeBid(bidDetails:selectedProduct).then((value) {
                        if(value){
                          _showToast(message: "Submission Successful" ,color: Colors.green,icon: Icons.check,);
                          Navigator.of(context).pop();
                        }
                        else
                        {
                          _showToast(message: "Submission Failed" ,color: Colors.red,icon: Icons.new_releases,);
                        }
                      });
                    }
                  },
                ),
              ],
            );
          });
        });
  }


//Calculates the time difference between bid end time & current date time
  calculateRemainingTime(Timestamp product_endtime){
    int calculatedRemainingTime = product_endtime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
    return calculatedRemainingTime;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast(context);
  }

  // Pull down to referesh the list
  Future<void> _pullToRefresh() async{
    BlocProvider.of<HomeBloc>(context).add(FetchProductDetailsEvent());
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: Text(
          auth?.currentUser?.email??"",
          style: TextStyle(
            color: Colors.white
          )
        ),
        actions: [
          auth.currentUser?.email != null?
          IconButton(
            key:const ValueKey("logout"),
            onPressed: () {
              auth.signOut().then((value) => Navigator.of(context)
                  .pushReplacement(
                      MaterialPageRoute(builder: (context) => Login())));
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
          ):
          IconButton(
            key:const ValueKey("login"),
            onPressed: () {
              auth.signOut().then((value) => Navigator.of(context)
                  .pushReplacement(
                  MaterialPageRoute(builder: (context) => Login())));
            },
            icon: Icon(Icons.person, color: Colors.white),
          )
        ],
      ),

      body: BlocBuilder<HomeBloc, HomeState>(
    // ignore: missing_return
    builder: (context, state) {
        if(state is ProductDetailsLoadedState){
          return RefreshIndicator(
            onRefresh: _pullToRefresh,
            child: ListView(
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
                          imagePath: value.imagePath,
                            heroTag: uuid.v1(),
                          remainingTime:calculateRemainingTime(value.bidEndDateTime).toString(),
                          viewDetails: () async => Navigator.of(context)
                              .push(
                              MaterialPageRoute(builder: (context) => ProductDetail(
                                name:value.name,
                                assetPath: value.imagePath,
                                itemDescription: value.description,
                                itemPrice: value.basePrice,
                                heroTag: uuid.v1(),
                              ))),
                          ontap:() async{
                            if(auth.currentUser?.email != null){
                              await showInformationDialog(context: context,selectedProduct: value);
                            }
                            else if(auth.currentUser?.email == null){
                              _showToast(message: "Please login to proceed",color: Colors.orange,icon: Icons.new_releases);
                            }
                          }
                        );
                      }).toList()

                    )),
                SizedBox(height: 15.0)
              ],
            ),
          );
    }
        else {return   Container();
        }

      }
      )
    );
  }
}
