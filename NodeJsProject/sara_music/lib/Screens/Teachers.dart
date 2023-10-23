import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sara_music/Screens/Category.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/Teacher/TDetails.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sara_music/globalss.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Teachers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TeachersState();
  }
}

class TeachersState extends State<Teachers> {
 TextEditingController Name= TextEditingController();
  late Future N;
    late Future S;
  late Future C;
  late Future I;

  var NAME="0";
   List teacher=[];
   List Instruments = [];
        var NAME1='0';
   var arr;
   var INS='0';
   var NAME2='0';
   var arr2;
List Rates=[];
 var Average="";
   var ArrayA;
           List TeachersImage1=[];
    late Future ALL;
   late Future Aver;
   late Future TC;
late Future TIC;

 var CountTeacher="0";
 Future  SETNAME1() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/TeachersList"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     NAME1=res.body;
     
    });
    }
   
  }
    var NAME5 = NAME1.toString();
    if(NAME5.length==0){
      return await [teacher];
    }
    arr = NAME5.split(",");
   if(arr.toString().length==0){
     return await [teacher];
   }
    if(CountTeacher!=""){
    for(int i = 0; i<int.parse(CountTeacher);i++){
      teacher.add(arr[i]);
    }
    }
   
    } catch(e){
      print(e);
    }
     if(teacher.length==0){
      return await [teacher];
    }
        return await [teacher];

  }

    Future GetAverage() async{
    try{
   var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CountAvg"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     Average=res.body;
     
    });
    }
   
  }
    var Average1 = Average.toString();
    if(Average1.length==0){
      return await [Rates];
    }
    ArrayA = Average1.split(",");
   if(ArrayA.toString().length==0){
     return await [Rates];
   }
    if(CountTeacher!=""){
    for(int i = 0; i<int.parse(CountTeacher);i++){
    Rates.add(ArrayA[i]);
    }
    }
   
    } catch(e){
      print(e);
    }
     if(Rates.length==0){
      return await [Rates];
    }
        return await [Rates];

  }
  Future  CountT() async{
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/count"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

if(mounted){
  if(res.statusCode==200){
    
 setState(() {
     CountTeacher=res.body;
    });
    }
   
  }
    }
    catch(e){
      print(e);
    }
    if(CountTeacher==0){
        return await [int.parse(CountTeacher)] ;
    }
        return await [int.parse(CountTeacher)] ;

  }
  Future  SETNAME() async{
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/name"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });      
    if(mounted){
  if(res.statusCode==201){
    setState(() {
     NAME=res.body;
     
    });
    }
  }
    
    } catch(e){
      print(e);
    }
    if(NAME.isEmpty){
      return await [NAME];
    }
        return await [NAME];

  }

   Future  INST() async{
    try{
  var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/INST"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
             

  });
      if(mounted){
  if(res.statusCode==200){
 setState(() {
     NAME2=res.body;
     
    });
    }
   
  }
  
    var NAME3 = NAME2.toString();
    if(NAME3.length==0){
      return await [Instruments];
    }
    arr2 = NAME3.split(",");
    if(arr2.toString().length==0){
      return await [Instruments];
    }
    if(CountTeacher!=""){
  for(int j = 0; j<int.parse(CountTeacher);j++){
      Instruments.add(arr2[j]);
    }
        }
        if(Instruments.length==0){
          return await [Instruments];
        }   
    } catch(e){
      print(e);
    }
     if(Instruments.length==0){
          return await [Instruments];
        } 
             return await [Instruments];

  }

  ScrollController _scrollController = ScrollController();
  bool _verticalList = false;

  var imageT="";
var arrTTT;
var CountTeachersImage="";
Future TeachersCountImage() async{
try{
   var res= await http.post(Uri.parse(globalss.IP+"/teachers/Getcount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
  if(res.statusCode==200){
    CountTeachersImage=res.body;
  }
  }
  }catch(e){
    print(e);
  }

return  await CountTeachersImage;
  
}

Future TeachersImage() async{
  try{
  var res= await http.post(Uri.parse(globalss.IP+"/teachers/GetImage"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
    if(res.statusCode==200){
      imageT=res.body;

    }
  }
  var imageT1 = imageT.toString();
  arrTTT = imageT1.split(",");

  
    for(int i = 0; i<int.parse(CountTeachersImage);i++){
      TeachersImage1.add(arrTTT[i]);


  }
  }catch(e){
    print(e);
  }
return await [TeachersImage1];
}
Future All() async{
  await CountT();

await  SETNAME();
  await SETNAME1();
 await INST();
 await  GetAverage();
 await TeachersCountImage();
 await TeachersImage();

}
  @override
void initState(){
  super.initState();
C= CountT();
N = SETNAME();
S= SETNAME1();
I= INST();
Aver= GetAverage();
TC=TeachersCountImage();
TIC=TeachersImage();
ALL=All();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'images/icons-back.png',
                      height: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => bottom_bar()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'Teachers',
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
            SizedBox(
              height: 580,
              child: Waitforme()
            ),
          ],
        ),
      ),
    );
  }
  Widget Waitforme() {
  
  return FutureBuilder(future: Future.wait([ALL]), builder:((context, snapshot)  {
      return snapshot.data==null?  Center(child: CircularProgressIndicator()):
      ListView.separated(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: int.parse(CountTeacher),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(indent: 16),
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                     globalss.TeacherName = "${teacher[index]}";

                     globalss.Teacherins= "${Instruments[index]}";
                     globalss.Teacherimagee=TeachersImage1[index];

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => TDetails()));
                  },
                  child: Container(
                    width: 283,
                    height: 199,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 241, 241),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 77,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 84, 153),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(32)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(teacher.length>0)
                              Text(
                          "${teacher[index]}",

                                
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if(Instruments.length>0)
                              Text(
                            "${Instruments[index]}",
                              
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 2.5,
                                  ),
                                  if(Rates.length>0)
                                  Text(
                                    "${Rates[index]}",
                                    style: GoogleFonts.sansita(
                                        color: Color.fromARGB(255, 58, 57, 57)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SmoothStarRating(
                                    size: 20,
                                    rating: 5,
                                    defaultIconData: Icons.star,
                                    starCount: 1,
                                    color: Colors.yellow,
                                    borderColor: Colors.yellow,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 77,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 84, 153),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 80,
                          top: 0,
                          child: SizedBox(
                            width: 100,
                            height: 140,
                            child: Hero(
                              tag: "${teacher[index]}",
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 80,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage:
                                    MemoryImage(base64Decode("${TeachersImage1[index]}")),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      
   

  }));
}
}
