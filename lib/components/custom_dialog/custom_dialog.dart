import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DialogAction { yes, abort }

class CustomDialog {
  static Future<List<Object>> cstmDialog(BuildContext context, String type, String title, String body,) async {
    final _textController = TextEditingController();

    DialogAction action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

//      ****  Load Note Dialog ***** //
          Widget invalidUserAlert() {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: AlertDialog(
                title: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      color: Colors.black,
                      fontSize:14,
                )),
                content: Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: ListTile(
                                leading: RichText(
                                  text: TextSpan(
                                    text: 'Railcar:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Roboto',
                                        letterSpacing: 0.5,
                                        color: Theme.of(context).textTheme.body1.color,
                                        fontSize: 14),
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:16),
                                            child: Text(body,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    fontFamily: 'Roboto',
                                                    letterSpacing:0.5,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .body1
                                                        .color,
                                                    fontSize:16),
                                          )),
                                      )],
                                  ),
                                ))),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: TextField(
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.teal)),
                                hintText: 'Enter text here ...',
                                hintStyle: TextStyle(
                                    fontSize:16
                                        ,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing:0.25)),
                            controller: _textController,
                            style: TextStyle(color: Colors.black),
                            maxLines: 10,
                            keyboardType: TextInputType.multiline,
                          ),
                        )
                      ],
                    )),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 24,
                      ),
                      child: Container(
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.of(context).pop(DialogAction.abort),
                            child: RichText(
                              text: TextSpan(
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                  // ignore: deprecated_member_use
                                      .body1,
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: 'CANCEL',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing:1.25,
                                            color: Color(0xFF3e8aeb)))
                                  ]),
                            ),
                          ))),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical:24),
                      child: Container(
                        width: 100,
                        height: 100,
                        child: FlatButton(
                            onPressed: () =>
                                Navigator.of(context).pop(DialogAction.yes),
                            child: Text(
                              'SUBMIT NOTE',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing:1.25,
                                  color: Colors.white),
                            ),
                            color: Color(0xFF508be4),
                            textColor: Colors.white,
                            disabledColor: Color(0xFF3e8aeb),
                            disabledTextColor: Colors.black,
                            splashColor: Color(0xFF3e8aeb)),
                      )),
                ],
              ),
            );
          }


          return type == "invalid_user"
              ? invalidUserAlert()
              : Container();
        });
    if (action == null) {
      action = DialogAction.abort;
    }
    List<Object> returnList = new List<Object>();
    returnList.add(action);
    returnList.add(_textController.text);
    return returnList;
  }
}
