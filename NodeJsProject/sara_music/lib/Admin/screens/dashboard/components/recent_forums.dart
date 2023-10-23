import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/utils/colorful_tag.dart';
import '../../../models/recent_user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';
import 'package:intl/intl.dart';

import '../../home/home_screen.dart';

class RecentDiscussions extends StatefulWidget {
  const RecentDiscussions({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentDiscussions> createState() => _RecentDiscussionsState();
}

class _RecentDiscussionsState extends State<RecentDiscussions> {
    String? selectedValue;
  List<String> items = [
    'Description',
    'Price',
  ];
  @override
    var Name;
   late Future N;
  late Future C;
  late Future P;
  TextEditingController Dec = TextEditingController();
  late Future All;
  var arr;
  var CourseNameList=[];
  var Count="0";
  List <dynamic>recentUsers4 = [ ];


Future DeleteThisCourse(var name) async{
var body1 = jsonEncode({
 "name":name.toString(),


});
var res= await http.post(Uri.parse(globalss.IP+"/Courses/DeleteCourse"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(mounted){
  if(res.statusCode==200){
      _displayErrorMotionT(context);
  }
  else{

 _displayErrorMotionT1(context);

  }
}
}


Future ChangePrice(var name,var Des) async{
var body1 = jsonEncode({
 "name":name.toString(),
"Price":Des.toString() 


});
var res= await http.post(Uri.parse(globalss.IP+"/Courses/ChangePrice"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(mounted){
  if(res.statusCode==200){
     Navigator.pushAndRemoveUntil(
  			context,
  			MaterialPageRoute(builder: (context) => HomeScreen()), // this mymainpage is your page to refresh
  			(Route<dynamic> route) => false,
		);
      _displayErrorMotionToast(context);
  }
  else{

 _displayErrorMotionToast12(context);

  }
}
}


Future ChangeDes(var name,var Des) async{
var body1 = jsonEncode({
 "name":name.toString(),
"Description":Des.toString() 


});
var res= await http.post(Uri.parse(globalss.IP+"/Courses/ChangeDes"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(mounted){
  if(res.statusCode==200){
     Navigator.pushAndRemoveUntil(
  			context,
  			MaterialPageRoute(builder: (context) => HomeScreen()), // this mymainpage is your page to refresh
  			(Route<dynamic> route) => false,
		);
      _displayErrorMotionToast13(context);
  }
  else{

 _displayErrorMotionToast12(context);

  }
}
}
  void _displayErrorMotionToast(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Sucess',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Course Price is updated :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  void _displayErrorMotionToast13(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Sucess',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Course Description is updated :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

 void _displayErrorMotionT(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Sucess',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Deleted Sucessfully:)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionT1(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("This course doesn't exist!"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast12(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("This course doesn't exsist!"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
Future CourseCount() async{
var res= await http.post(Uri.parse(globalss.IP+"/Courses/count"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
    if(res.statusCode==200){
 setState(() {
    Count = res.body;
  });   
   }
  }
    return await Count;
  }
  Future CourseName() async{
var res= await http.post(Uri.parse(globalss.IP+"/Courses/getName"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
if(res.statusCode==200) {
  setState(() {
    Name = res.body;
  });

}
}
    var Name1 = Name.toString();
      arr=Name1.split(",");
      for(int i = 0; i<int.parse(Count);i++){
       CourseNameList.add(arr[i]);

}
return await [CourseNameList];
  }
var Price="";
var arrP;
var CoursePriceList=[];
   Future CoursePrice() async{
var res= await http.post(Uri.parse(globalss.IP+"/Courses/price"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
if(res.statusCode==200) {
  setState(() {
    Price= res.body;
  });

}
}
    var Price1 = Price.toString();
      arrP=Price1.split(",");
      for(int i = 0; i<int.parse(Count);i++){
      CoursePriceList.add(arrP[i]);

}
return await [CoursePriceList];
  }
   Future WaitForAll()async{
await CourseCount();
await CourseName();
await CoursePrice();

   for(int j =0;j<int.parse(Count);j++){
  recentUsers4.addAll({
     RecentUser(
    icon: "images/icons/xd_file.svg",
    name: "0",
    role: "${CourseNameList[j]}",
    email: "123",
    posts: "${CoursePriceList[j]}"
  ),

    
  }
  );



}
return await [recentUsers4];

  }
  void initState() {
    super.initState();
      C=CourseCount();
     N=CourseName();
     P=CoursePrice();
     All=WaitForAll();
    selectedValue = items[0];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Waitforme1()
    );

    
  }
    Widget Waitforme1() {
        
  return FutureBuilder( future:Future.wait([C,N,P,All]), builder:((context,  snapshot)  {

    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }
         return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Open Positions",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Course Name"),
                    ),
                    DataColumn(
                      label: Text("Price"),
                    ),
                    // DataColumn(
                    //   label: Text("Total Students"),
                    // ),
                    DataColumn(
                          label: Text("Operation"),
                        ),
                  ],
                  rows: List.generate(
                    recentUsers4.length,
                    (index) => recentUserDataRow(recentUsers4[index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
      }));
  }

  DataRow recentUserDataRow(RecentUser userInfo) {
    return DataRow(
      cells: [
        DataCell(Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: getRoleColor(userInfo.role).withOpacity(.2),
              border: Border.all(color: getRoleColor(userInfo.role)),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
                  ),
            ),
            child: Text(userInfo.role!))),
        // DataCell(Text(userInfo.date!)),
        DataCell(Text(userInfo.posts!)),
        DataCell(
          Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.withOpacity(0.5),
                ),
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                             return StatefulBuilder(
                          builder: (BuildContext context, setState) {
                        return AlertDialog(
                            title: Center(
                              child: Text("Edit Courses Info"),
                            ),
                            content: Container(
                              color: secondaryColor,
                              height: 300,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: const [
                                            Icon(
                                              Icons.list,
                                              size: 22,
                                              color: Color.fromARGB(
                                                  255, 12, 51, 113),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Select',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 66, 66, 66),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: items
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value as String?;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor:
                                            Color.fromARGB(255, 12, 51, 113),
                                        iconDisabledColor: Colors.grey,
                                        buttonHeight: 60,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Color.fromARGB(
                                              255, 231, 241, 241),
                                        ),
                                        buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        dropdownMaxHeight: 200,
                                        dropdownWidth: 200,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Color.fromARGB(
                                              255, 231, 241, 241),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(-20, 0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Form(
                                      child: TextFormField(
                                        controller: Dec,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.data_array_outlined,
                                            color: Color.fromARGB(
                                                255, 12, 51, 113),
                                          ),
                                          labelText: "$selectedValue",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 4),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 12, 51, 113),
                                                width: 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.edit,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue),
                                          onPressed: () {
                                            if(selectedValue=="Description"){
                                              ChangeDes(userInfo.role,Dec.text);
                                            }
                                            else if(selectedValue=="Price"){
                                               ChangePrice(userInfo.role,Dec.text);
                                            }
                                            print(userInfo.role);
                                          },
                                          label: Text("Edit")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.close,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          label: Text("Cancel")),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            );
                            });
                      });
                },
                // edit
                label: Text("Edit"),
              ),
              SizedBox(
                width: 6,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.withOpacity(0.5),
                ),
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                            title: Center(
                              child: Text("Confirm Deletion"),
                            ),
                            content: Container(
                              color: secondaryColor,
                              height: 120,
                              child: Column(
                                children: [
                                  Text(
                                      "Are you sure want to delete '${userInfo.name}'?"),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.delete,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red),
                                          onPressed: () {
                                            DeleteThisCourse(userInfo.role);
                                          },
                                          label: Text("Delete")),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.close,
                                            size: 14,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          label: Text("Cancel")),
                                    ],
                                  )
                                ],
                              ),
                            ));
                      });
                },
                // Delete
                label: Text("Delete"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
