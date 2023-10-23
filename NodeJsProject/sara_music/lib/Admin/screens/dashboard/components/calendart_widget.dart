
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:sara_music/globalss.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:sara_music/globalss.dart';
import 'package:http/http.dart' as http;
import 'package:sara_music/Admin/core/constants/color_constants.dart';
import 'package:sara_music/Admin/core/models/data.dart';
import 'calendar_list_widget.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<CalendarData> _selectedDate = [];
       List<CalendarData> list1 = <CalendarData>[];


  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<CalendarData> _eventLoader(DateTime date) {
    return  list1
        .where((element) => isSameDay(date, element.date))
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {

        _selectedDay = selectedDay;
        _focusedDay = focusedDay;

        _selectedDate = list1

      
            .where((element) => isSameDay(selectedDay, element.date))
            .toList();
      });
      
    }
  }

  @override
    var Counts ="0";
   var Dates="0";
   var Names="0";
   var Times="0";
   var Instruments="0";


   late Future C;
   late Future all;

   List ListOfNames=[];
   List ListofDates=[];
   List ListofTimes=[];
   List ListofInstruments=[];
   int k=0;
var Counts1;

  Future StudentsCount() async {

 var res= await http.get(Uri.parse(globalss.IP+"/Ttasks/StudentsCountss"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });

   var res1= await http.get(Uri.parse(globalss.IP+"/Ttasks/StudentsDates"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
   var res2= await http.get(Uri.parse(globalss.IP+"/Ttasks/StudentsNames"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });

    var res3= await http.get(Uri.parse(globalss.IP+"/Ttasks/StudentsTimesss"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
    var res4= await http.get(Uri.parse(globalss.IP+"/Ttasks/StudentInstrumentsss"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
    if(res.statusCode==200){
       Counts = res.body;

    }
    if(res1.statusCode==200){
      Dates = res1.body;
    }
    if(res2.statusCode==200){
      Names = res2.body;
    }
    if(res3.statusCode==200){
     Times=res3.body;
    }
    if(res4.statusCode==200){
      Instruments = res4.body;
    }
  }
  var Counter1=0;

      Counts1=Counts.toString().split(",");
      var Dates1=Dates.toString().split(",");
      var Names1=Names.toString().split(",");
      var Times1=Times.toString().split(",");
      var check = Counts1.toString().split(",").length;
      var Instruments1=Instruments.toString().split(",");
    
      for(int i=0;i<check;i++){
         for(int j=0;j<int.parse(Counts1[i]);j++){

                   ListofDates.add(Dates1[Counter1]) ;
                   ListOfNames.add(Names1[Counter1]);
                   ListofTimes.add(Times1[Counter1]);
                   ListofInstruments.add(Instruments1[Counter1]);

                   Counter1++;
                   
  
           }
         
      }
   return await [ListOfNames,ListofDates,ListofInstruments,ListofTimes];

  }
 Future StoreData()async{
 await StudentsCount();
 var Counter=0;
 var arrmonth=[];
 var arrdays=[];
 var arryears=[];
    var check = Counts1.toString().split(",").length;

 for(int k1 = 0;k1<ListofDates.length;k1++){
  var splitt= ListofDates[k1].toString().split("-");
    arrmonth.add(splitt[1]);
    arrdays.add(splitt[2]);
    arryears.add(splitt[0]);

 }
  for(int i=0;i<check;i++){
     for(int j=0;j<int.parse(Counts1[i]);j++){
list1.addAll({
CalendarData(name: "${ListOfNames[Counter]}",
date: DateTime(int.parse(arryears[Counter]),int.parse(arrmonth[Counter]),int.parse(arrdays[Counter]),int.parse(ListofTimes[Counter])),
 position: "${ListofInstruments[Counter]}",
 rating: "123")

});
Counter++;
     }

 }
 
 globalss.listt.addAll(list1);
 
return [list1];
 }
  @override
void initState(){
  super.initState();
    all = StoreData();
  

}
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Waitforme()
    );
  }
  Widget Waitforme() {
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()):
     Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${DateFormat("MMM, yyyy").format(_focusedDay)}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _focusedDay =
                            DateTime(_focusedDay.year, _focusedDay.month - 1);
                      });
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: greenColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        print(_focusedDay);
                        _focusedDay =
                            DateTime(_focusedDay.year, _focusedDay.month + 1);
                      });
                    },
                    child: Icon(
                      Icons.chevron_right,
                      color: greenColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TableCalendar<CalendarData>(
              selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2018),
              lastDay: DateTime.utc(2025),
              headerVisible: false,
              onDaySelected: _onDaySelected,
              onFormatChanged: (result) {},
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) {
                  return DateFormat("EEE").format(date).toUpperCase();
                },
                weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPageChanged: (day) {
                _focusedDay = day;
                setState(() {});
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: greenColor,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: _eventLoader
              )
              ,
          SizedBox(
            height: 8,
          ),
          CalendartList(datas: _selectedDate),
        ],
      );

  }));
}
}
