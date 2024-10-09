import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppConstants {
  // Cancel token for API requests
  static CancelToken cancelToken = CancelToken();

// Error constants
  static const String noInternet = "no_internet";
  static const String timeOutConnection = "timeoutConnection";
  static const String receivingTimeOut = "receivingTimeOut";
  static const String invalidToken = "Invalid or expired access_token";
// loader
  static Dialog loader = const Dialog(
    backgroundColor: Colors.transparent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Center(
              child: CircularProgressIndicator(
            color: Color(0xFFFF6720),
          )),
        ),
      ],
    ),
  );
}
