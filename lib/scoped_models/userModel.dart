import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'package:parallax/scoped_models/shared.dart';
import 'package:parallax/models/user.dart';
import 'package:parallax/scoped_models/urls.dart';

mixin UserModel on Model {
  // Future<dynamic> logIn(String uid, String name) async {
  Future<dynamic> register(User user) async {
    var statuscode;
    var message;
    //  var body;
    var body = json.encode({
      "uid": user.uid,
      "displayName": user.name,
      "email": user.email,
      "mobile": "9876543210",
    });
    try {
      print("Sending Register Request!");
      http.Response response = await http.post(url_register,
          headers: {"Content-type": "application/json"}, body: body);
      print("Response Register:");
      print(response.statusCode);
      print(response.body);
      statuscode = response.statusCode;
      if (response.statusCode == 200 || response.statusCode == 201) {
        Shared.setUserData(user);
        return jsonDecode(response.body);
      } else {
        print(jsonDecode(response.body)["error"]);
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          message = jsonDecode(response.body)["error"];
          throw message;
        } else {
          message = jsonDecode(response.body)["error"];
          throw message;
        }
      }
    } catch (err) {
      print("Error Registering!....$err");
      throw message;
    }
  }

  Future<dynamic> logIn(String uid) async {
    var message;
    try {
      print("Sending Log In Request!");
      http.Response response = await http.get(
        url_login,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer " + uid,
        },
      );
      print("Response LogIn:");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        User user = User.fromBackend(jsonDecode(response.body)["payload"]);
        Shared.setUserData(user);
        return jsonDecode(response.body);
      } else {
        print(jsonDecode(response.body)["error"]);
        if (response.statusCode == 500 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          message = jsonDecode(response.body)["error"];
          throw message;
        } else {
          message = jsonDecode(response.body)["error"];
          throw message;
        }
      }
    } catch (err) {
      print("Error Logging In!....$err");
      throw message;
    }
  }
}
