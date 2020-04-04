import 'package:flutter/material.dart';


class SomeWidget extends StatefulWidget{
  @override
  _SomeWidgetState createState() => _SomeWidgetState();
    
  }
  
class _SomeWidgetState extends State<SomeWidget> {
  
  String somevar;

  @override
  void initState() {
    somevar = "soy un boton";
    super.initState();
  }

  void _sayHello(){
    setState((){
      somevar = "cambie";
    });
  }

  @override
  Widget build(BuildContext context) {
    return buttonSection(context);
  }

  // @override
  Widget buttonSection(BuildContext context){
    return Container(
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(onPressed: _sayHello,
        child: Text(somevar), 
        ),  
      ]
    )
    );
  }
}