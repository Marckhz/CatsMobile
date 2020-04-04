import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

import  'package:hello_world_from_dart/main.dart';


class Login extends StatefulWidget {
  @override
  _Login createState()  => _Login();
}


class _Login extends State <Login> {

  final  usernameInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  bool auth = false;

  String usernameFixed = "marco";
  String password = "123";


 _launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Center(
        child: 
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child:Container(
              width: 300.0,
              child: Column(
                children: <Widget>[
                  Image(image: AssetImage('graphics/catLogo.png'),
                        width: 200,
                        height: 200,
                  ),
                  Text(
                    'The RandomCats App',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 32.0
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    controller: usernameInputController,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordInputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'password',
                      
                      ),
                      obscureText: true,
                  ),
                  SizedBox(height: 10),
                  ButtonTheme(
                    minWidth: 300.0,
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      color: Colors.teal,
                      
                      onPressed: () {
                        if( usernameInputController.text == usernameFixed && passwordInputController.text == password){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp(usernameFixed)),
                          );
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white,
                        fontSize: 24.0),
                      ),
                    ),
                    
                  ),
                  SizedBox(height:10),
                  GestureDetector(
                    onTap: _launchURL,
                    child:
                      RichText(
                        text: TextSpan(
                          text: "no tengo cuenta :(",
                          style: TextStyle(color: Colors.blue),
                          ), 
                    )
                  )           
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



} 