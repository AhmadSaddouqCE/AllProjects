import 'package:flutter/material.dart';
import 'package:sara_music/authi/login.dart';
import 'package:sara_music/globalss.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'bottom_bar.dart';

class DRawer1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
               
    return MyDrawer1();
  }
}
class MyDrawer1 extends State<DRawer1> {
   var NAME1;
   var EMAIL1;
   var SHORT;
   late Future N;
   late Future E;
   late Future S;
   late Future all;
   late Future Img;
Future  logout() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/teacher/logout"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
  if(res.statusCode==200){
    if(mounted){
     print(res.statusCode);

 Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                               Login ()));
    }
   
  }
   
  }

  Future  SETNAME1() async{
    

    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/name"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': 'Bearer ' + globalss.authToken 

  });
  if(res.statusCode==201){
    if(mounted){
 setState(() {
     NAME1=res.body;
    });
    }
    print(NAME1);
   
  }
   
    return NAME1;
  }
   Future  SETEMAIL() async{
   
    var res= await http.get(Uri.parse(globalss.IP+" /Ttasks/email"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
 setState(() {
     EMAIL1=res.body;
    });
    }
   
  }
   
    return EMAIL1;
  }

   Future  SETSHORT() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/short"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + globalss.authToken 

  });
     print(res.statusCode);
  if(res.statusCode==201){
    if(mounted){
 setState(() {

     SHORT=res.body;
    });
    }
   
  }
   
    return SHORT;
  }
  var image1="";
Future image2() async{
  try{
var body1 = jsonEncode({
  "name": globalss.TeacherName
});

var res= await http.post(Uri.parse(globalss.IP+"/teachers/avatar1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });

}

  }catch(e){
    print(e);
  }

return await image1;

  }
  Future All() async{
    await SETNAME1();
    await SETEMAIL();
    await SETSHORT();
    await image2();
    
  }
  void initState(){
    super.initState();
      N=SETNAME1();
    E=SETEMAIL();
    S=SETSHORT();
    Img=image2();
    all =All();
  }
  
  @override
  Widget build(BuildContext context) {

      



    return Drawer(
      child: Waitforme1()
    );
  }
   Widget Waitforme1() {
  
  return FutureBuilder(future:Future.wait([all]), builder:((context, snapshot)  {

    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }
         return
            Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage:MemoryImage(base64Decode(image1)),
                
              ),
              accountName:
                  Text("${NAME1}", style: TextStyle(color: Colors.black)),
              accountEmail: Text("${EMAIL1}",
                  style: TextStyle(color: Colors.black))),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            horizontalTitleGap: 1,
            title: Text(
              "Home page",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            leading: Icon(
              IconData(0xf107, fontFamily: 'MaterialIcons'),
              color: Colors.black,
              size: 28,
            ),
            onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>bottom_bar()));},
            selected: false,
            selectedColor: Color(0xFFcb1772),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            horizontalTitleGap: 1,
            title: Text(
              "Help",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            leading: Icon(
              Icons.help_outline,
              color: Colors.black,
              size: 28,
            ),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            horizontalTitleGap: 1,
            title: Text(
              "About",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            leading: Icon(
              Icons.error_outline,
              color: Colors.black,
              size: 28,
            ),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            horizontalTitleGap: 1,
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            leading: Icon(
              Icons.settings,
              color: Colors.black,
              size: 28,
            ),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            horizontalTitleGap: 1,
            title: Text(
              "Log out",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.red,
              size: 28,
            ),
            onTap: () {

              logout();
            },
          ),
        ],
      );   
    

  }));
}
}
