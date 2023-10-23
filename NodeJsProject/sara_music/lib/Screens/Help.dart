import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/Shop/colors.dart';
import 'package:sara_music/globalss.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "Contact.dart";
import 'Settings_Page.dart';

class Help extends StatefulWidget {
  const Help({ Key? key }) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  late Future N;
  late Future all;
  var NAME1="";
  Future  SETNAME1() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/name"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
  if(res.statusCode==201){
    if(mounted){
 setState(() {
     NAME1=res.body;
    });
    }
   
  }
   
    return NAME1;
  }
     Future ALL() async{
await SETNAME1();


  }
  @override
 


  void initState(){
    super.initState();
    N=SETNAME1();
    all =ALL();
  }
   late TextEditingController Name = TextEditingController(text: "${NAME1}");
   TextEditingController Message =  TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(

       body: Waitforme1()
  );
  }

   Widget Waitforme1() {
  
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {
    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }      
     return  SingleChildScrollView(
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
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                
            Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    'Help & Support',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, left: 25),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Contact()));
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: white),
                      ),
                      icon: Icon(
                        Icons.contact_support,
                        size: 30,
                      ),
                      label: Text(
                        "Respones",
                        style: TextStyle(fontSize: 18),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset("images/Help1.png"),
            ),
            FadeInDown(
              delay: Duration(microseconds: 500),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: Name,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline),
                                labelText: "name",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 4),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink.shade600,
                                      width: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: Message,
                              maxLines: 4,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  FontAwesome.sticky_note_o,
                                  color: Colors.pink[600],
                                ),
                                labelText: "Message",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 4),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink.shade600,
                                      width: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: ElevatedButton(
                                child: Text("Contact us"),
                                onPressed: () {
                              SendMyProblem(Message.text);

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
                    ),
                  ],
                ),
              ),
            ),
          ],  
  ),
  
  );

  }));
}
Future SendMyProblem(var message)async {

  if(Message.text.isNotEmpty){
   var body1 = jsonEncode({
  'Message': message
});
var res= await http.post(Uri.parse(globalss.IP+"/tasks/SendMyProblem"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  },body: body1);
  if(mounted){
    if(res.body=="Updated"){
          _displayErrorMotionToast();
          return;
    }
  }
  }
  else{
     _displayErrorMotionToast1();
          return;
  }

}
   void _displayErrorMotionToast() {
    MotionToast.success(
      title: Text(
        'Succes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Your Message is sent to the Admins Successfully :)'),
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
      description: Text('Please Fill all fields'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
}