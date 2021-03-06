import 'package:auth_with_nodejs/screens/profile_screen.dart';
import 'package:auth_with_nodejs/viewodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override


  String userToken;
  String username = null;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    token(userViewModel).then((value) => {
          userToken = value,
          userViewModel.getUserInfo(userToken).then((value) => {
                if (this.mounted)
                  {
                    this.setState(() {
                      username = value;
                    }),
                  },
                print(username),
              }),
        });
    return userViewModel.usersViewState == UsersViewState.Idle
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.green.shade100,
              appBar: AppBar(
                backgroundColor: Colors.green.shade100,
                actions: [
                  IconButton(
                      icon: Icon(Icons.person),
                      color: Colors.black,
                      iconSize: 27,
                      onPressed: () {
                        String user=username;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile(user.toString())));
                      }),
                  IconButton(
                    icon: Icon(Icons.logout),
                    color: Colors.black,
                    iconSize: 27,
                    onPressed: () async {
                      bool result = await userViewModel.logOut();
                      if (result) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        Fluttertoast.showToast(msg: "Please try again");
                      }
                    },
                  ),
                ],
              ),
              body: username == null
                  ? Center(child: CircularProgressIndicator())
                  : Text(username),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

Future<String> token(UserViewModel userViewModel) async {
  await userViewModel.getToken();
  String token = userViewModel.token;
  print(token);
  return Future.value(token.toString());
}
