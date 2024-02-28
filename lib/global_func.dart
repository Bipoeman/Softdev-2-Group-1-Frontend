import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ruam_mitt/global_const.dart';
import 'package:ruam_mitt/global_var.dart';

Future<int> requestNewToken(BuildContext context) async {
  Uri url = Uri.parse("$api$refreshTokenRoute");
  http.Response response = await http.get(url, headers: {
    "Content-Type": "application/json",
    "Authorization": refreshToken
  });

  if (response.statusCode == 200) {
    dynamic resJson = json.decode(response.body);
    publicToken = resJson['accessjwt'];
    refreshToken = resJson['refreshjwt'];
  } else if (response.statusCode == 403) {
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          loginPageRoute, (Route<dynamic> route) => false);
    }
  }
  return response.statusCode;
}
