import 'package:flutter/material.dart';
import 'package:hello_world_from_dart/components/menu/menu.dart';
import 'package:hello_world_from_dart/components/menu/menu_requests/cat_requests.dart';
import 'package:hello_world_from_dart/components/personal_kitties/my_kitties.dart';
import 'package:hello_world_from_dart/components/login/login_home.dart';

void main(){
  runApp(MaterialApp(
    home:Login()
  ));
}

class MyApp extends StatelessWidget {
  
  final String usernameFix;
  
  MyApp(this.usernameFix);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.pets),
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute( builder: (context) => MyKitties(usernameFix)  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Text("Kitty App"), 
              //SomeWidget(),
              CatRequest(usernameFix),
            ],
          ),
        ),
        bottomNavigationBar: createBottomNavigation(),
      ),
    );
  }
}
