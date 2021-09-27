import 'package:auth_with_nodejs/model/Profile.dart';
import 'package:auth_with_nodejs/viewodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  String user;

  Profile(this.user);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Data> _list = [];
  final usernameKey = GlobalKey<FormState>();
  bool auto;
  String Myimage;
  String name;
  String surname;
  String username;
  String newUsername;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auto = false;
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    userViewModel.getProfile().then((value) => {
          _list = value.cast<Data>(),
          for (int i = 0; i < _list.length; i++)
            {
              if (_list[i].username == widget.user)
                {
                  this.setState(() {
                    Myimage = _list[i].image.toString();
                    name = _list[i].name;
                    surname = _list[i].surname;
                    username = _list[i].username;
                  })
                }
            }
        });
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        elevation: 0,
      ),
      body: Column(
        children: [
          imagePart(_list),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 258.0),
            child: Text(
              "username",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          usernamePart(_list),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 290.0),
            child: Text(
              "name",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          namePart(),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 270.0),
            child: Text(
              "surname",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          surnamePart(),
          SizedBox(
            height: 15,
          ),
          saveButton(username, Myimage, name, surname),
        ],
      ),
    );
  }

  imagePart(List<Data> list) {
    return Center(
      child: GestureDetector(
        child: CircleAvatar(
          backgroundImage: NetworkImage(Myimage.toString()),
          maxRadius: 75,
          minRadius: 50,
        ),
      ),
    );
  }

  usernamePart(List<Data> list) {
    return username == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: usernameKey,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: TextFormField(
                  // ignore: deprecated_member_use
                  autovalidate: auto,
                  validator: (getUsername) {
                    if (getUsername == "" || getUsername.length < 3) {
                      return "username cant be empty and less 3 character";
                    }
                    if (_list.contains(getUsername)) {
                      return "username already using";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (getString) {
                    setState(() {
                      newUsername = getString;
                    });
                  },
                  // ignore: deprecated_member_use

                  initialValue: username,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      focusColor: Colors.black87,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ))),
            ));
  }

  namePart() {
    return Form(
        child: Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
          onChanged: (getString) {
            setState(() {
              name = getString;
            });
          },
          initialValue: name,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              focusColor: Colors.black87,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ))),
    ));
  }

  surnamePart() {
    return Form(
        child: Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
          onChanged: (getString) {
            setState(() {
              surname = getString;
            });
          },
          initialValue: surname,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              focusColor: Colors.black87,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ))),
    ));
  }

  saveButton(String username, String myimage, String name, String surname) {
    final userViewModel = Provider.of<UserViewModel>(context);
    String resultMessage;
    String parameterUSername = widget.user;
    return SizedBox(
      height: 55,
      child: RaisedButton(
          child: Text(
            "Save Profile Informations",
            style: TextStyle(fontSize: 22),
          ),
          color: Colors.green.shade300,
          onPressed: () async {
            if (!usernameKey.currentState.validate()) {
              setState(() {
                auto = true;
              });
            } else {
              usernameKey.currentState.save();
              String result=await userViewModel.updateUser(
                  parameterUsername: parameterUSername, username: newUsername);
              if(result==null){
                Fluttertoast.showToast(msg: "updated");
              }else{
               String errorMessage=userViewModel.resultMessage;
               Fluttertoast.showToast(msg: errorMessage);
              }
            }
          }),
    );
  }
}
