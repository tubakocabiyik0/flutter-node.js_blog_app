import 'dart:convert';
import 'dart:math';

import 'package:auth_with_nodejs/model/Profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String getRandom() {
    var random = Random(50000);
    return random.toString();
  }

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
    try {
      return await dio.post("http://192.168.0.160:3000/users/addUser",
          data: {"username": username, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print("hata" + e.message);
    }
  }

  getInfo(String token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get("http://192.168.0.160:3000/users/info");
  }

  addProfileInfo(String username) async {
    try {
      return await dio.post("http://192.168.0.160:3000/profile/addProfile",
          data: {
            "username": username,
            "name": username + getRandom(),
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print("hata" + e.message);
    }
  }

  Future<List<Data>> getProfileInfo() async {
    try {
      List<Data> _list = [];
      final response =
      await http.get("http://192.168.0.160:3000/profile/getProfile");
      final bodyResponse = jsonDecode(response.body);
      print(bodyResponse['data']);
      if (bodyResponse['data'] != null) {
        for (var data in bodyResponse['data']) {
          Data profile = new Data(
              id:data["_id"],
              username:data["userName"],
              name:data["name"],
              surname:data["surname"],
              image:data["image"],
              v:data["__V"]
    );
          _list.add(profile);
    }

    }
    print(_list.length);
    return _list;
    } on DioError catch (e) {
    print("hata" + e.message);
    }
  }
}
