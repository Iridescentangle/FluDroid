import 'package:flutter/material.dart';
class DialogUtil{
  static void showAlertDialog(BuildContext context,String title,String content,String confirmText,Function onConfirm,String cancelText,Function onCancel) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions:<Widget>[
              new FlatButton(child:new Text(cancelText), onPressed: (){
                  onCancel;
                Navigator.of(context).pop();
              },),
              new FlatButton(child:new Text(confirmText), onPressed: (){
                  onConfirm;
                  Navigator.of(context).pop();
              },)
            ]

      ));
  }

}