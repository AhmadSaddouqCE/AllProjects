import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'dart:convert';
import 'package:sara_music/globalss.dart';
import '../Admin/core/constants/color_constants.dart';
import '../responsive.dart';
class Contact extends StatefulWidget {
  const Contact({ Key? key }) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var Count="0";
  late Future all;
  late Future c;
  late Future N;
  Future CountName() async{

       var res= await http.get(Uri.parse(globalss.IP+"/tasks/HelpArrayCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 

  });
   if(mounted){
     if(res.statusCode==200){
       Count = res.body;
     }
   }
     return Count;
  }

  var des="";
List ListOfDescriptions=[];
Future SendDescription() async{
 
       var res= await http.get(Uri.parse(globalss.IP+"/tasks/HelpArray"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 

  });
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
 Future Data() async{
   await CountName();
   await SendDescription();
 }

  @override
void initState() {
  super.initState();
  c= CountName();
  N = SendDescription();
  all = Data();
}
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
                      'Contact',
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
                    return Container(
                      margin: EdgeInsets.only(left: 2, top: 10, bottom: 10),
                      padding: EdgeInsets.all(20),
                      height: 160,
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
                                'KhaledSaddouq',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 1,
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    RemoveFromList(ListOfDescriptions[index]);
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
                    );
                  },
                ),
              ),
            ],
          );
    

  }));
}
Future RemoveFromList(var Des) async{
  var body1 = jsonEncode({
    "Message":Des.toString()
  });

       var res= await http.post(Uri.parse(globalss.IP+"/tasks/RemoveContact"),headers: {
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