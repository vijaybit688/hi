import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> getInternetStatus(BuildContext context) async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    print('YAY! Free cute dog pics!');
  } else {
    print('No internet :( Reason:');

  }
  return result;
}

 checkConnection(BuildContext context,String message) async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    print('YAY! Free cute dog pics!');
  } else {
    print('No internet :( Reason:');
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Color(0xFF282539),
            title: Text(
              "Alert !!!",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            content: Text(
                message.isEmpty?"No Internet Connection Please Turn On Your Internet Before Pressing Ok ":"Please Restart The app and check internet Connection",
                style: TextStyle(color: Colors.white, fontSize: 22)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok",
                      style: TextStyle(color: Colors.white, fontSize: 22)))
            ],
          );
        });
  }
}
