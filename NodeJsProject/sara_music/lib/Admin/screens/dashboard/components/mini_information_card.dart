import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sara_music/Admin/screens/dashboard/Add_New.dart';

import 'package:sara_music/responsive.dart';

import 'package:sara_music/Admin/models/daily_info_model.dart';

import 'package:sara_music/Admin/core/constants/color_constants.dart';
import 'package:sara_music/globalss.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sara_music/Admin/screens/dashboard/components/mini_information_widget.dart';
import 'package:sara_music/Admin/screens/forms/input_form.dart';
import 'package:flutter/material.dart';
import 'HelpSupports.dart';

class MiniInformation extends StatefulWidget {
  const MiniInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniInformation> createState() => _MiniInformationState();
}

class _MiniInformationState extends State<MiniInformation> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 12, 51, 113),
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new AddNew() ;
                    },
                    fullscreenDialog: true));
              },
              icon: Icon(Icons.add),
              label: Text(
                "Add New",
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 12, 51, 113),
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new HelpSupports() ;
                    },
                    fullscreenDialog: true));
              },
              icon: Icon(FontAwesome.sticky_note_o,),
              label: Text(
                "Help & Supports",
              ),
            ),
      ],),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: InformationCard(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.2 : 1,
          ),
          tablet: InformationCard(),
          desktop: InformationCard(
            childAspectRatio: _size.width < 1400 ? 1.2 : 1.4,
          ),
        ),
      ],
    );
  }
}

class InformationCard extends StatefulWidget {
  const InformationCard({
    Key? key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
 var dailyData1=[];
  
  var counts="0";
  late Future all;
var countt="0";
var countc="0";
   Future  CoursesCount() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/Courses/GetAllCoursesCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     countc=res.body;
     
    });
    }
   
  }
  return countc;
    }catch(e){
      print(e);
    }
 }
   Future  TeachersCount() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/teachers/GetAllTeachersCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     countt=res.body;
     
    });
    }
   
  }
  return countt;
    }catch(e){
      print(e);
    }
 }
 Future  StudentsCount() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/users/GetAllUsersCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });
      if(mounted){

  if(res.statusCode==200){
 setState(() {
     counts=res.body;
     
    });
    }
   
  }
  return counts;
    }catch(e){
      print(e);
    }
 }
 Future All()async{
   await TeachersCount();
   await StudentsCount();
   await CoursesCount();
    dailyData1 = [
  {
    "title": "Teachers",
    "volumeData": int.parse(countt),
    "icon": FlutterIcons.user_alt_faw5s,
    "totalStorage": "",
    "color": primaryColor,
    "percentage": int.parse(countt),
    "colors": [
      Color(0xff23b6e6),
      Color(0xff02d39a),
    ],
    "spots": [
      FlSpot(
        1,
        2,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  {
    "title": "Students",
    "volumeData": int.parse(counts),
    "icon": FontAwesome.user_circle,
    "totalStorage": "",
    "color": Color(0xFFFFA113),
    "percentage": int.parse(counts),
    "colors": [Color(0xfff12711), Color(0xfff5af19)],
    "spots": [
      FlSpot(
        1,
        1.3,
      ),
      FlSpot(
        2,
        1.0,
      ),
      FlSpot(
        3,
        4,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        3,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  
  {
    "title": "Courses",
    "volumeData": int.parse(countc),
    "icon": FontAwesome.music,
    "totalStorage": "",
    "color": Color(0xFFd50000),
    "percentage": int.parse(countc),
    "colors": [Color(0xff93291E), Color(0xffED213A)],
    "spots": [
      FlSpot(
        1,
        3,
      ),
      FlSpot(
        2,
        4,
      ),
      FlSpot(
        3,
        1.8,
      ),
      FlSpot(
        4,
        1.5,
      ),
      FlSpot(
        5,
        1.0,
      ),
      FlSpot(
        6,
        2.2,
      ),
      FlSpot(
        7,
        1.8,
      ),
      FlSpot(
        8,
        1.5,
      )
    ]
  },
  
  

];

return dailyData1;
 }
 
  @override
  void initState(){
    super.initState();
    all=All();
    
    
  }
  Widget build(BuildContext context) {
    List<DailyInfoModel> dailyDatas =
    dailyData1.map((item) => DailyInfoModel.fromJson(item)).toList();

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dailyDatas.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          MiniInformationWidget(dailyData: dailyDatas[index]),
    );
  }
}