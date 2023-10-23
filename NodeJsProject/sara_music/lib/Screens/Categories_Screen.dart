import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Category.dart';
import 'dart:convert';
import 'package:sara_music/globalss.dart';


class Categories_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Categories_ScreenState();
  }
}

class Categories_ScreenState extends State<Categories_Screen> {
  @override

       List CourseName=[];
        List CourseImage=[];
        var courses="";
        var arrC;
        var count="0";
        late Future all;
        var Imagess="";
        var arrI;
        late Future CourseN;
        late Future CourseI;
        late Future CourCount;

        Future CoursesCount() async{

   var res= await http.post(Uri.parse(globalss.IP+"/Courses/count"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
  if(res.statusCode==200){
    count=res.body;
  }
  }
return  await count;
}
  Future CoursesName() async{
  var res= await http.post(Uri.parse(globalss.IP+"/Courses/getName"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
  if(res.statusCode==200){
     courses = res.body;
  }
     
    }
     var course1 = courses.toString();
      arrC=course1.split(",");
      if(int.parse(count)!=0){
      for(int i = 0; i<int.parse(count);i++){
      CourseName.add(arrC[i]);

}
      }
return await [CourseName];
}

Future CoursesImage() async{
  try{
  var res= await http.post(Uri.parse(globalss.IP+"/Courses/getImage"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
    if(res.statusCode==200){
      Imagess=res.body;

    }
  }
  var ii = Imagess.toString();
  arrI = ii.split(",");
  if(int.parse(count)!=0){

  
    for(int i = 0; i<int.parse(count);i++){
      CourseImage.add(arrI[i]);

}
  }
  }catch(e){
    print(e);
  }
return await [CourseImage];
}
Future All() async{
    await CoursesCount();
  await CoursesName();
  await CoursesImage();
}
  void initState(){
  super.initState();
  CourCount = CoursesCount();
  CourseN=CoursesName();
  CourseI=CoursesImage();
  all = All();
}

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                InkWell(
                  child: Image.asset(
                    'images/icons-back.png',
                    height: 25,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 85,
                ),
                Text("Categories",
                    style: GoogleFonts.sansita(
                        fontSize: 24, fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Waitforme1()
           
          ],
        ),
      ),
    );
    
  }
  Widget Waitforme1() {
  
  return FutureBuilder(future:Future.wait([all]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
       Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: int.parse(count),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 2, top: 10, bottom: 10),
                    padding: EdgeInsets.all(20),
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(base64Decode("${CourseImage[index]}")),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.transparent),
                        boxShadow: [BoxShadow(blurRadius: 1)]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${CourseName[index]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            height: 1,
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Color(0xFF0D1333).withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
  

  }));
}
  
}
