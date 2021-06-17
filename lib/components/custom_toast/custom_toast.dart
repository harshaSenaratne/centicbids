import 'package:flutter/material.dart';

class CustomToast extends StatefulWidget {
  final Color toastColor;
  final String toastMessage;
  final IconData icon;

  CustomToast({@required this.toastColor, @required this.toastMessage,@required this.icon = Icons.check});


  @override
  _CustomToastState createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> {
  //FToast fToast;

  @override
  void initState() {
    super.initState();
    //fToast = FToast(context);
  }
  Widget _showToast() {
    return
      Container(
        width: 500,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color:widget.toastColor ,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Icon(Icons.check),
            Icon(widget.icon,color: Colors.white,),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Text(
                widget.toastMessage,
                style: TextStyle(
                  color:Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  }

  @override
  Widget build(BuildContext context) {

    return _showToast();
  }
}
