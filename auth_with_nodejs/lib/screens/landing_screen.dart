import 'package:auth_with_nodejs/screens/login_screen.dart';
import 'package:auth_with_nodejs/viewodel/user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<UserViewModel>(context);

   if(provider.usersViewState==UsersViewState.Idle){
     if(provider.isUserLoggedIn==true){
       return HomePage();
     }else{
       return Login();
     }
   } else if (provider.usersViewState == UsersViewState.Busy) {
     return Center(
       child:CircularProgressIndicator(),
     );
   }


  }
}
