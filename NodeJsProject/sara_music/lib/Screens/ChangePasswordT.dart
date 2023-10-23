import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Screens/Homepage.dart';
import 'package:sara_music/Screens/SettingsForAll.dart';
import 'package:sara_music/Screens/Settings_Page.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/Teacher/Tbottom_bar.dart';
import 'dart:convert';
import 'package:sara_music/globalss.dart';
import 'package:http/http.dart' as http;

import 'Settings_Page1.dart';


class ChangePasswordT extends StatefulWidget {
  const ChangePasswordT({ Key? key }) : super(key: key);

  @override
  _ChangePasswordTState createState() => _ChangePasswordTState();
}

class _ChangePasswordTState extends State<ChangePasswordT> {
    TextEditingController NewPass = TextEditingController();
 TextEditingController ConfPASS = TextEditingController();
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'images/icons-back.png',
                      height: 30,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settingss_Page1()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'Change Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            FadeInDown(
              delay: Duration(microseconds: 500),
              child: Center(
                child: Image.asset("images/Help.png"),
              ),
            ),
            FadeInDown(
              delay: Duration(microseconds: 500),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    children: [
                  
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: NewPass,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            hintText: "New Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                       controller: ConfPASS,
                         obscureText: true,
                         decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            hintText: "Confirm New Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            ResetPass();
                          },
                          child: Text("Change Password"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 40),
                            primary: Colors.pink,
                            onPrimary: Colors.white,
                            padding: EdgeInsets.all(15),
                            textStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Fill Up the fields!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

    void _displayErrorMotionToast1() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('New password is confirmed :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast2() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Password must be matched !'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast9() {
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Password Must Be > 7'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  
   Future<void> ResetPass() async{
   

      var body1 = jsonEncode({
  'password': NewPass.text,
  'token': globalss.authToken

     });
              
    var res= await http.post(Uri.parse(globalss.IP+"/teachers/reset"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 
  },body: body1);
  if(NewPass.text.length<7){
    _displayErrorMotionToast9();
  }
    if(NewPass.text.isNotEmpty&&ConfPASS.text.isNotEmpty){
           if(NewPass.text!=ConfPASS.text){
  return _displayErrorMotionToast2();
           }
           if(res.statusCode==200){

    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Tbottom_bar()),
            );
              return _displayErrorMotionToast1();
     }
    
    }
     else {
        
              return _displayErrorMotionToast();


     }
 
    }
}