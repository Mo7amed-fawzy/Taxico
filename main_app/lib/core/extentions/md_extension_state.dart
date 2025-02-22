import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension MDExtensionState on State {
  void mdShowAlert(String title, String message, VoidCallback onPressed,
      {String buttonTitle = "Ok",
      TextAlign mainAxisAlignment = TextAlign.center,
      isForce = false}) {
    showDialog(
        context: context,
        barrierDismissible: !isForce,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed();
                  },
                  child: Text(buttonTitle),
                )
              ],
            ));
  }

  void endEditing() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
