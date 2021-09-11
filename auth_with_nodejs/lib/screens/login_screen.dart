import 'package:auth_with_nodejs/sevices/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:regexpattern/regexpattern.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;
  var token;
  final passwordKey = GlobalKey<FormState>();
  final usernameKey = GlobalKey<FormState>();
  bool passwordAuto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordAuto= false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 100),
            child: Form(
              key: usernameKey,
              child: TextFormField(
                // ignore: deprecated_member_use
                autovalidate: passwordAuto,
                validator: (username){
                  if(username.isUsername()){
                    return null;
                  }else{
                    return 'Username error please try again';
                  }
                },
                decoration: InputDecoration(
                  labelText: "username",
                ),
                onChanged: (val) {
                  username = val;
                },
              ),
            ),
          ),
          Padding( 
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Form(
              key: passwordKey,
              child: TextFormField(
                // ignore: deprecated_member_use
                autovalidate: passwordAuto,
                validator: (password) {
                  if (password.isPasswordEasy()) {
                    return null;
                  } else {
                    return "Password error please try again";
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "password",
                ),
                onChanged: (val) {
                  password = val;
                },
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          RaisedButton(
            onPressed: () async {
              if (!passwordKey.currentState.validate()) {
                  setState(() {
                    passwordAuto=true;
                  });
              } else {
                passwordKey.currentState.save();
                await AuthService().login(username, password).then((val) {
                  if (val.data['success']) {
                    token = val.data['token'];
                    Fluttertoast.showToast(msg: "Authentication success");
                  }
                });
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            color: Colors.green.shade300,
            child: Text(
              "Sign in",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "OR",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: () async {
              if (!passwordKey.currentState.validate()) {
                setState(() {
                  passwordAuto=true;
                });
              }else{
                await AuthService().addUser(username, password).then((val) => {
                  if (val.data['success'])
                    {Fluttertoast.showToast(msg: "Account created")}
                });
              }


            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            color: Colors.green.shade300,
            child: Text(
              "Sign up",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
