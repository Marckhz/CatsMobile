import 'dart:io';
import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


final username = "6a3ce41d-81f4-48a0-96da-7fad2977570f-bluemix";
final password = "5700c1a997e4d12494ac1919956c046cd54b44a52ad838ec065dcdd80ecf8806";
final encodeString = utf8.encode( username+":"+password );
final b64Str = base64.encode(encodeString);

class AlbumCats {
  
  final List breeds;
  final int height;
  final String id;
  final String url;
  final int width;
  

  AlbumCats({
    this.breeds,
    this.height,
    this.id,
    this.url,
    this.width
  });

  factory AlbumCats.fromJson(Map<String, dynamic> json){
    return AlbumCats(
      
      breeds: json['breeds'],
      height: json['height'],
      id: json['id'],
      url:json['url'],
      width: json['width'] 
      );
  }
}

Future<AlbumCats> fetchCats() async {

  final response = await http.get("https://api.thecatapi.com/v1/images/search",
  headers: {"x-api-key":"e3114a0f-ed14-4f96-89d4-7c3a74cf751d"}
  );

  if(response.statusCode == 200 ){
    final jsonresponse  = json.decode(response.body) ;
    //print(jsonresponse);
    return AlbumCats.fromJson(jsonresponse[0] );
  }else{
    throw  Exception("Failed to load");
  }
}

Future<AlbumCats> postCat(String id, String user) async {

  
  //var uri = Uri.https( "http://192.168.31.162:8081", "/add_cat", bodyParam);
  final http.Response response = await http.post(
   //uri,
  "https://6a3ce41d-81f4-48a0-96da-7fad2977570f-bluemix.cloudant.com/cats-mobile",
   headers:<String, String>{
     'Content-Type':'application/json; charset=UTF-8',
     'Authorization':'Basic' + b64Str
   },
   body: jsonEncode(<String, String>{
     'cat_name':id,
     'color':'gris',
     'user':user
   }) // bodyParam
  );

  if(response.statusCode == 201 ){
    print( "new cat has been created" );
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

class CatText extends StatelessWidget {
  
  final stringCat;

  CatText(this.stringCat);
  
  Widget build(BuildContext context){

    return Text(stringCat);
  }
}

class CatRequest extends StatefulWidget {

  final String usernameFix;

  //CatRequest({Key key, this.usernameFix}) : super(key:key);
 
  CatRequest(this.usernameFix);

  @override
  _CatState createState()=> _CatState();
}

class _CatState extends State<CatRequest>{
  
  Future<AlbumCats> futureAlbumCats; 

  String catUrl;

  @override
  void initState(){
    super.initState();
    futureAlbumCats = fetchCats();
    print(futureAlbumCats);

  }

  void _refresh(){
    setState( (){
      futureAlbumCats = fetchCats();
      });
    }


  @override
  Widget build(BuildContext context){
   return textCat(context);
  }  

  Widget textCat(BuildContext context){
    return Container(child:
      Column(
            children: <Widget>[
                  FutureBuilder(
                    future:futureAlbumCats,
                    builder: (context, response){
                      if(response.connectionState != ConnectionState.done){
                        return CircularProgressIndicator();
                      }else {
                        //response.hasData;
                        catUrl = response.data.url;

                        return Container(
                          width: 240.0,
                          height: 240.0,
                          child:Image.network( response.data.url),  
                        );
                      }//else{
                        //throw response.error;
                      //}  
                    },
                  ),
                Container(
                  decoration: ShapeDecoration(
                    shape: Border.all(
                      color: Colors.grey,
                      width: 0.2,
                    )
                  ),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget>[
                        RaisedButton(
                        color: Colors.teal,
                        child: Text(
                          "Mostrar Gatitos",
                          style: TextStyle(color: Colors.white),
                          ),
                        onPressed: _refresh,
                      ),
                      IconButton(
                        alignment: Alignment.bottomLeft,
                        onPressed:(){
                          print("corazon pushado");
                          //print(catUrl +  '   1');
                          print(catUrl + widget.usernameFix);
                          postCat(catUrl, widget.usernameFix);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color:Colors.pink,
                          size: 24.0,
                        ),
                      )
                      ]
                    ) 
                )
            ],
          ),
      );
  }
}