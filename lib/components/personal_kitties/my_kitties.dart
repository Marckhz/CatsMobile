import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world_from_dart/components/menu/menu_requests/cat_requests.dart';
import 'dart:async';
import 'package:http/http.dart' as http;





Future  fetchMyKities(usernameFix) async {
  //print(b64Str);

  var query = { 
   "selector": {
      "_id": {
         "\$gt": "0"
      },
      "user": "marco"
    },
   "fields": [
      "cat_name"
    ],
   "sort": [
      {
         "_id": "asc"
      }
   ]
  };


  final http.Response response  = await http.post(
      'https://6a3ce41d-81f4-48a0-96da-7fad2977570f-bluemix.cloudant.com/cats-mobile/_find',
       headers:  <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
        'Authorization':'Basic'+ b64Str
       },
       body: jsonEncode(query)
  );
  
  if(response.statusCode == 200){
       final jsonResponse = json.decode(response.body);
      // print(jsonResponse['docs']);
       return jsonResponse['docs'];
  }else {
    print("error");
  }  
  print("respuesta al servidor " +  response.statusCode.toString() );
  
}

class MyKitties extends StatefulWidget {
  
  final String usernameFix;
  var url;

  MyKitties( this.usernameFix );

  @override
  _MyKittesState createState() => _MyKittesState();
}

class _MyKittesState extends State<MyKitties>{
  
  Future catQuery;

  List cats;

  @override
  void initState(){
    super.initState();
    catQuery = fetchMyKities( widget.usernameFix );
    print(  catQuery );

  }
    @override
    Widget build(BuildContext context){
      return  Scaffold(
        appBar: AppBar(
          title: Text('Mis Gatitos'),
          centerTitle: true,
          actions: <Widget>[
          // IconButton(
              //icon: Icon(Icons.arrow_back),
              //onPressed:(){
                //Navigator.pop(context);
              //}
            //)
          ],
          ),
          body:Center(
            child:
              Column(
                children: <Widget>[
                 // Text("hola mundo"),
                  FutureBuilder(
                    future: catQuery,
                    builder: (context, response){
                      if(response.connectionState != ConnectionState.done){
                        return CircularProgressIndicator();
                      }else{
                        cats = response.data;
                        return Expanded(
                            child:Center(
                                child:
                                  ListView.separated(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: cats.length,
                                    itemBuilder:(context, index){
                                      return Image.network( cats[index]['cat_name'] );
                                }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                              )
                            )
                        );
                      }
                    }
                  )
                ],
            ),
          ),
      );
    }
  }
