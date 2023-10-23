import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sara_music/Admin/screens/home/home_screen.dart';
import 'package:sara_music/Screens/Categories_Screen.dart';
import 'package:sara_music/Screens/Category.dart';
import 'package:sara_music/Screens/Homepage.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/Teacher/Tbottom_bar.dart';
import 'package:sara_music/authi/ForgetPassword.dart';
import 'package:sara_music/authi/IntroPage.dart';
import 'package:sara_music/authi/Signup.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/globalss.dart';




class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
TextEditingController UserN= TextEditingController();
TextEditingController Passwoord = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.pink[600],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Hello!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5),
                ),
                Image.asset(
                  "images/online-education.png",
                  height: 280,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: UserN,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Username or Email",
                              labelText: "Username",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: Passwoord,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              hintText: "Password",
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1))),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed("ForgetPassword");
                                },
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: Text("Login"),
                            onPressed: () {
                               login();
            //                         Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => IntroPage()),
            // );
                              // Navigator.of(context).pushNamed("Bottom_bar");
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[600],
                              onPrimary: Colors.white,
                              minimumSize: const Size(150, 40),
                              textStyle: TextStyle(
                                fontSize: 18,
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50, top: 5),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text("if you don't have account ",
                                  style: TextStyle(fontSize: 15)),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.bottomToTopJoined,
                                      child: Signup(),
                                      childCurrent: Login(),
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Click here",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
    
  }
    void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Invalid Name/Password!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  void _displayErrorMotionToast3() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Fill Up All Fields !'),
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
      description: Text('Welcome '+ UserN.text),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  
  
  Future<void> login() async{
   

      var body1 = jsonEncode({
  'name': UserN.text,
  'password':Passwoord.text
     });
              
    var res= await http.post(Uri.parse(globalss.IP+"/users/log"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
   
  },body: body1);

        var res1= await http.post(Uri.parse(globalss.IP+"/teachers/log"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  },body: body1);

   var res2= await http.post(Uri.parse(globalss.IP+"/Admin/log"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  },body: body1);



    if(Passwoord.text.isNotEmpty&&UserN.text.isNotEmpty){
      if(res2.statusCode==200){
             Map<String, dynamic> DB2 = jsonDecode(res2.body);

        globalss.AdminsName =UserN.text;
   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
}
          else if(res1.statusCode==200){
            globalss.check=1;
     Map<String, dynamic> DB1 = jsonDecode(res1.body);
                                 
  globalss.authToken= DB1['token'];
  globalss.TeacherName=UserN.text;
  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Tbottom_bar()),
            );
              return _displayErrorMotionToast1();

           }
           
          else if(res.statusCode==200){
            globalss.check=0;
                    Map<String, dynamic> DB = jsonDecode(res.body);

  globalss.authToken= DB['token'];

  globalss.StudentName=UserN.text;
  globalss.StudentEmail=DB['email'];
  globalss.StudentPhone=DB['Phone'];
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => bottom_bar()),
            );
              return _displayErrorMotionToast1();
     }
     else {
              return _displayErrorMotionToast();


     }
 
    }
    else{
        return _displayErrorMotionToast3();
    }
 
  }

}
