import 'package:auth_with_nodejs/sevices/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;
  var token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.indigoAccent.shade100,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 17.0, right: 17),
            child: TextField(
              decoration: InputDecoration(
                labelText: "username",
              ),
              onChanged: (val) {
                username = val;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.0, right: 17),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "password",
              ),
              onChanged: (val) {
                password = val;
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
            onPressed: () async {
              await AuthService().login(username, password).then((val) {
                if (val.data['success']) {
                  token = val.data['token'];
                  Fluttertoast.showToast(msg: "Authentication success");
                }
              });
            },
            color: Colors.indigoAccent.shade100,
            child: Text(
              "Authenticate",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(
            "OR",
            style: TextStyle(fontSize: 30),
          ),
          RaisedButton(
            onPressed: () async {
              await AuthService().addUser(username, password).then((val) => {
                    if (val.data['success'])
                      {Fluttertoast.showToast(msg: "Authentication success")}
                  });
            },
            color: Colors.indigoAccent.shade100,
            child: Text(
              "Create Account",
              style: TextStyle(fontSize: 20),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              await AuthService().getInfo(token).then((val) => {
                    if (val.data['success'])
                      {Fluttertoast.showToast(msg: val.data['msg'])}
                  });
            },
            color: Colors.indigoAccent.shade100,
            child: Text(
              "Get info",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
