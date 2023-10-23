import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';

import '../Shop/colors.dart';
import 'BreakSchedule.dart';
import 'TeachersScheduales.dart';

class Settings_Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Settings_PageState1();
  }
}

class Settings_PageState1 extends State<Settings_Page1> {
var ChoosenUserName="";
var ChoosenUserAbout="";
var ChoosenUserPhone="";
var ChoosenUserImage="";
var Student = "";
var Teacher="";
var ToggleS;
var ToggleT;
late Future ChooseData;
 Future ChooseOne()async{
 var body1 = jsonEncode({
  "name":globalss.searchname

 });
 

  var res= await http.post(Uri.parse(globalss.IP+"/users/DisplayChoosenAboutS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);

if(res.statusCode==200){
  ChoosenUserAbout=res.body ;



  var res1= await http.post(Uri.parse(globalss.IP+"/users/DisplayChoosenNameS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(res1.statusCode==200){
  ChoosenUserName=res1.body ;
   

}

 var res2= await http.post(Uri.parse(globalss.IP+"/users/DisplayChoosenPhoneS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
  
if(res2.statusCode==200){
  ChoosenUserPhone=res2.body ;
}

 var res3= await http.post(Uri.parse(globalss.IP+"/users/DisplayChoosenImageS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
  
if(res3.statusCode==200){
  ChoosenUserImage=res3.body ;
}
if(Student!=""&&Teacher==""){
      ToggleS=1;
      ToggleT=0;
    }
Student = "Student";
return await [ChoosenUserName,ChoosenUserAbout,ChoosenUserPhone,ChoosenUserImage,Student,ToggleS];


}
//


  var res4= await http.post(Uri.parse(globalss.IP+"/Ttasks/DisplayChoosenAboutS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);

if(res4.statusCode==200){
  ChoosenUserAbout=res4.body ;
}

  var res5= await http.post(Uri.parse(globalss.IP+"/Ttasks/DisplayChoosenNameS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
  
if(res5.statusCode==200){
  ChoosenUserName=res5.body ;
   globalss.TeacherName = ChoosenUserName;
}

 var res6= await http.post(Uri.parse(globalss.IP+"/Ttasks/DisplayChoosenPhoneS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
  
if(res6.statusCode==200){
  ChoosenUserPhone=res6.body ;
}

 var res7= await http.post(Uri.parse(globalss.IP+"/Ttasks/DisplayChoosenImageS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
  
if(res7.statusCode==200){
  ChoosenUserImage=res7.body ;

}

   
Teacher="Teacher";
return await  [ChoosenUserName,ChoosenUserAbout,ChoosenUserPhone,ChoosenUserImage,Teacher];

//
 } 
 void initState(){
   super.initState();
   ChooseData = ChooseOne();
 }

  @override

  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
     
      body: Waitforme()
 
    );

  }

    Widget Waitforme() {
      
   
  return FutureBuilder(future: Future.wait([ChooseData]), builder:((context, snapshot)  {
   

    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString()); 
         }      
    if(ChoosenUserImage!=""&&Student!="") return Padding(

        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
           
            Row(children: [
InkWell(
          child: Image.asset(
            'images/icons-back.png',
            scale: 2,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: 10,),
         Text(
          "About",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.black),
        ),
       
        
            ],),
         
            SimpleUserCard(
              userName: "${ChoosenUserName}",
              
              userProfilePic:MemoryImage(base64Decode(ChoosenUserImage)),
            ),
            // Text("About: ${ChoosenUserAbout} \n \n PhoneNumber: ${ChoosenUserPhone}")
          FadeInDown(
              delay: Duration(microseconds: 500),
              child: Center(
                child: Column(
                  children: [
                   ListTile(
                      title: Text(Student),
                      leading: Icon(
                        Icons.music_note,
                        color: Colors.pink[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    ListTile(
                      title: Text("${ChoosenUserAbout}"),
                      leading: Icon(
                        Icons.description_outlined,
                        color: Colors.pink[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),


                    ListTile(
                      title: Text("${ChoosenUserPhone}"),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.pink[600],
                      ),
                    ),                 
                  ],
                ),
              ),
            ),
      
          ],
        ),
      );
      else if(Teacher!=""||ChoosenUserImage!=""){
        return Padding(

        padding: const EdgeInsets.all(10),
        
        child: ListView(
          
          children: [
            Row(children: [
InkWell(
          child: Image.asset(
            'images/icons-back.png',
            scale: 2,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(width: 10,),
         Text(
          "About",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.black),
        ),
        
         Container(
           
                      margin: EdgeInsets.only(top: 10, left: 140),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BreakSchedule()));
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: white),

                        ),
                        
                        icon: Icon(FontAwesomeIcons.calendarTimes,size: 18,),
                        label: Text("Breaks",style: TextStyle(fontSize: 18),),
                        
                        
                        
                        
                        
                      ),
                      
                    
                      ),


                      
                       
                      
        
            ],
            
            ),
            Row(children: [

              SizedBox(width: 10,),

        
         Container(
           
                      margin: EdgeInsets.only(top: 10, left: 220),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TeacherSched()));
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: white),

                        ),
                        
                        icon: Icon(FontAwesomeIcons.calendarTimes,size: 18,),
                        label: Text("Scheduales",style: TextStyle(fontSize: 18),),
                        
                        
                        
                        
                        
                      ),
                      
                    
                      ),


                      
                       
                      
        
            ],
            
            ),
            SimpleUserCard(
              userName: "${ChoosenUserName}",
              
              userProfilePic:MemoryImage(base64Decode(ChoosenUserImage)),
            ),
            // Text("About: ${ChoosenUserAbout} \n \n PhoneNumber: ${ChoosenUserPhone}")
          FadeInDown(
              delay: Duration(microseconds: 500),
              child: Center(
                child: Column(
                  children: [
                   ListTile(
                      title: Text(Teacher),
                      leading: Icon(
                        Icons.music_note,
                        color: Colors.pink[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    ListTile(
                      title: Text("${ChoosenUserAbout}"),
                      leading: Icon(
                        Icons.description_outlined,
                        color: Colors.pink[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),


                    ListTile(
                      title: Text("${ChoosenUserPhone}"),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.pink[600],
                      ),
                    ),                 
                  ],
                ),
              ),
            ),
      
          ],
        ),
      );

     
        
      }

      return Padding(

        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
          Text("\n \n "+"Name: ${ChoosenUserName}   \n "),
            Text("About: ${ChoosenUserAbout} \n \n PhoneNumber: ${ChoosenUserPhone}")
          
      
          ],
        ),
      );
      
  }));
}
}
