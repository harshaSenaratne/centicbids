import 'package:centicbids/src/screens/item_detail/item_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CustomCard extends StatefulWidget {
  CustomCard({@required this.name, @required this.basePrice, @required this.currentBid,this.imagePath,this.remainingTime});



  final String name;
  final String basePrice;
  final String currentBid;
  final String imagePath;
  final String remainingTime;


  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return    Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 2.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BidDetail(
                      assetPath: widget.imagePath,
                      cookieprice:widget.basePrice,
                      cookiename: widget.name
                  )));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Base Price : ${widget.basePrice}",style:  TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 10.0) )
                            // isFavorite
                            //     ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                            //     : Icon(Icons.favorite_border,
                            //     color: Color(0xFFEF7532))
                          ])),
                  Hero(
                      tag: widget.imagePath,
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(widget.imagePath),
                                  fit: BoxFit.contain)))),

                  // Text( "${widget.remainingTime}",
                  //     style: TextStyle(
                  //         color: Color(0xFFCC8053),
                  //         fontFamily: 'Varela',
                  //         fontSize: 14.0)),

                  CountdownTimer(
                    controller: controller,
                    onEnd: onEnd,
                    endTime: endTime,
                    widgetBuilder: (_, CurrentRemainingTime time) {
                      if (time == null) {
                        return Text('Closed Bid',style: Theme.of(context).textTheme.bodyText2,);
                      }
                      return Text(
                          '${time.hours??"0"} h  ${time.min??"0"} m ${time.sec??"0"} s',style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          color: Color(0xFFD17E50)
                      ),);

                    },
                  ),
                  SizedBox(height: 7.0),
                  Text( "${widget.currentBid}",
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 18.0)),

                  Text( "Current Bid",
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 10.0)),

                  Text(widget.name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 16.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Bid Now',
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD17E50),
                                    fontSize: 16.0)),

                          ]
                      )),
                ]))));
  }
}
