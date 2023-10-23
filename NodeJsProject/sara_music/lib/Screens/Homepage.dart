
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sara_music/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:sara_music/Games/GamePage.dart';
import 'package:sara_music/Screens/Booking.dart';
import 'package:sara_music/Screens/Category.dart';
import 'package:sara_music/Screens/Details_screen.dart';
import 'package:sara_music/Screens/MyDrawer.dart';
import 'package:sara_music/Shop/Shop.dart';
import 'package:sara_music/Screens/Profile.dart';
import 'package:sara_music/globalss.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sara_music/authi/login.dart';



import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sara_music/Screens/Teachers.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

import '../main.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
               


    return HomepageState();
  }
}

  
class HomepageState extends State<Homepage> {
  TextEditingController Name= TextEditingController();
  late Future N;
  late Future Desc;
    late Future S;
  late Future C;
  late Future I;
  late Future Img;
  List CourseDes=[];
  var coursesDes="";
  var arrd;
List Rates=[];
late Future CountCoursee;
late Future NameCourses;
late Future ImageCourses;
late Future Pricee;
late Future all;
late Future TIC;
  var NAME="0";
   List teacher=[];
   bool test =false;
   List Instruments = [];
        var NAME1='0';
        List CourseName=[];
        List CourseImage=[];
        List CoursePrice=[];
        List TeachersImage1=[];
   var arr;
   var INS='0';
   var coursespri="";
   var arrp;
   var NAME2='0';
   var arr2;
   var Average="";
   var ArrayA;
   var count = "";
   var courses="";
   var Imagess="";
   var arrI;
late Future Review;
 var CountTeacher="0";
var arrC;
 var imageProvider=[];
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

Future CoursesDes() async{
  try{
  var res= await http.post(Uri.parse(globalss.IP+"/Courses/Des"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
  if(res.statusCode==200){
     coursesDes = res.body;
  }
     
    }
     var courseDes1 = coursesDes.toString();
      arrd=courseDes1.split(",");
      for(int i = 0; i<int.parse(count);i++){
      CourseDes.add(arrd[i]);

}
  }catch(e){
    print(e);
  }
      
return await [CourseDes];
}


///


Future CoursesPri() async{
  var res= await http.post(Uri.parse(globalss.IP+"/Courses/price"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
  if(res.statusCode==200){
     coursespri = res.body;
  }
     
    }
     var courseprice = coursespri.toString();
      arrp=courseprice.split(",");
      for(int i = 0; i<int.parse(count);i++){
      CoursePrice.add(arrp[i]);


      }
return await [CoursePrice];
}


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
var imageT="";
var arrTTT;

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

  
    for(int i = 0; i<int.parse(CountTeacher);i++){
      TeachersImage1.add(arrTTT[i]);


  }
  }catch(e){
    print(e);
  }
return await [TeachersImage1];
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

var toggleS="0";
 Future  ToggleCheckS() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/getToggleS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     toggleS=res.body;
     
    });
    }
   
  }
  return toggleS;
    }catch(e){
      print(e);
    }
 }

var toggleM="0";
 Future  ToggleCheckM() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/getToggleM"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     toggleM=res.body;
     
    });
    }
   
  }
  return toggleM;
    }catch(e){
      print(e);
    }
 }


var toggle="0";
 Future  ToggleCheck() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/getToggle"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     toggle=res.body;
     
    });
    }
   
  }
  return toggle;
    }catch(e){
      print(e);
    }
 }
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
  
    arr = NAME5.split(",");
   
    for(int i = 0; i<int.parse(CountTeacher);i++){
      teacher.add(arr[i]);
    }
    
   
    } catch(e){
      print(e);
    }
   
        return await [teacher];

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
        return await CountTeacher ;
      

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
  
    arr2 = NAME3.split(",");
 
  for(int j = 0; j<int.parse(CountTeacher);j++){
      Instruments.add(arr2[j]);
    
        }
   
    } catch(e){
      print(e);
    }
    
             return await [Instruments];

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

    ArrayA = Average1.split(",");
  
    for(int i = 0; i<int.parse(CountTeacher);i++){
    Rates.add(ArrayA[i]);
    }
    
   
    } catch(e){
      print(e);
    }
   
        return await [Rates];

  }

Future All() async{

  await CountT();
  await SETNAME();
  await SETNAME1();
  await INST();
  await CoursesCount();
   await GetAverage();
 await CoursesName();
 await CoursesImage();
 await CoursesDes();
 await CoursesPri();
 await TeachersImage();
    await image2();
    await ToggleCheck();
    await ToggleCheckS();
    await ToggleCheckM();
 if(toggleS=="1"){
       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.pink,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });
        flutterLocalNotificationsPlugin.show(
        0,
        "Imprtant Meassge!",
        "Your teacher canceled your appointment",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
                await ToggleVaribleS();
    }


    if(toggleM=="1"){
       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.pink,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });
        flutterLocalNotificationsPlugin.show(
        0,
        "Imprtant Meassge!",
        "You have new messages",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
                await ToggleVaribleM();
    }
     if(toggle=="1")
     {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.pink,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });
        flutterLocalNotificationsPlugin.show(
        0,
        "Imprtant Meassge!",
        "Your appointment was changed by the teacher",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
                await ToggleVarible();

 }

}

Future ToggleVaribleS() async{
  try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/ToggleVaribleS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 
    }
   
  }
    }catch(e){
      print(e);
    }

}

Future ToggleVaribleM() async{
  try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/ToggleVaribleM"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 
    }
   
  }
    }catch(e){
      print(e);
    }

}

Future ToggleVarible() async{
  try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/ToggleVarible"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 
    }
   
  }
    }catch(e){
      print(e);
    }

}
  ScrollController _scrollController = ScrollController();
  bool _verticalList = false;
  @override
void initState(){
  super.initState();

C= CountT();
 N = SETNAME();
S= SETNAME1();
 I= INST();
 CountCoursee=CoursesCount();
 Review=GetAverage();
 NameCourses=CoursesName();
 ImageCourses=CoursesImage();
 Desc=CoursesDes();
 Pricee = CoursesPri();
 TIC=TeachersImage();
Img = image2();

 all =All();

    
}
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Gamepage()));
          },
          tooltip: "Games",
          elevation: 10.0,
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(255, 236, 32, 100),
          child: Icon(FontAwesome.gamepad),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.cyanAccent),
          )),
      drawer: Drawer(),
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
                     Scaffold.of(context).openDrawer();
                  },
                ),
                
                AdvancedAvatar(
                  size: 50,
                  image: MemoryImage(base64Decode(image1)),
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("HI ${NAME}",
                style: GoogleFonts.sansita(
                    fontSize: 32, fontWeight: FontWeight.w600)),
            Text(
              "Find a course you want to learn",
              style: GoogleFonts.sansita(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Teachers",
                    style: GoogleFonts.sansita(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                InkWell(
                  child: Text("See all",
                      style: GoogleFonts.sansita(
                          fontSize: 18, color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Teachers()));
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 199,
              child:Waitforme()
            ),
            SizedBox(
              height: 10,
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
              height: 10,
            ),
            Waitforme1()
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
     return  ListView.separated(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: int.parse(CountTeacher),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(indent: 16),
                itemBuilder: (BuildContext context, int index) => Container(
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
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(32)),
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
                                backgroundImage: MemoryImage(base64Decode("${TeachersImage1[index]}")),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
   

  }));
}
 Widget Waitforme1() {
  
  return FutureBuilder(future:Future.wait([all,Img]), builder:((context, snapshot)  {

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
                    onTap: () {
                      globalss.courseimage=CourseImage[index];

                      globalss.courseprice="${CoursePrice[index]}";
                      globalss.coursedescription="${CourseDes[index]}";
                     globalss.Coursname= "${CourseName[index]}";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details_Screen()));
                      
                    },
                    
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: index.isEven ? 250 : 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        
                        image: DecorationImage(
                          image: MemoryImage(base64Decode("${CourseImage[index]}"))
,
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
  "name": globalss.StudentName
});

var res= await http.post(Uri.parse(globalss.IP+"/users/avatar1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });
  return await image1;


}

  }catch(e){
    print(e);
  }


  }
}





