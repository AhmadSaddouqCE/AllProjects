import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Admin/core/constants/color_constants.dart';

import '../../../../responsive.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;



class HelpSupports extends StatefulWidget {
  const HelpSupports({Key? key}) : super(key: key);

  @override
  _HelpSupportsState createState() => _HelpSupportsState();
}

class _HelpSupportsState extends State<HelpSupports> {
var Count="0";
late Future N;
TextEditingController SendMessage = TextEditingController();
// late Future D;
late Future C;
late Future all;
Future CountName() async{
    var body1 = jsonEncode({
      "name":globalss.AdminsName
    });
       var res= await http.post(Uri.parse(globalss.IP+"/Admin/CountHelps"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  },body: body1);
   if(mounted){
     if(res.statusCode==200){
       Count = res.body;
     }
   }
     return Count;
  }
var Name = "";
 List ListOfNames=[];
  Future SendName() async{
    var body1 = jsonEncode({
      "name":globalss.AdminsName
    });
       var res= await http.post(Uri.parse(globalss.IP+"/Admin/HelpStudents"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  },body: body1);
    if(mounted){
      if(res.statusCode==200){
        Name = res.body;
      }
    }
    var Name1 = Name.toString().split(",");
        for(int i=0;i<int.parse(Count);i++){
          ListOfNames.add(Name1[i]);
        }
        return ListOfNames;
  }
var des="";
List ListOfDescriptions=[];
Future SendDescription() async{
    var body1 = jsonEncode({
      "name":globalss.AdminsName
    });
       var res= await http.post(Uri.parse(globalss.IP+"/Admin/HelpStudentsD"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  },body: body1);
    if(mounted){
      if(res.statusCode==200){
        des = res.body;
      }
    }
    var des1 = des.toString().split(",");
        for(int i=0;i<int.parse(Count);i++){
          ListOfDescriptions.add(des1[i]);
        }
        return ListOfDescriptions;
  }

  Future Wait() async{
    await CountName();
    await SendName();
    await SendDescription();
  }
  void initState(){
    super.initState();
    all = Wait();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDown(
        duration: Duration(milliseconds: 500),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Waitforme()
        ),
      ),
    );
  }
  Widget Waitforme() {
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()):
      Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (!Responsive.isDesktop(context))
                SizedBox(
                  height: 60,
                ),
              if (!Responsive.isMobile(context))
                SizedBox(
                  height: 5,
                ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 18, left: 10, right: 10),
                    child: InkWell(
                      child: Image.asset(
                        'images/icons-close.jpg',
                        height: 30,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                    child: Text(
                      'Help & Supports',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: int.parse(Count),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (() => _showDialog( ListOfNames[index])),
                      child: Container(
                        margin: EdgeInsets.only(left: 2, top: 10, bottom: 10),
                        padding: EdgeInsets.all(20),
                        height: 174,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 231, 241, 242),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.transparent),
                            boxShadow: [BoxShadow(blurRadius: 1)]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${ListOfNames[index]}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    height: 1,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      RemoveFromList(ListOfNames[index],ListOfDescriptions[index]);
                                                                               
                                    },
                                    child: Icon(
                                      Icons.cancel_presentation,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: defaultPadding * 2,
                            ),
                            Text(
                              '${ListOfDescriptions[index]}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 47, 47, 50)
                                      .withOpacity(.8),
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
      

  }));
}
void _showDialog(var name) {
    slideDialog.showSlideDialog(
        context: context,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Center(
                child: Column(
                  children: [
                    Text(
                      'Contact with student',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Form(
                        child: Column(
                          children: [
                           
                            TextFormField(
                              controller: SendMessage,
                              maxLines: 3,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  FontAwesome.sticky_note_o,
                                  color: Color.fromARGB(255, 12, 51, 113),
                                ),
                                labelText: "Message",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 4),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 12, 51, 113),
                                      width: 5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height:10,
                            ),
                            Container(
                              child: ElevatedButton(
                                child: Text("Replay"),
                                onPressed: () {
                                      SendToStudent(name,SendMessage.text);

                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 40),
                                  primary: Color.fromARGB(255, 12, 51, 113),
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
            ],
          ),
        ));
  }
  Future SendToStudent(var name,var message) async{

    var body1=jsonEncode({
      "name":name.toString(),
      "Message": message.toString()
    });
    print(body1);
      var res= await http.post(Uri.parse(globalss.IP+"/Admin/SendStudentProblem"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  },body: body1);

  if(mounted){
    if(res.statusCode==200){
_displaySuccessMotionToast();
return;

    }
  }
   
      

  }
  void _displaySuccessMotionToast() {
    MotionToast.success(
      title: Text(
        'Succes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Your Reply was sent successfully.'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  Future RemoveFromList(var name ,var Des) async{
  var body1 = jsonEncode({
    "Message":Des.toString(),
    "nameS":name.toString(),
    "name":globalss.AdminsName

  });
  print(body1);

       var res= await http.post(Uri.parse(globalss.IP+"/Admin/RemoveContact"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 

  },body: body1);
   if(mounted){
     if(res.statusCode==200){
       _displayErrorMotionToast3();
     }
   }
  

}
  void _displayErrorMotionToast3() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Removed From List.'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
}
