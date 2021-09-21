import 'package:auth_with_nodejs/screens/landing_screen.dart';
import 'package:auth_with_nodejs/screens/login_screen.dart';
import 'package:auth_with_nodejs/viewodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
      create:(context)=>UserViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication',
         home: LandingPage(),
      ),
    );
  }
}
