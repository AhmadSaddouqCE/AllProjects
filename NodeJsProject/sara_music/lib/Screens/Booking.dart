import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:shape_of_view_null_safe/generated/i18n.dart';
import 'package:toggle_bar/toggle_bar.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:sara_music/globalss.dart';
import 'package:sara_music/Futures.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sara_music/Screens/Category.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:full_screen_menu/full_screen_menu.dart';

class Booking extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    
    return BookingState();
  }
}


class BookingState extends State<Booking> {
        List TeachersImage1=[];
late Future TC;
late Future TIC;
late Future Img;
 late Future username;
  late Future username1;
  late Future TeachInst;
  late Future all;
  String Ahmad = "";
  int Flag=0;

  List<String> labels = ["Booking", "Appointment"];
  List teacher = [];
    List Instruments = [];
late Future n;
late Future n1;
late Future n2;
late Future n3;
late Future StudnetT;
late Future StudentI;
  TextEditingController Time = TextEditingController();
    TextEditingController Date = TextEditingController();
    TextEditingController Tname = TextEditingController();
        TextEditingController Instrument = TextEditingController();


var teacher1 = 0;

  int currentIndex = 0;
     var NAME1="1";
   var NameIns;
   var CountTeacher="0";
   var arr;
    var NAME2="1";
   var arr2;
   var DDate = "";
   var TTime = "";
   var TNAME = "";

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
Future DeleteDate() async{

 var res= await http.post(Uri.parse(globalss.IP+"/tasks/DeleteAp"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  });

  if(res.statusCode==200){
         Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                    builder: (context) => bottom_bar(), maintainState: false));
            
            
_displayErrorMotionToastDelete();
  }
}

   
Future EditDate() async{

 var res= await http.post(Uri.parse(globalss.IP+"/tasks/EditAp"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  });

  if(res.statusCode==200){
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                    builder: (context) => Booking(), maintainState: false));
            
_displayErrorMotionToast();
  }
}
var studentsteacherimage="";
  Future StudentsTeacher()async{
try{
  var res= await http.get(Uri.parse(globalss.IP+"/tasks/TeachersImage"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 


  });
if(mounted){
  if(res.statusCode==200){
    studentsteacherimage=res.body;
  }
}
}catch(e){
  print(e);
}
  return await studentsteacherimage;

   }
var studentsinstrument="";
    Future StudentsInstrument()async{
try{
  var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudebtsInstruments"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  });
if(mounted){
  if(res.statusCode==200){
    studentsinstrument = res.body;
  }
}
}catch(e){
  print(e);
}
  return await studentsinstrument;

   }
var DDate1="";
var d;
   Future SD()async{
try{
  var res= await http.get(Uri.parse(globalss.IP+"/tasks/SD"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  });
if(mounted){
  if(res.statusCode==200){
    DDate = res.body;
  }
}
 DDate1 = DDate.toString();
 d = DDate1.split(" ");

  return await d[0];
}catch(e){
  print(e);
}


   }
    Future ST()async{
try{
  var res= await http.get(Uri.parse(globalss.IP+"/tasks/ST"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  });
if(mounted){
  if(res.statusCode==200){
    TTime = res.body;
  }
     
   }
   }catch(e){
     print(e);
   }
     return await [TTime];

    }
    Future STN()async{
     try{
  var res= await http.get(Uri.parse(globalss.IP+"/tasks/STN"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
   'Authorization': 'Bearer ' + globalss.authToken 


  });
  if(mounted){
    if(res.statusCode==200){
      TNAME = res.body;
    }
  }
     }catch(e){
       print(e);
     }
  return await [TNAME];

     
   }
 Future  CountT()  async {
try{
  var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/count"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });

    if(mounted){

  if(res.statusCode==200){
        setState(() {
         CountTeacher= res.body;

    });

    }
    
  
   
  }
}catch(e){
  print(e);
}

    return await [int.parse(CountTeacher)] ;

  
  
  }

    Future TEACHINS() async{
      try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/INST"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
       setState(() {
         NAME2= res.body;

  });
     
    }
   
  }
 

    var NAME3 =  NAME2.toString();
    arr2 =  NAME3.split(",");
    if(CountTeacher!=""){
    for(int i = 0; i<int.parse(CountTeacher);i++){
      Instruments.add( arr2[i]);
    }
    }
      }catch(e){
        print(e);
      }
    return await [Instruments] ;


    
   
  }

   
  
  Future SETNAME1() async{
    try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/TeachersList"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
       setState(() {
         NAME1= res.body;

  });
     
    }
   
  }
 

    var NAME =  NAME1.toString();
    arr =  NAME.split(",");
    if(CountTeacher!=""){
    for(int i = 0; i<int.parse(CountTeacher);i++){
      teacher.add( arr[i]);
    }
    }
    }catch(e){
      print(e);
    }
    return await teacher ;


    
   
  }
    
 
      // final Future<void> _calculation = SETNAME1;

  bool _verticalList = false;
  var instrument = 0;
  ScrollController _scrollController = ScrollController();
  
  int value = 0;
  Widget CustomRadioButton(String text, int index1,TextEditingController Time) {
      return OutlineButton(
      onPressed: () {
        Time.text = text;
        setState(() {
             

          value = index1;
             
          TextFormField(
             controller:Time,
        

          );
        });
      },
      color: Colors.pink[600],
      hoverColor: Colors.pink,
      padding: EdgeInsets.all(15),
      child: Text(
        text,
        style: TextStyle(
          color: (value == index1) ? Colors.pink.shade600 : Colors.black,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      borderSide: BorderSide(
          width: 3,
          color: (value == index1) ? Colors.pink.shade600 : Colors.black),
    );
  }
        DateTime _selectedDate = DateTime.now();
Future ALL() async{
   await CountT();
  await TEACHINS();
    await SETNAME1();
  await SD();
  await  ST();
  await  STN();
 await TeachersCountImage();
 await TeachersImage();
 await StudentsInstrument();
 await StudentsTeacher();
}
  @override
  void initState(){
    super.initState();
   username1 = CountT();
  TeachInst = TEACHINS();
    username = SETNAME1();
    n = SD();
    n1 = ST();
    n2 = STN();
     TC=TeachersCountImage();
 TIC=TeachersImage();
 StudentI=StudentsInstrument();
 StudnetT=StudentsTeacher();
    all = ALL();
  
  }
  
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
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
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                    child: Text(
                      'Booking',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ToggleBar(
                labels: labels,
                backgroundColor: Color.fromARGB(255, 107, 129, 133),
                selectedTabColor: Colors.pink[600],
                onSelectionUpdated: (index1) 
                    {
                      
                     
                        setState(() {
                          currentIndex = index1;
                        });
                               
                                  
     
   
                                },
              ),
              SizedBox(
                height: 40,
              ),
              if (currentIndex == 0) Column(
                    
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: <Widget>[
                      
                        Padding(
                          
                          padding: const EdgeInsets.only(left: 18, bottom: 8),
                          child: Text(
                            'Choose a Date',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.grey[700]),
                              
                          ),
                          
                        ),
                        
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 231, 241, 241),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            
                            children: [
                              
                              SizedBox(
                                height: 5,
                              
                              ),
                            
                              
                              
                              
                            CalendarTimeline (
                                
                                
                                showYears: true,
                                initialDate: _selectedDate,
                                
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                                     
                                onDateSelected:(date)
                                 {
                                   
        setState(() {
       
          
            _selectedDate=date!;
            Date.text = _selectedDate.toString();

          
          
     });
                                  
                                  
                               
                                  
     
   
                                }
                                ,
                                leftMargin: 20,
                                monthColor: Colors.black,
                                dayColor: Colors.black,
                                dayNameColor: Colors.white,
                                activeDayColor: Colors.white,
                                activeBackgroundDayColor: Colors.pink[600],
                                dotsColor: Colors.white,
                                selectableDayPredicate: (date) =>
                              
                                    date.day != 0,
                                locale: 'en',
                              ),
                            
                            ],
                          ),
                          
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 231, 241, 241),
                              borderRadius: BorderRadius.circular(30)),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            
                            runSpacing: 10,
                            children: [
                              CustomRadioButton("9-10 am", 1,Time),
                              CustomRadioButton("10-11 am", 2,Time),
                              CustomRadioButton("11-12 pm", 3,Time),
                              CustomRadioButton("12-1 pm", 4,Time),
                              CustomRadioButton("1-2 pm", 5,Time),
                              CustomRadioButton("2-3 pm", 6,Time),
                              CustomRadioButton("3-4 pm", 7,Time),
                              CustomRadioButton("4-5 pm", 8,Time),
                              CustomRadioButton("5-6 pm", 9,Time),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            'Choose an instrument',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 650,
                          child: VsScrollbar(
                            controller: _scrollController,
                            showTrackOnHover: true,
                            isAlwaysShown: false,
                            scrollbarFadeDuration: Duration(milliseconds: 500),
                            scrollbarTimeToFade: Duration(milliseconds: 800),
                            style: VsScrollbarStyle(
                              hoverThickness: 10.0,
                              radius: Radius.circular(10),
                              thickness: 5.0,
                              color: Colors.purple.shade900,
                            ),
                            child: Waitforme()
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 15, bottom: 50),
                          child: ElevatedButton(
                            child: Text("Booking Now"),
                            onPressed: () {
                              if(Time.text==""||Date.text==""||teacher.length==0){
                                return _displayErrorMotionToastt3();
                                
                              }
                              BOOK();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[600],
                              onPrimary: Colors.white,
                              minimumSize: const Size(150, 40),
                              textStyle: TextStyle(
                                fontSize: 18,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 110),
                            ),
                          ),
                        ),
                      ],
                    ) else SizedBox(
                      height: 450,
                      child: Waitforme1(),
                    ),
            ],
          ),
        ),
      ),
      
    );
    
  

  }
  

  void showFullScreenMenu(BuildContext context) {
    FullScreenMenu.show(
      context,
      backgroundColor: Colors.black,
      items: [
        FSMenuItem(
          icon: Icon(Icons.edit, color: Colors.white),
          text: Text('Edit', style: TextStyle(color: Colors.white)),
          gradient: deepPurpleGradient,
          onTap: (){
                       FullScreenMenu.hide();

            EditDate();
            
          },
        ),
        FSMenuItem(
          icon: Icon(Icons.delete, color: Colors.white),
          text: Text('Delete', style: TextStyle(color: Colors.white)),
          onTap: (){
            FullScreenMenu.hide();
            DeleteDate();
          },
        ),
      ],
    );
  }
  
   void _displayErrorMotionToastt3() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("You Must select Date, Time and a teacher!."),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

    void _displayErrorMotionToast() {
       
    MotionToast.success(
      title: Text(
        "Success",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("You can edit your booking."),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }



  
     void _displayErrorMotionToast3() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("You can't book to many teachers!"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
     void _displayErrorMotionToast10() {
       
    MotionToast.success(
      title: Text(
        "Success",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Booked'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast5() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Ops!, looks like our class is full'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast1() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('You are already Booked to a date with this teacher!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  
    void _displayErrorMotionToast2() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Date is already booked, try another one!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
      void _displayErrorMotionToast6() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Ops, looks like our teacher in a break time at this Date, try picking another one!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToastDelete() {
       
    MotionToast.success(
      title: Text(
        "Success",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Your date is deleted and you can choose another one!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }


   void _displayErrorMotionToastDelete1() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('You need to add a picture to define your ID!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  Future<void> BOOK() async{
   

      var body1 = jsonEncode({
  'name': Tname.text,
  'Time' : Time.text,
  'Date' : Date.text,
  'instrument' : Instrument.text,
  'token': globalss.authToken

     });
  print(Date.text);
    var res= await http.patch(Uri.parse(globalss.IP+"/tasks/TheTeacher"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 
  },body: body1);
  
   if(res.statusCode==200){
        // Map<String,dynamic> DB = jsonDecode(res.body);
  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => bottom_bar()),
            );
                   return _displayErrorMotionToast10();

   }
   else{
      if(res.body=="DefineYourSelf"){
       return _displayErrorMotionToastDelete1();

     }
     if(res.body=="AlreadySigned"){
       return _displayErrorMotionToast1();

     }
      else if(res.body=="BookedDate"){
       return _displayErrorMotionToast2();

     }
       else if(res.body=="NO"){
       return _displayErrorMotionToast3();

     }
     else if(res.body=="Max"){
       return _displayErrorMotionToast5();

     }
     else if(res.body=="BreakTime"){

       _displayErrorMotionToast6();
     }
   }
   
    }
Widget Waitforme() {
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()):
      ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: _verticalList
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                itemCount: int.parse(CountTeacher),
                                itemBuilder: (BuildContext context, int index) {
                                    
                                  Color? color = Colors.pink[600];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        instrument = index;
                                        Tname.text = teacher[index];
                                        Instrument.text = Instruments[index];
                                      });
                                    },
                                    child: Container(
                                      
                                        alignment: Alignment.center,
                                        child: Column(
                                          
                                          
                                          children: [
                                                

                                              
                                            Text(
                                            "${Instruments[index]}",
                                              
                                              style: TextStyle(
                                                                                      

                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: instrument == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                height: 1,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              child: AdvancedAvatar(
                                                size: 40,
                                                image: MemoryImage(base64Decode("${TeachersImage1[index]}")),
                                                foregroundDecoration:
                                                    BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          
          Text(     
                                      "${teacher[index]}",             
                                    
                                                       

                                              
                                                 
                                               textAlign: TextAlign.center,
                                               style: TextStyle(
                                                
                                                 fontSize: 13,
                                                 color: instrument == index
                                                     ? Colors.white
                                                     : Colors.black,
                                                 height: 1,
                                               )
                                               ,
                                             )
      
                                              

                                           
                                            
                                        
                                          ],
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                300,
                                        decoration: BoxDecoration(
                                            color: instrument == index
                                                ? color
                                                : Color.fromARGB(255, 231, 241, 241),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 20)),
                                  );
                                });
      

  }));
}
Widget Waitforme1() {
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {
if(TNAME==""){
  Flag=0;

}
else{
  Flag=1;
}

      return snapshot.data==null?  Center(child: CircularProgressIndicator()):
      
    ListView.separated(
      
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        
                        itemCount:Flag,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(indent: 16),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          width: 283,
                          height: 160,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 231, 241, 241),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 30,
                                right: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 80,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[600],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "${TTime}",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: 100,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[600],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "${d[0]}",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        SizedBox(height: 5,),
                                   
                                    Text(
                                    
                                     "${TNAME}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                   
                                    Text(
                                    
                                     "${studentsinstrument}",
                                    

                                      style: TextStyle(
                                        color: Color.fromARGB(255, 71, 65, 65),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 15,
                                child: SizedBox(
                                  width: 80,
                                  height: 110,
                                  child: Hero(
                                    tag: "${teacher[index]}",
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 40,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                           MemoryImage(base64Decode("${studentsteacherimage}")),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 15,
                                  child: InkWell(
                                    onTap: () => showFullScreenMenu(context),
                                    child: Image.asset(
                                        "images/icons-meatball.png",
                                        height: 30),
                                  ))
                            ],
                          ),
                        ),
                      );
      

  }));
}
}
