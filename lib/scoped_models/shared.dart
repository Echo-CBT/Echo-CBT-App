import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:parallax/models/user.dart';

SharedPreferences pref;

class Shared {
  static void setUserData(User user) {
    if (pref != null) {
      pref.setString('userDetails', jsonEncode(user.toJson()));
      print("User Details Set!");
    } else {
      print("Error saving user details!");
    }
  }

  static Future<User> getUserDetails() async {
    if (pref != null) {
      // return jsonDecode(pref.getString('userDetails'));
      var user = User.fromJson(jsonDecode(pref.getString('userDetails')));
      return user;
      //if(user == null) {
      //  return User(uid:'a', name: 'dummy', email: 'a', mobile: '0');
      //} else {
      //  return user;
      //}
    } else {
      print("Error getting user details");
      return null;
    }
  }

  static void initialize() async {
    //SharedPreferences.setMockInitialValues({});
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
      print("Shared preferences initialized!");
    } else {
      return;
    }
  }

  static void setDoctorEmail(String email) {
    pref.setString('doctorEmail', email);
  }
  
  static Future<String> getDoctorEmail() {
    return Future.value(pref.getString('doctorEmail'));
  }
}
