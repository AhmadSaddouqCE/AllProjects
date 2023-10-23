import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/authi/ForgetPassword.dart';
import 'package:sara_music/authi/ResetPassword.dart';
import 'package:sara_music/authi/Signup.dart';
import 'dart:convert';
import 'package:sara_music/authi/login.dart';
import 'package:sara_music/globalss.dart';


    int counter = 0;

class Verify extends StatefulWidget{
  @override
  
  State<StatefulWidget> createState() {
    return VerifyState();
  }

}


class VerifyState extends State<Verify>{
  TextEditingController Pin = TextEditingController();
        int _counter = 0;

Future DeleteFromDataBase() async {

  var res= await http.get(Uri.parse(globalss.IP+"/users/Nopin"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 
  });
  if(res.statusCode==200){
   _displayErrorMotionToasttt();
  }
}
  @override

  Widget build(BuildContext context) {

 return  WillPopScope(
  onWillPop: () {
   DeleteFromDataBase();
    //trigger leaving and use own data
    Navigator.pop(context, false);

    //we need to return a future
    return Future.value(false);
  },child: Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60,),
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
                      DeleteFromDataBase();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'Verify account',
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
            Center(
              child: Image.asset("images/Verify.png"),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
               
                    TextFormField(
                      
                       controller: Pin,
                        
                                          
                      // onSubmit: (String Pin1){
                          
                      //     Pin1 = Pin.text;
        
                     
      
                      //   // showDialog(
                      //   //     context: context,
                      //   //     builder: (context){
                      //   //       // return AlertDialog(
                      //   //       //   title: Text("Pin"),
                      //   //       //   content: Text(Pin.toString()),
                      //   //       // );
                      //   //     }
                      //   // ); //end showDialog()
      
                      // }, // end onSubmit
                    ),
                  ],
                ), // end PinEntryTextField()
              ), // end Padding()
            ),
             SafeArea(
                 child: Container(
                   height: 40,
                   width: 140,
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.pink[600]),
                   child: Center(
                     
                     child: 
                      GestureDetector(
                         onTap: () { _increaseCounter();
                           login(_counter);
                          }, 
                         child: Text('Confirm',style: GoogleFonts.sansita(color: Colors.white,fontSize: 18),),
                     ),
                ),
                 ),
             ),
            // ElevatedButton(
              
            //   onPressed: (){
            //     for(I; I< 4;I++){
                   
            //     login(I);
            //     print(I);
            //     return ;
                
            //     }
            //   },  
            //   child: Text("Confirm")
              
            //   ),
          ],
        ),
      ),
       // end Container()
    ));
     
    
     
    
  }
 void initState() {
    super.initState();
    setState(() => _counter = counter
    );

  }
  void _increaseCounter() {
     counter++;
     setState(() => _counter++);
  }
  void _displayErrorMotionToast() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Welcome :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
void _displayErrorMotionToasttt() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("You didn't verify your pin code!."),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

     void _displayErrorMotionToast5() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Enter your email again for a new Pin Code !'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast1() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Check Your Pin!'),
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
      description: Text('Please Re-SignUp using valid email!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

    void _displayErrorMotionToast4() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('You can Set a new Password :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    Future<void> login(int I) async{
   

      var body1 = jsonEncode({
  'Pin': Pin.text,
  

     });
        var body2 = jsonEncode({
  'Pin': Pin.text,
  'email': globalss.ISemail

     });



       if(globalss.SignPage==1){       
    var res= await http.post(Uri.parse(globalss.IP+"/users/pin"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 
  },body: body1);

  if(I==4){
     _counter= 0;
            counter = 0;

     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Signup()),
            );
           
            return _displayErrorMotionToast2();
  }
   print(res.statusCode);
if(res.statusCode==201){
  globalss.SignPage = 0;
   _counter= 0;
            counter = 0;
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
           
            return _displayErrorMotionToast();
}
else{
            return _displayErrorMotionToast1();
}
       }

       if(globalss.VerifyPage==2){
              var res1= await http.post(Uri.parse(globalss.IP+"/users/pinF"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  },body: body2);
    
    if(I==4){
     _counter= 0;
            counter = 0;

     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgetPassword()),
            );
           
            return _displayErrorMotionToast5();
  }
     print(res1.statusCode);
if(res1.statusCode==201){
         Map<String, dynamic> DB = jsonDecode(res1.body);
             
             globalss.authToken = DB['token'];
  globalss.VerifyPage = 0;
   _counter= 0;
            counter = 0;
             
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResetPassword()),
            );
           
            return _displayErrorMotionToast4();
}


if(res1.statusCode==405){
   _counter= 0;
            counter = 0;
             
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgetPassword()),
            );
             return _displayErrorMotionToast5();


}
else{
            return _displayErrorMotionToast1();

}

       }
  }

}