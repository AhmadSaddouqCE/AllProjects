
import 'package:flutter/material.dart';
import 'package:sara_music/Screens/Teachers.dart';
import 'package:sara_music/globalss.dart';
import 'package:sara_music/Screens/Category.dart';

import 'package:sara_music/authi/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Data extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return Data1();
  }
}
class Data1 extends State<Data> {
  var NAME;
  Future SETNAME() async{
   var chess = await "hi1234";
    if(mounted){
    setState(() {
     NAME =  chess;
     
    });
    }
    
    return  NAME;
  }
  @override
  Widget build(BuildContext context) {
    
return Scaffold(

);  }

}


 

