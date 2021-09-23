import 'dart:math';

import 'package:auth_with_nodejs/model/Profile.dart';
import 'package:auth_with_nodejs/sevices/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UsersViewState {
  Idle,
  Busy,
}

class UserViewModel with ChangeNotifier {
  UsersViewState _usersViewState = UsersViewState.Idle;
  bool _isUserLoggedIn;
  var _token;
  var _resultMessage;
  var _username;
  var msg;

  set usersViewState(UsersViewState value) {
    _usersViewState = value;
    notifyListeners();
  }

  get resultMessage => _resultMessage;

  get username => _username;

  get token => _token;

  UsersViewState get usersViewState => _usersViewState;

  bool get isUserLoggedIn => _isUserLoggedIn;

  UserViewModel() {
    userLoggedIn();
  }

  Future<bool> userLoggedIn() async {
    try {
      _usersViewState = UsersViewState.Busy;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isUserLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      print(_isUserLoggedIn);
      _usersViewState = UsersViewState.Idle;
      return _isUserLoggedIn;
    } finally {
      _usersViewState = UsersViewState.Idle;
    }
  }

  Future<String> login(String username, String password) async {
    try {
      _usersViewState = UsersViewState.Busy;
      await AuthService().login(username, password).then((val) async {
        if (val.data['success']) {
          _token = val.data['token'];
          _resultMessage = null;
          await SharedPreferences.getInstance()
              .then((value) => value.setBool('isLoggedIn', true));
          await SharedPreferences.getInstance()
              .then((value) => value.setString('token', _token));
          return Future.value(null);
        } else {
          String result = val.data['msg'].toString();
          _resultMessage = result;
          return result;
        }
      });
    } finally {
      _usersViewState = UsersViewState.Idle;
    }
  }

  Future<String> getUserInfo(String token) async {
    try {
      _usersViewState = UsersViewState.Busy;
      await AuthService().getInfo(token).then((val) => {
            if (val.data['success'])
              {
                _username = val.data['msg'].toString(),
                print(_username),
              }
          });
      return Future.value(_username);
    } finally {
      _usersViewState = UsersViewState.Idle;
    }
  }

  Future<String> signUp(String username, String password) async {
    try {
      _usersViewState = UsersViewState.Busy;
      await AuthService().addUser(username, password).then((val) async {
        if (val.data['success']) {
          await login(username, password);
          await addProfile(username);
          return Future.value(null);
        } else {
          String result = val.data['msg'].toString();
          _resultMessage = result;
          return result;
        }
      });
    } finally {
      _usersViewState = UsersViewState.Idle;
    }
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    return Future.value(_token);
  }

  Future<bool> logOut() async {
    try {
      _usersViewState = UsersViewState.Busy;
      SharedPreferences sharedP = await SharedPreferences.getInstance();
      await sharedP.remove('isLoggedIn');
      await sharedP.remove('token');
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    } finally {
      _usersViewState = UsersViewState.Idle;
    }
  }

  Future<bool> addProfile(String username) async {
    try {
      _usersViewState = UsersViewState.Busy;
      await AuthService().addProfileInfo(username).then((result) async {
        if (result.data['success']) {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      });
    } finally {
      _usersViewState = UsersViewState.Idle;
    }

  }

  Future<List<Data>> getProfile () async{
    try{
      _usersViewState = UsersViewState.Busy;
      return await AuthService().getProfileInfo();
    }finally{
      _usersViewState = UsersViewState.Idle;
    }
  }
}
