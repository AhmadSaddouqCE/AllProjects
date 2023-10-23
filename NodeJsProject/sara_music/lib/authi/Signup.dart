
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sara_music/Screens/Homepage.dart';
import 'package:sara_music/authi/IntroPage.dart';
import 'package:sara_music/authi/Verify.dart';
import 'package:sara_music/authi/login.dart';
import 'package:sara_music/authi/Verify.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/globalss.dart';


class Signup extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  // var gender;
  int value = 0;
   
  Widget CustomRadioButton(String text, int index, TextEditingController Gendeer) {
   return OutlineButton(
      hoverColor: Colors.pink,
      onPressed: () {
        Gendeer.text = text;
        setState(() {
          value = index;
           
          TextFormField(
             controller:Gendeer,
        

          );
        });
      },
      padding: EdgeInsets.all(15),
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.pink[600] : Colors.black,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      borderSide:
          BorderSide(color: (value == index) ? Colors.pink.shade600 : Colors.black),
    );
  }

  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }
 TextEditingController User = TextEditingController();
TextEditingController Email = TextEditingController();
TextEditingController Date = TextEditingController();
TextEditingController Password = TextEditingController();
TextEditingController CPassword = TextEditingController();
TextEditingController PhoneN = TextEditingController();
TextEditingController Gendeer = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(10),          
            child: InkWell(
                child: Image.asset(
                  'images/icons-back.png',
                  height: 10,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.topCenter,
                      child: Login(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                }),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Center(
              child: Image.asset("images/Logo.png"),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: User,
                      cursorColor: Color(0xFFcb1772),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Username",
                          labelText: 'Username',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: Email,
                      cursorColor: Color(0xFFcb1772),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),

                          hintText: "Email",
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      cursorColor: Color(0xFFcb1772),
                      controller: dateinput,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today_rounded),
                          labelText: "Enter Date",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(3000));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);

                          setState(() {
                            dateinput.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: Password,
                      obscureText: true,
                      cursorColor: Color(0xFFcb1772),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          hintText: "Password",
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: CPassword,
                      obscureText: true,
                      cursorColor: Color(0xFFcb1772),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          hintText: "Confirm Password",
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 45,
                  
                      child: Row(
                        
                        children:
                        [  
                         
                           CustomRadioButton("Male", 1, Gendeer),
                     
                        
                          Text("     "),
                        
                          CustomRadioButton("Female", 2, Gendeer),
                     
                        
                        ],
                        
                      ),
                      
                    ),
                    Stack(
                       
                      children: [
                        InternationalPhoneNumberInput(
                          cursorColor: Color(0xFFcb1772),
                          textFieldController: PhoneN,
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text("Sign up"),
                        onPressed: () {

                          login();
                
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 40),
                          primary: Colors.pink[600],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.all(10),
                          textStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )));
  }
  void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Fill All the Fields!'),
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
      description: Text('Invalid Email'),
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
      description: Text('Password Must Be Matched!'),
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
      description: Text('Invalid Phone Number!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
     void _displayErrorMotionToast4() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This User name is already used!'),
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
      description: Text('This Phone number is already used!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast6() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Email is already used!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast7() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('User name length > 4'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast8() {
    MotionToast.success(
      title: Text(
        "Please Verify Your Pin Code !",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Success!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

   void _displayErrorMotionToast10() {
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
   void _displayErrorMotionToastt() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This name is already used by other users!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast13() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Phone-Number must be above or equal to 10 numbers'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  void _displayErrorMotionToastt1() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This email is already used by other users!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToastt2() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Phone-number is already used by other users!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    
    Future<void> login() async{
   

      var body1 = jsonEncode({
  'name': User.text,
  'email': Email.text,
  'birthday': dateinput.text,
  'password': Password.text,
    'ConfPass':CPassword.text,
    'Phone': PhoneN.text,
    'Gender': Gendeer.text
     });
              
    var res= await http.post(Uri.parse(globalss.IP+"/users"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  } ,body: body1);
  
  
    if(Gendeer.text.isNotEmpty&& PhoneN.text.isNotEmpty&&User.text.isNotEmpty && Email.text.isNotEmpty && dateinput.text.isNotEmpty && Password.text.isNotEmpty&&CPassword.text.isNotEmpty){
      
        if(!(Password.text==CPassword.text)){
          return _displayErrorMotionToast2();

        }
        else if(!(Email.text.contains(RegExp(r'[@]'))&&Email.text.contains('.com'))){
           return _displayErrorMotionToast1();
        
                                       


        }
        else if(PhoneN.text.contains(RegExp(r'[A-Za-z]'))){
         return _displayErrorMotionToast3();
          
                    

        }
        else    if(PhoneN.text.contains(RegExp(r'[`!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?~]'))){
       
                return _displayErrorMotionToast3();

        }
        
       

        if(res.body=="Nooo"){
                    return _displayErrorMotionToastt();

        }   
         if(res.body=="Nooo1"){
                                           return _displayErrorMotionToastt1();


        }   
         if(res.body=="Nooo2"){
                                           return _displayErrorMotionToastt2();


        }   
         if(res.body=="UserMin"){
          return _displayErrorMotionToast7();
          
         }
           if(res.body=="PhoneN"){
          return _displayErrorMotionToast13();
           }
            
              if(res.body=="PASS"){
          return _displayErrorMotionToast10();
           }

     
              
      print("Code:${res.statusCode}");
      if (res.statusCode == 201) {
               Map<String, dynamic> DB = jsonDecode(res.body);

        globalss.SignPage = 1;
        globalss.authToken = DB['token'];
 var res1= await http.post(Uri.parse(globalss.IP+"/tasks"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 
      


 
 
 
 } );
  print(res1.statusCode);
        String responseString = res.body;
        print("Response String: " + responseString);
        
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Verify()),
            
            );
            _displayErrorMotionToast8();

      }     
 
    }
 else{
            _displayErrorMotionToast();

}
  }
}


