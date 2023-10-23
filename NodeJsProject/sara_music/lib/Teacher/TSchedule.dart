// import 'package:flutter/material.dart';

// class TAppointment extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return TAppointment_State();
//   }
// }

// class TAppointment_State extends State<TAppointment> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbols.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Teacher/THomepage.dart';
import 'package:sara_music/Teacher/Tbottom_bar.dart';
import 'package:sara_music/globalss.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sara_music/Shop/colors.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:time_range/time_range.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';


import 'Constant.dart';

class TSchedule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TScheduleState();
  }
}



enum FilterStatus { Upcoming, Complete, Cancel }


class TScheduleState extends State<TSchedule> {
  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 9, minute: 00),
    TimeOfDay(hour: 10, minute: 00),
  );
  TimeRangeResult? _timeRange;
   var result = "";
      var result1 = "";
      var Temp;
      late Future w;
  List<Map> schedules = [];

var get1;
late List<Map> filteredSchedules;
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;
  late bool _isButtonDisabled;
  late Future NAM;
  late Future DAT;
  late Future TIM;
  late Future COU;
  late Future CCSS;
  late Future ALLD;
  late Future CO;
  late Future RES2;
  late Future CompletedD;
  late Future CompletedT;
  late Future CompletedS;
  late Future CompletedI;

  late Future CanceledDD;
  late Future CanceledT;
  late Future CanceledS;
  late Future CanceledI;
  var count12="";
  List DATES = [];
  late Future A;
  late Future B;
  List Times = [];
  List NAMES = [];

  int q=0;
  var s= "";
  var d;
  var names = "";
  var dates = "";
  var times = "";
  var NA;
  var TA;
  var DA;

  var ALL1="";
  var countS = "";
  int pressed = 0;
  var StatusTT = "";
  var c = "";
  var ars;
  var counttt="";
  
  var a = "";
  var a1;
  var b = "";
  var b1;

var imageT="";
var arrTTT;
List UsersImageS=[];
late Future StudentImage;

late Future all;

late Future RemoveCanceled;
late Future RemoveCompleted;
Future RemoveFromComplete(var k) async{
var body1 = jsonEncode({
  "name":k["StudentName"],
});
var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/RemoveFromCompleted"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  },body:body1);
  if(res.statusCode==200){
      Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Tbottom_bar()));
_displayErrorMotionT();
  }
  
}

Future RemoveFromCancel(var k) async{
var body1 = jsonEncode({
  "name":k["StudentName"],
});
var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/RemoveFromCanceled"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  },body:body1);
  if(res.statusCode==200){
      Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Tbottom_bar()));
_displayErrorMotionT();
  }
  
}
Future UsersImage() async{
  try{
  var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/ImageN"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': 'Bearer ' + globalss.authToken 


  });
  if(mounted){
    if(res.statusCode==201){
      imageT=res.body;
    }
  }
  var imageT1 = imageT.toString();
  arrTTT = imageT1.split(",");

  
    for(int i = 0; i<int.parse(countS);i++){
      UsersImageS.add(arrTTT[i]);


  }
  }catch(e){
    print(e);
  }
return await UsersImageS;
}
void _displayErrorMotionT2() {
       
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('You have break time in this date.'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionT() {
       
    MotionToast.success(
      title: Text(
        "Success",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This student is removed from the list'),
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
      description: Text('Date Is Updated!'),
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
      description: Text('Sorry, this Date is already Booked!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

 void _displayErrorMotionToast2() {
       
    MotionToast.success(
      title: Text(
        "Success",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('The Appointment is Canceled'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  } 
Future SENDTOCANCEL(var get)async{
try{

var body1 = jsonEncode({
  "Name": get["StudentName"],
  "CanceledST" : get['reservedTime'],
  "CanceledSD": get['reservedDate'],
  "CanceledSInstrument":get['instrument'],
  "StudentImageCA":get['img']
});

   var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/CANCEL"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  }, body: body1);
if(res.statusCode==200){
   Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Tbottom_bar()));
                     

                            
_displayErrorMotionToast2();
}
} catch(e){
  print(e);
}
}

//--NumberOfStudents
Future STUCOUNT() async {
  try{

 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/COUNTS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   countS = res.body;

   });
  }
 }
  

  } catch(e){
    print(e);
  }

  return await [int.parse(countS)];


}
//--


//---StudentsNAMES
Future StudentsList() async {
// STUCOUNT();
try{

 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/ListN"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==201){
   setState(() {
   names = res.body;

   });
  }
 }
 
    var names1 =  names.toString();
    NA =  names1.split(",");
    for(int i = 0; i<int.parse(countS);i++){
      
      NAMES.add(NA[i]);
    

    } 
} catch(e){
  print(e);
}
return await [NAMES];

}

//--StudentsTime
Future TimesList() async {
try{
  
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/ListS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
if(mounted){
  if(res.statusCode==201){
   setState(() {
   times = res.body;

   });
  }
 }

    var times1 =  times.toString();
    TA =  times1.split(",");
    for(int i =0;i<int.parse(countS);i++){
      Times.add(TA[i]);
    }

}catch(e){
  print(e);
}
  return await [Times];
}


//---


Future DatesList() async {
// STUCOUNT();
try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/ListD"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==201){
   setState(() {
   dates = res.body;

   });
  }
 }
 
    var dates1 =  dates.toString();
    DA =  dates1.split(",");
    for(int i = 0; i<int.parse(countS);i++){
     
      DATES.add(DA[i]);
    }
 
    
    }catch(e){
      print(e);
    }
    return await [DATES];

}

//---


//--FetchAllData
Future ALL() async {
  try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/ALL"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
  Map<String,dynamic> DB = jsonDecode(res.body);
   setState(() {
   ALL1 = DB['instrument'];

   });
  }
 }
 

  }catch(e){
    print(e);
  }
return await [ALL1];

}


//--


Future Completed(var name, var image, var instrument,var date, var time) async{
try{
var body1 = jsonEncode({
  "Name": name.toString(),
  "CompSD":date.toString(),
  "CompST":time.toString(),
  "CompSinstrument":instrument.toString(),
  "StudentImageCO":image.toString()

});



   var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/COMPS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  }, body: body1);

 if(res.body==200){

 }
} catch(e){
  print(e);
}
}


//




//

Future RESCHED (List<String> A1, var get1) async
{

try{
  var qq = A1[1]+"-"+A1[2] + " "+ A1[3].toLowerCase();
var body1 = jsonEncode({
  "Name": get1["StudentName"],
  "Time" : qq,
  "Date": A1[0]
});
print(get1["StudentName"]);

   var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/RESCHD"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  }, body: body1);
print(res.statusCode);

if(res.statusCode==200){
  Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Tbottom_bar()));
  _displayErrorMotionToast();
  return;

}
if(res.statusCode==400){
_displayErrorMotionT2();
return;

}
else{
    _displayErrorMotionToast1();

}
} catch(e){
  print(e);
}
}


DatePickerController _controller = DatePickerController();
  late bool isLoading = false;

  DateTime _selectedValue = DateTime.now();
  Future All() async{
  await  STUCOUNT();
    await  CountComp();
        await ccs();

     await  StudentsList();
     await  DatesList();
     await  ALL();
    await  STUC();
    await  CanceledImages();
    await CanceledDates();
    await CanceledTimes();
    await CanceledInstruments();

 
   await  CompList();
   await CompListImages();
   await CompListTimes();
   await CompListDates();
   await CompListInstruments();
        await  UsersImage();
      await  TimesList();
      
     
      
      DateTime selectdate = DateTime.now();

for(int i=0;i<int.parse(counttt);i++){
   schedules.add({
         'img': CanceledStudentsImages[i],
    'StudentName': CanceledStudentsNames[i],
    'instrument':CanceledStudentsInstruments[i],
    'reservedDate': CanceledStudentsDatess[i],
    'reservedTime': CanceledStudentsTimes[i],
    'status': FilterStatus.Cancel
     
   });

}
for(int j=0;j<int.parse(count12);j++){
     schedules.add({
         'img':imagesCompletedList[j],
    'StudentName':CompletedStudentsName[j],
    'instrument': instrumentsCompletedList[j],
    'reservedDate': CompletedDateList[j],
    'reservedTime': CompletedTimeList[j],
    'status': FilterStatus.Complete
     
});
}
 for(int k = 0 ;k<int.parse(countS);k++){
  var datess = DATES[k].toString();
var month = datess.toString();
var arrmonth = month.split("-");
var days1 = arrmonth.toString();
var arrdays = days1.split(" "); 
var m=int.parse(arrmonth[1]);
 if(int.parse(arrmonth[1])>=selectdate.toLocal().month.toInt()){  
 if(int.parse(arrdays[2])>=selectdate.toLocal().day.toInt()){

      schedules.add({
           'img': UsersImageS[k],
    'StudentName': NAMES[k],
    'instrument': ALL1,
    'reservedDate': DATES[k],
    'reservedTime': Times[k],
    'status': FilterStatus.Upcoming
  
      });
      
}
else if(m>selectdate.toLocal().month.toInt()){


      schedules.add({
           'img': UsersImageS[k],
    'StudentName': NAMES[k],
    'instrument': ALL1,
    'reservedDate': DATES[k],
    'reservedTime': Times[k],
    'status': FilterStatus.Upcoming
  
      });  
        


}

else{

    
      schedules.add({
           'img': UsersImageS[k],
    'StudentName': NAMES[k],
    'instrument': ALL1,
    'reservedDate': DATES[k],
    'reservedTime': Times[k],
    'status': FilterStatus.Complete
  
      });
      
      Completed(NAMES[k],UsersImageS[k],ALL1,DATES[k],Times[k]);
      
}

}


else{


      schedules.add({
           'img': UsersImageS[k],
    'StudentName': NAMES[k],
    'instrument': ALL1,
    'reservedDate': DATES[k],
    'reservedTime': Times[k],
    'status': FilterStatus.Complete
  
      });

                  Completed(NAMES[k],UsersImageS[k],ALL1,DATES[k],Times[k]);


   
      
      
}


  
}
return schedules;
  }
  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
      late bool _isButtonDisabled;
  
        COU = STUCOUNT();
        
  CCSS = ccs();
    A = CountComp();

    NAM = StudentsList();
    DAT = DatesList();
    ALLD = ALL();
  
  CO = STUC();
  
  
  
  B = CompList();
  
  CompletedD=CompListDates();
  
  CompletedI=CompListImages();
  
  CompletedS=CompListInstruments();
  
  CompletedT=CompListTimes();
  
  StudentImage=UsersImage();

     TIM = TimesList();
     CanceledI=CanceledImages();
     CanceledDD=CanceledDates();
    CanceledT= CanceledTimes();
    CanceledS=CanceledInstruments();
all = All();

  }
  
// List<Map> schedules = [
//   {
//     'img': 'images/ehab.jpg',
//     'StudentName': 'Ramy Tubileh',
//     'instrument': 'Violin',
//     'reservedDate': 'Monday, Aug 29',
//     'reservedTime': '11:00 - 12:00',
//     'status': FilterStatus.Upcoming
//   },
//   {
//     'img': 'images/ehab.jpg',
//     'StudentName': 'Adel Halaweh',
//     'instrument': 'Violin',
//     'reservedDate': 'Monday, Sep 29',
//     'reservedTime': '11:00 - 12:00',
//     'status': FilterStatus.Upcoming
//   },
//   {
//     'img': 'images/ehab.jpg',
//     'StudentName': 'Yasser Fathi',
//     'instrument': 'Violin',
//     'reservedDate': 'Monday, Jul 29',
//     'reservedTime': '11:00 - 12:00',
//     'status': FilterStatus.Upcoming
//   },
//   // {
//   //   'img': 'images/ehab.jpg',
//   //   'StudentName': 'Amr AboAmr',
//   //   'instrument': 'Violin',
//   //   'reservedDate': 'Monday, Jul 29',
//   //   'reservedTime': '11:00 - 12:00',
//   //   'status': FilterStatus.Complete
//   // },
//   // {
//   //   'img': 'images/ehab.jpg',
//   //   'StudentName': 'Mustafa Wajdi',
//   //   'instrument': 'Violin',
//   //   'reservedDate': 'Monday, Feb 29',
//   //   'reservedTime': '11:00 - 12:00',
//   //   'status': FilterStatus.Cancel
//   // },
//   // {
//   //   'img': 'images/ehab.jpg',
//   //   'StudentName': 'Mohammad Kukhun',
//   //   'instrument': 'Violin',
//   //   'reservedDate': 'Monday, Jul 29',
//   //   'reservedTime': '11:00 - 12:00',
//   //   'status': FilterStatus.Cancel
//   // },
// ];
        

  @override
  Widget build(BuildContext context) {
 
     filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status;
    }).toList();
       
  

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            SizedBox(
              height: 40,
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
                    'Schedule',
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
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.Upcoming) {
                                  status = FilterStatus.Upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.Complete) {
                                  status = FilterStatus.Complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.Cancel) {
                                  status = FilterStatus.Cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: TextStyle(
                                  color: Color(MyColors.header01),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child:
                Waitforme()
               )
          ],
        ),
      ),
    );
    
  }
    Widget Waitforme() {
  
    
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {
      return snapshot.data==null?  Center(child: CircularProgressIndicator()):
   ListView.builder(
     
     shrinkWrap: true,
                itemCount: filteredSchedules.length ,
                itemBuilder: (context, index) {
                  var _schedule = filteredSchedules[index];
                
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    
                    margin: !isLastElement
                        ? EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                             

                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:MemoryImage(base64Decode("${_schedule['img']}")) ,
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    
                                    _schedule['StudentName'],
                                    style: TextStyle(
                                        color: Color(MyColors.header01),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _schedule['instrument'],
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(MyColors.bg03),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Color(MyColors.primary),
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _schedule["reservedDate"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(MyColors.primary),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_alarm,
                                      color: Color(MyColors.primary),
                                      size: 17,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _schedule["reservedTime"],
                                      style: TextStyle(
                                        color: Color(MyColors.primary),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _schedule["status"] == FilterStatus.Upcoming
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    
                  
                                    Expanded(
                                      
                                      
                                      child: OutlinedButton(
                                        
                                        child: Text('Cancel'),
                                        
                                        onPressed: () async {

                                          setState(() {

                                         var get  = filteredSchedules[index];

                                         SENDTOCANCEL(get);
                                          });
                                          
                        
                      
                 
                                                // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Tbottom_bar()));


                                        },
                                      ),
                                    ),
                                    
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        child: Text('Reschedule'),
                                        onPressed: () {
                                       get1  = filteredSchedules[index];
                                       print(get1["StudentName"]);
                                        
                                          _showDialog();
                                        },
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _schedule["status"] == FilterStatus.Complete
                                        ? Expanded(
                                            child: OutlinedButton.icon(
                                              label: Text(
                                                'Successed',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              icon: Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {

                                             var fill = filteredSchedules[index];

                                               RemoveFromComplete(fill);

                                              },
                                            ),
                                          )
                                        : Expanded(
                                            child: OutlinedButton.icon(
                                              label: Text(
                                                'Canceled',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                _isButtonDisabled;
                                              },
                                            ),
                                          ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        child: Text('Delete'),
                                        onPressed: () {
                                         var Fil = filteredSchedules[index];
                                         RemoveFromCancel(Fil);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  );
                },
              );

  }));
}


  static const double leftPadding = 50;
  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: leftPadding),
              child: Text(
                'Select New Date',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold, color: Color(MyColors.dark)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: DatePicker(
                DateTime.now(),
                width: 60,
                height: 80,
                controller: _controller,
                initialSelectedDate: DateTime.now(),
                selectionColor: Color(MyColors.primary),
                selectedTextColor: Colors.white,
                inactiveDates: [],
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                     Temp = _selectedValue.toString();
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: leftPadding),
              child: Text(
                'Select New Time',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold, color: Color(MyColors.dark)),
              ),
            ),
            SizedBox(height: 20),
            TimeRange(
              fromTitle: Text(
                'FROM',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(MyColors.dark),
                  fontWeight: FontWeight.w600,
                ),
              ),
              toTitle: Text(
                'TO',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(MyColors.dark),
                  fontWeight: FontWeight.w600,
                ),
              ),
              titlePadding: leftPadding,
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color(MyColors.dark),
              ),
              activeTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: white,
              ),
              borderColor: Color(MyColors.grey02),
              activeBorderColor: Color(MyColors.grey02),
              backgroundColor: Colors.transparent,
              activeBackgroundColor: Color(MyColors.primary),
              firstTime: TimeOfDay(hour: 9, minute: 00),
              lastTime: TimeOfDay(hour: 18, minute: 00),
              initialRange: _timeRange,
              timeStep: 60,
              timeBlock: 60,
              onRangeCompleted: (range) => setState(() => 
              _timeRange = range

               

                          
              ),
              

            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: ElevatedButton(
                  
              onPressed: () {
              result= _timeRange!.start.format(context);
          result1= _timeRange!.end.format(context);
          var Q1 = result.split(":");
           var E=result1.split(":");

             var  E1 = result1.split(" ");

                  List<String> A1=[];
                  A1.add(Temp);
                  A1.add(Q1[0]);
                  A1.add(E[0]);
                  A1.add(E1[1]);
          //  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TSchedule())).whenComplete(TimesList);
            
                RESCHED(A1,get1);


              },
              child: Text("Reschedule"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 46, 23, 172),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                textStyle: TextStyle(fontSize: 16)
              ),
            ))
          ],
        ),
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Color(MyColors.primary),
      backgroundColor: Color.fromARGB(255, 231, 242, 241),
    );
  
  }
  var imagesCompleted;
  var arric;
  var imagesCompletedList=[];
 Future CompListImages() async{
  try{
   var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CompletedImages"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
if(mounted){
  if(res.statusCode==200){
   setState(() {
   imagesCompleted = res.body;

   });

  }
 }
 
    var ImagesCompleted1=  imagesCompleted.toString();
    arric =  ImagesCompleted1.split(",");
    for(int i = 0; i<int.parse(count12);i++){
      imagesCompletedList.add(arric[i]);
    
   
    
    }
 

  }catch(e){
    print(e);
  }
return await [imagesCompletedList];

}

var instrumentsCompletedList=[];
var instrumentC="";
var arrinstrument;
 Future CompListInstruments() async{
  try{
   var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CompletedInstruments"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
if(mounted){
  if(res.statusCode==200){
   setState(() {
   instrumentC= res.body;

   });

  }
 }
 
    var instrumentC1 =  instrumentC.toString();
    arrinstrument =  instrumentC1.split(",");
    for(int i = 0; i<int.parse(count12);i++){
    instrumentsCompletedList.add(arrinstrument[i]);
 
    }
    
 

  }catch(e){
    print(e);
  }
return await [instrumentsCompletedList];

}

var CompletedTimeList=[];
var TimesCompleted="";
var arrTC;
 Future CompListTimes() async{
  try{
   var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CompletedTimes"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
if(mounted){
  if(res.statusCode==200){
   setState(() {
   TimesCompleted= res.body;

   });

  }
 }
 
    var TimesCompleted1 =  TimesCompleted.toString();
    arrTC =  TimesCompleted1.split(",");
    for(int i = 0; i<int.parse(count12);i++){
       CompletedTimeList.add(arrTC[i]);
    }
 

  }catch(e){
    print(e);
  }
return await [CompletedTimeList];

}

var CompletedDateList=[];
var CompletedDate="";
var arrCD;
 Future CompListDates() async{
  try{
   var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CompletedDates"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
if(mounted){
  if(res.statusCode==200){
   setState(() {
   CompletedDate = res.body;

   });

  }
 }
 
    var CompletedDate1 =  CompletedDate.toString();
    arrCD =  CompletedDate1.split(",");
    for(int i = 0; i<int.parse(count12);i++){
      CompletedDateList.add(arrCD[i]);
     
    }
 

  }catch(e){
    print(e);
  }
return await [CompletedDateList];

}


var CompletedStudentsName=[];
  Future CompList() async{
  try{
   var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CCSS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
if(mounted){
  if(res.statusCode==200){
   setState(() {
   a = res.body;

   });

  }
 }
 
    var aaa1 =  a.toString();
    a1 =  aaa1.split(",");
    for(int i = 0; i<int.parse(count12);i++){
     CompletedStudentsName.add(a1[i]);
    
    }
 

  }catch(e){
    print(e);
  }
return await [CompletedStudentsName];

}
Future CountComp() async{
  try{

   var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/COUNTSCC"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   count12 = res.body;

   });
  }
 }

  }catch(e){
    print(e);
  }
  return await [int.parse(count12)];

}

//
Future STUC() async {
  try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/COUNTSC"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   counttt = res.body;

   });
  }
 }

  } catch(e){
    print(e);
  }
return await [int.parse(counttt)];

}
var CanceledStudentsNames=[];
Future ccs() async {
  try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CCS"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   c = res.body;

   });

  }
 }
 
    var cc1 =  c.toString();
    ars =  cc1.split(",");
    for(int i = 0; i<int.parse(counttt);i++){
      CanceledStudentsNames.add(ars[i]);
  
    }
 

}
catch(e){
  print(e);
}
return await [CanceledStudentsNames];

}



//



var CanceledStudentsImages=[];
var CanceledImage="";
var arrCII;
Future CanceledImages() async {
  try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CanceledImages"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   CanceledImage = res.body;

   });

  }
 }
 
    var CanceledImage1 =  CanceledImage.toString();
    arrCII =  CanceledImage1.split(",");
    for(int i = 0; i<int.parse(counttt);i++){
      CanceledStudentsImages.add(arrCII[i]);
  
    }
 

}
catch(e){
  print(e);
}
return await [CanceledStudentsImages];

}
var CanceledStudentsDatess=[];
var CanceledD="";
var arrCanceledD;
Future CanceledDates() async {
  try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CanceledDate"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   CanceledD = res.body;

   });

  }
 }
 
    var CanceledD1 =  CanceledD.toString();
    arrCanceledD =  CanceledD1.split(",");
    for(int i = 0; i<int.parse(counttt);i++){
      CanceledStudentsDatess.add(arrCanceledD[i]);
  
    }
 

}
catch(e){
  print(e);
}
return await [CanceledStudentsDatess];

}
var CanceledStudentsTimes=[];
var arrCanceledT;
var CanceledTimes1="";
Future CanceledTimes() async {
  try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CanceledTime"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   CanceledTimes1 = res.body;

   });

  }
 }
 
    var CanceledTimes11 =  CanceledTimes1.toString();
    arrCanceledT =  CanceledTimes11.split(",");
    for(int i = 0; i<int.parse(counttt);i++){
      CanceledStudentsTimes.add(arrCanceledT[i]);
  
    }
 

}
catch(e){
  print(e);
}
return await [CanceledStudentsTimes];

}
var CanceledStudentsInstruments=[];
var CanceledInstruments1="";
var arrCI;
Future CanceledInstruments() async {
  try{
 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/CanceledInstruments"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

 if(mounted){
  if(res.statusCode==200){
   setState(() {
   CanceledInstruments1= res.body;

   });

  }
 }
 
    var CanceledInstruments11 =  CanceledInstruments1.toString();
    arrCI =  CanceledInstruments11.split(",");
    for(int i = 0; i<int.parse(counttt);i++){
      CanceledStudentsInstruments.add(arrCI[i]);
  
    }
 

}
catch(e){
  print(e);
}
return await [CanceledStudentsInstruments];

}


}

