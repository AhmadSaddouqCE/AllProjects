import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sara_music/Screens/Edit_Profile.dart';
import 'package:sara_music/Screens/MyDrawer.dart';
import 'package:sara_music/Screens/Settings_Page1.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';
import 'TEdit_Profile.dart';

class TProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TProfileState();
  }
}

class TProfileState extends State<TProfile> {
  var EDU;
  var ABOU;
  var NAME;
  
  late Future A;
  late Future B;
  late Future C;
  late Future img;
  late Future Instrumet;
var inst = "";
  Future  ChangeInstrument() async{
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/Tinstrument"),headers: {
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
    
    return inst;
  }

  Future  ChangeEdu() async{
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/Ed"),headers: {
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
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/name"),headers: {
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
    
              
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/ABOU"),headers: {
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
  void initState(){
    super.initState();
    A=ChangeAbo();
    B=ChangeEdu();
    C=SETNAME();
    Instrumet = ChangeInstrument();
    img = image2();
  }
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: DRawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    margin: EdgeInsets.only(top: 15, left: 140),
                    child: IconButton(
                      onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>Settingss_Page1()));},
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
              title: Center(child: Text("${NAME}")),
              subtitle: Center(child: Text('${inst} Teacher ')),
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
                  builder: (BuildContext context) => TEdit_Profile()));},
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: Color.fromARGB(255, 46, 23, 172),
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
     Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([A,B,C,img]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
   Center(
              child: CircleAvatar(
                radius: 90,
                backgroundImage: MemoryImage(base64Decode(image1))
              ),
            );
  

  }));
}
}
