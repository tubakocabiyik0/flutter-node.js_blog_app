import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AuthService {
  /*String url = "http://110.0.2.2:3000/users/authentication";

  login (String username,String password)async{

    var response= await http.post(url,headers: {
    'content-type':'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username':username,
      'password':password
    }),
    );

    if(response.statusCode==201){
      return response.body;
    }else{
      throw Exception('failed');
    }*/

  Dio dio = new Dio();

  login(String username, String password) async {
    try {
      return await dio.post("http://192.168.0.160:3000/users/authentication",
          data: {"username": username, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  addUser(String username, String password) async {
    try{
      return await dio.post("http://192.168.0.160:3000/users/addUser",data: {
        "username":username,
        "password":password
      },options: Options(contentType: Headers.formUrlEncodedContentType));

    }on DioError catch (e){
      print("hata" + e.message);
    }

  }

  getInfo(String token)async{
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get("http://192.168.0.160:3000/users/info");

  }
}
