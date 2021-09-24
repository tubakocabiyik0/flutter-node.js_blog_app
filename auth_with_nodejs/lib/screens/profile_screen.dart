import 'package:auth_with_nodejs/model/Profile.dart';
import 'package:auth_with_nodejs/viewodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  String user;
  Profile(this.user);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Data> _list=[];
  String Myimage;
  String name;
  String surname;
  String username;
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    userViewModel.getProfile().then((value) => {
      _list=value.cast<Data>(),
      for(int i =0;i<_list.length;i++){
        if(_list[i].username == widget.user ){
          this.setState(() {
            Myimage=_list[i].image.toString();
            name=_list[i].name;
            surname=_list[i].surname;
            username=_list[i].username;
          })
        }
      }
    });
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(backgroundColor: Colors.green.shade100,elevation: 0,),
      body: Column(
           children: [
             imagePart(_list),
           ],
      ),
    );
  }

  imagePart(List<Data> list) {
    return CircleAvatar(
      backgroundImage: NetworkImage(Myimage.toString()),radius: 35,
    );
  }
}
