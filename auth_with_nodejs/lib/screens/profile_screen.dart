import 'package:auth_with_nodejs/viewodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Profile> _list=[];

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    userViewModel.getProfile().then((value) => {
       print(value.length),
      _list=value.cast<Profile>(),
    });
    return Container();
  }
}
