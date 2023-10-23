import 'dart:developer';
import 'dart:math';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sara_music/Screens/Edit_Profile.dart';
import 'package:sara_music/Screens/MyDrawer.dart';
import 'package:sara_music/authi/login.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';

import 'package:sara_music/Screens/Settings_Page.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  var EDU;
  var ABOU;
  var NAME;
  var image1="";
  late Future img;
  late Future all;
  late Future A;
  late Future B;
  late Future C;
          var imageProvider;
          var Combine="";
late Future Instrumet;
var inst = "";
  Future  ChangeInstrument() async{
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/Sinstrument"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
    setState(() {
     inst=res.body;
    });
    }
  }
  if(inst!=""){
      Combine = inst +" " + "Student";
      return Combine;

  }
    return Combine;
  }
  Future  ChangeEdu() async{
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/Ed"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
    setState(() {
     EDU=res.body;
    });
    }
  }
    
    return EDU;
  }

  Future  SETNAME() async{
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/name"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
    setState(() {
     NAME=res.body;
    });
    }
  }
    
    return NAME;
  }

  Future  ChangeAbo() async{
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/ABOU"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
    setState(() {
     ABOU=res.body;
    });
    }
  }
    
    return ABOU;
  }
Future All() async{
  await ChangeEdu();
    await ChangeAbo();
    await SETNAME();
     await image2();
     await ChangeInstrument();
}
   @override
   void initState() {
     super.initState();
     A=ChangeEdu();
     B=ChangeAbo();
     C=SETNAME();
     img = image2();
     Instrumet = ChangeInstrument();
     all = All();
   

   }

  Widget build(BuildContext context) {

     return Scaffold(
      drawer: DRawer(),
      body: SingleChildScrollView(
        child:
        
         Column(
           
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'images/icons-menu.png',
                      height: 30,
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'My Profile',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15, left: 130),
                    child: IconButton(
                      onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>Settings_Page()));},
                      icon: Icon(Icons.settings),
                      alignment: Alignment.centerRight,
                      iconSize: 30,
                    ))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            
            Waitforme(),
            ListTile(
              
              title: 
               
              Center(child: Text("${NAME}")),
              
              subtitle: 

             
              Center(

                child: 
                
                Text("${Combine}")),
            ),
            ListTile(
              title: Text('About me '),
              subtitle: Text("${ABOU}"),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
            
              title: Text('Education'),
              subtitle: Text("${EDU}"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50, bottom: 10),
              child: ElevatedButton(
                child: Text("Edit Profile"),
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Edit_Profile()));},
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: Colors.pink[600],
                  onPrimary: Colors.white,
                  minimumSize: const Size(150, 40),
                  textStyle: TextStyle(
                    fontSize: 18,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  
  }
       Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([all]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
      Center(
              child: CircleAvatar(
                radius: 90,
                backgroundImage: MemoryImage(base64Decode(image1))
              ),
            );
  

  }));
}
    
       Future image2() async{
var body1 = jsonEncode({
  "name": globalss.StudentName
});

var res= await http.post(Uri.parse(globalss.IP+"/users/avatar1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });

}
if(image1!=""){

return await image1;
}
  }
 
}
