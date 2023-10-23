import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/Teacher/THomepage.dart';
import 'package:sara_music/globalss.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_range/time_range.dart';
import 'package:motion_toast/motion_toast.dart';
class TDetails extends StatefulWidget {
  @override
  State<TDetails> createState() => _TDetailsState();
}

class _TDetailsState extends State<TDetails> {
  @override
late Future About;
var About1="";
var rating = 0.0;
var rating1;
bool rate =true;
  Future GetAbout() async{
    try{
var body1 = jsonEncode({
  "NName": globalss.TeacherName,
});
    var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/GetAbout"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);
        if(mounted){
   if(res.statusCode==200){
     About1 = res.body;
   }
        }
    }catch(e){
      print(e);
    }
    return await [About1];

  }
  void _displayErrorMotionToast() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('You Cant Rate Other Teachers, Only yours!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  Future <bool> SaveRating(double rating, var teachername) async{
    try{
var body1 = jsonEncode({
  "rating": rating,
  "Name":globalss.StudentName,
  "name":teachername
  
});
    var res= await http.post(Uri.parse(globalss.IP+"/tasks/SaveRating"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


        },

        body: body1);
       
            if(res.body=="YouCant"){
         _displayErrorMotionToast();
                        rate=false;

          }
          else{
        if(mounted){
      
   if(res.statusCode==200){
        rate=true;

   }
        }
          }
    }catch(e){
      print(e);
    }
    return rate;

  }
  void initState(){
        super.initState();

    About = GetAbout();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'Teacher info',
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage('images/Music-Lesson.JPG'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child:Waitforme() 
            ),
          ],
        ),
      ),
    );
  }
  Widget Waitforme() {
  
  return FutureBuilder(future:About, builder:((context, snapshot)  {

      return snapshot.data==null||About1.isEmpty?  Center(child: CircularProgressIndicator()):
      Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'images/icons-back.png',
                            height: 18,
                          ),
                        ),
                        SvgPicture.asset(
                          'images/icons-meatball.png',
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.24,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              if(globalss.Teacherimagee!="")
                              Image(
                               image: MemoryImage(base64Decode(globalss.Teacherimagee)),
                                height: 100,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    globalss.TeacherName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xff1E1C61),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    " ${globalss.Teacherins} teacher",
                                    style: TextStyle(
                                      color: Color(0xff1E1C61).withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      
                                      
                                     if(rate) SmoothStarRating(

                                        starCount: 5,
                                        rating: 0,
                                      
                                          onRated: (v) {
                                      setState(() {
                                         rating=v;
                                         SaveRating(rating,globalss.TeacherName);
                                        
                                       });
                                       
                                    },
                                   

                                        allowHalfRating: false,
                                        color: Colors.yellow,
                                        borderColor: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      if(rate)
                                      Text(
                                      
                                       " ${rating.toInt()}",
                                        style: GoogleFonts.sansita(
                                            color: Colors.grey[700]),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'About Teacher',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xff1E1C61),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                          
                            "${About1}",
                            style: TextStyle(
                              height: 1.6,
                              color: Color(0xff1E1C61).withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
      
      

  }));
}
}
