import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppData {
  static String appId = "com.";
  static String appName = "Rbocw";
  static String baseUrl = 'http://sug.sugamatourists.com';

  static int bgColor = 00000000;
  static int textColor = 00000000;
  static Color kPrimaryColor = Color(0xFF97f27e);
  static Color kPrimaryLightColor = Color(0xFFe9f7ea);
  static String currentSelectedValue = "+91";
  static List<String> phoneFormat = ["+91", "+80", "+78"];

  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  static String changeDateFormat(String date, String format) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat(format).format(dateTime);
  }

  static buildDefaultText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.grey[700]),
    );
  }

  static buildSmallText(String name) {
    return Text(
      name,
      style: TextStyle(
          fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black),
    );
  }

  static TextStyle defaultTextStyle() {
    return TextStyle(
        fontSize: 15.0, color: Colors.grey[700], fontWeight: FontWeight.w400);
  }

  static TextStyle defaultHintTextStyle() {
    return TextStyle(
        fontSize: 15.0, color: Colors.grey[400], fontWeight: FontWeight.w400);
  }

  static void showInternetError(
      BuildContext context, Function closeApp, Function retryInternet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "No Internet..!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
          ),
          content: Text(
            "There may be a problem in your internet connection. Please try again!",
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.0,
                height: 1.5,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Cancel".toUpperCase(),
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                closeApp();
              },
            ),
            FlatButton(
              child: Text(
                "Retry".toUpperCase(),
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                retryInternet();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialog(BuildContext context, String btnName,
      String title, String message, Function function) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            content: Text(
              message,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                  height: 1.5,
                  fontWeight: FontWeight.w400),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text(
                  btnName.toUpperCase(),
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  function();
                },
              ),
            ],
          );
        });
  }

  static Future<bool> showConfirmationAlertDialog(
      BuildContext context,
      String btnName,
      String btnNegName,
      String title,
      String message,
      Function closePopUp,
      Function function) {
    return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
              content: Text(
                message,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                    height: 1.5,
                    fontWeight: FontWeight.w400),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  child: Text(
                    btnName.toUpperCase(),
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    function();
                  },
                ),
                FlatButton(
                  child: Text(
                    btnNegName.toUpperCase(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    closePopUp();
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
