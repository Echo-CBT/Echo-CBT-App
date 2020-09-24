import 'dart:async';
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'package:parallax/scoped_models/urls.dart';

mixin ChatModel on Model{
  Future<dynamic> startChat(String uid, String friendUid) async {
   var statuscode;
   var message;
   var body=json.encode({
     "uid": uid,
     "friendUid": friendUid
   });
   try{
      print("Sending start chatting Request!");
      http.Response response=await http.post(
          url_startChat,
          headers: {"Content-type": "application/json"},
          body: body
        );
      print("Response Start Chatting:");
      print(response.statusCode);
      print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
        return jsonDecode(response.body);
      }
      else{
        if(response.statusCode==500 || response.statusCode==400 || response.statusCode==404)
          {
            throw "Server Error!";
          }
        else{
          print("This wala error!");
          message=jsonDecode(response.body)["message"];
          // throw jsonDecode(response.body)["message"];
          throw message;
        }
      }
   }
  catch(err){
    print("Error starting chat!....$err");
    return {
      "code": statuscode,
      "message": err
    };
  }
 }

 Future<dynamic> getAllChats(String uid) async {
   var statuscode;
   var message;
   var body=json.encode({
     "uid": uid
   });
   try{
      print("Sending get all chats Request!");
      http.Response response=await http.post(
          url_getAllChats,
          headers: {"Content-type": "application/json"},
          body: body
        );
      print("Response All Get Chats:");
      print(response.statusCode);
      print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
        return jsonDecode(response.body);
      }
      else{
        if(response.statusCode==500 || response.statusCode==400 || response.statusCode==404)
          {
            throw "Server Error!";
          }
        else{
          print("This wala error!");
          message=jsonDecode(response.body)["message"];
          // throw jsonDecode(response.body)["message"];
          throw message;
        }
      }
   }
  catch(err){
    print("Error getting all chats!....$err");
    return {
      "code": statuscode,
      "message": err
    };
  }
 }

 Future<dynamic> getAllMessages(String chatId) async {
   var statuscode;
   var message;
   var body=json.encode({
     "chatId": chatId
   });
   try{
      print("Sending get all messages Request!");
      http.Response response=await http.post(
          url_getAllMessages,
          headers: {"Content-type": "application/json"},
          body: body
        );
      print("Response get all messages:");
      print(response.statusCode);
      print(response.body);
      statuscode=response.statusCode;
      if(response.statusCode==200)
       {
        return jsonDecode(response.body);
      }
      else{
        if(response.statusCode==500 || response.statusCode==400 || response.statusCode==404)
          {
            throw "Server Error!";
          }
        else{
          print("This wala error!");
          message=jsonDecode(response.body)["message"];
          // throw jsonDecode(response.body)["message"];
          throw message;
        }
      }
   }
  catch(err){
    print("Error getting all messaged!....$err");
    return {
      "code": statuscode,
      "message": err
    };
  }
 }
}