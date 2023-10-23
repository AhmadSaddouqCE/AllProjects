import 'package:flutter/material.dart';
import 'package:sara_music/globalss.dart';

import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:sara_music/Screens/Booking.dart';
import 'package:sara_music/Screens/Category.dart';
import 'package:sara_music/Screens/Details_screen.dart';
import 'package:sara_music/Screens/MyDrawerTeacher.dart';
import 'package:sara_music/Shop/Shop.dart';
import 'package:sara_music/Screens/Profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class THomepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return THomepageState();
  }
}

class THomepageState extends State<THomepage> {  
   TextEditingController Name= TextEditingController();
 var NAME;
    late Future S;
 
final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

late Future CountCoursee;
late Future NameCourses;
late Future ImageCourses;
late Future all;
late Future Img;
 List CourseName=[];
List CourseImage=[];
   
   var count = "";
   var courses="";
   var Imagess="";
   var arrI;
var arrC;
 var imageProvider=[];


//

Future CoursesCount() async{
try{
   var res= await http.post(Uri.parse(globalss.IP+"/Courses/count"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
  if(res.statusCode==200){
    count=res.body;
  }
  }
  }catch(e){
    print(e);
  }
return  await count;
  
}
///




///



////
Future CoursesName() async{
  try{
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
      }catch(e){
        print(e);
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

  
    for(int i = 0; i<int.parse(count);i++){
      CourseImage.add(arrI[i]);


  }
  }catch(e){
    print(e);
  }
return await [CourseImage];
}

//
var NAMEEE="";
  Future  SETNAME() async{
    
    var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/name"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
  if(res.statusCode==201){
    if(mounted){
    setState(() {
     NAMEEE=res.body;
     
    });
    }
  }
    
    return await NAMEEE;
  }
  Future All() async{

  await SETNAME();
  await CoursesCount();
 await CoursesName();
 await CoursesImage();


}
  @override
  void initState(){
    super.initState();
          S =SETNAME();
          CountCoursee=CoursesCount();
 NameCourses=CoursesName();
 ImageCourses=CoursesImage();
 Img = image2();
 all = All();

  }
  Widget build(BuildContext context) {

    return Scaffold(     
      key: _key,
      drawer: DRawer1(),
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Image.asset(
                    'images/icons-menu.png',
                    height: 30,
                  ),
                  onTap: () {
          _key.currentState!.openDrawer();

                  },
                ),
                AdvancedAvatar(
                  size: 50,
                  image: MemoryImage(base64Decode("${image1}")),
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("Hi ${NAMEEE}",
                style: GoogleFonts.sansita(
                    fontSize: 32, fontWeight: FontWeight.w600)),
            Text(
              "Find a course you want to learn",
              style: GoogleFonts.sansita(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories",
                    style: GoogleFonts.sansita(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                InkWell(
                  child: Text("See all",
                      style: GoogleFonts.sansita(
                          fontSize: 18, color: Colors.blue)),
                  onTap: () {
                    Navigator.of(context).pushNamed("Categories");
                  },
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
           Waitforme(),
          ],
        ),
      ),
    );
  }
  Widget Waitforme() {
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {
    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }      
     return   Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: int.parse(count),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return InkWell(
                 
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: index.isEven ? 300 : 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: MemoryImage(base64Decode("${CourseImage[index]}")),
                          fit: BoxFit.fill,
                        ),
                      ),
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
                          )
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            );

  }));
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
}
