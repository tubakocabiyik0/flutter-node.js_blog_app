import 'package:auth_with_nodejs/screens/login_screen.dart';
import 'package:auth_with_nodejs/viewodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 328.0),
            child: BackButton(
              color: Colors.black87,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        backgroundColor: Colors.green.shade100,
        elevation: 0,
      ),
      body: ListView(
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.green.shade200,
            focusColor: Colors.green,
            child: ListTile(
              leading: Icon(Icons.wifi_protected_setup),
              title: Text("Change password"),
              focusColor: Colors.green,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RawMaterialButton(
            onPressed: () {deleteAccount();},
            fillColor: Colors.green.shade200,
            focusColor: Colors.green,
            child: ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text("Delete Account"),
              focusColor: Colors.green,
            ),
          ),
        ],
      ),
    );

  }

  void deleteAccount() async{
    final userViewModel = Provider.of<UserViewModel>(context,listen: false);
    String username=userViewModel.username;
    String resultUser= await userViewModel.deleteUser(username);
    String resultProfile=await userViewModel.deleteProfile(username);
    if(resultUser==null && resultProfile==null){
      Fluttertoast.showToast(msg: "Deleted");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));

    }else{
      String message=userViewModel.resultMessage;
      Fluttertoast.showToast(msg: message);
    }
  }
}
