
// import 'package:sara_music/Admin/models/recent_user_model.dart';
// import 'package:sara_music/Admin/core/utils/colorful_tag.dart';
// import 'package:sara_music/Admin/core/constants/color_constants.dart';
// import 'package:colorize_text_avatar/colorize_text_avatar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sara_music/globalss.dart';


// class RecentUsers extends StatefulWidget {
//   const RecentUsers({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<RecentUsers> createState() => _RecentUsersState();
// }

// class _RecentUsersState extends State<RecentUsers> {
// List recentUsers1=[];
// var  Count="0";
// Future StudentsCount() async{
// var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentsCount"),headers: {
//       'Content-Type': 'application/json; charset=UTF-8',

//   });

// if(res.statusCode==200) {
//   setState(() {
//     Count = res.body;
//   });

// }
// return await Count;
//   }


// var Name="";
// var arr;
// var NameList=[];
//   Future StudentName() async{
// var res= await http.get(Uri.parse(globalss.IP+"/tasks/Names"),headers: {
//       'Content-Type': 'application/json; charset=UTF-8',

//   });

// if(res.statusCode==200) {
//   setState(() {
//     Name = res.body;
//   });

// }

//     var Name1 = Name.toString();
//       arr=Name1.split(",");
//       for(int i = 0; i<int.parse(Count);i++){
//       NameList.add(arr[i]);

// }
// return await NameList;
//   }

//   //
// var InstrumentName="";
// var arrI;
// var InstrumentsList=[];
//   Future StudentInstrument() async{
// var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentInstrument"),headers: {
//       'Content-Type': 'application/json; charset=UTF-8',

//   });

// if(res.statusCode==200) {
//   setState(() {
//     InstrumentName= res.body;
//   });

// }

//     var InstrumentName1 = InstrumentName.toString();
//       arrI=InstrumentName1.split(",");
//       for(int i = 0; i<int.parse(Count);i++){
//       InstrumentsList.add(arrI[i]);

// }
// return await InstrumentsList;
//   }


//   //


//   //
// var Email="";
// var arrE;
// var EmailsList=[];
//   Future StudentEmail() async{
// var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentEmail"),headers: {
//       'Content-Type': 'application/json; charset=UTF-8',

//   });

// if(res.statusCode==200) {
//   setState(() {
//     Email= res.body;
//   });

// }

//     var Email1 = Email.toString();
//       arrE=Email1.split(",");
//       for(int i = 0; i<int.parse(Count);i++){
//       EmailsList.add(arrE[i]);

// }
// return await EmailsList;
//   }

//   //


//   var Ratings="";
// var arrR;
// var RatingsList=[];
//   Future StudentRating() async{
// var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentRatring"),headers: {
//       'Content-Type': 'application/json; charset=UTF-8',

//   });

// if(res.statusCode==200) {
//   setState(() {
//     Ratings= res.body;
//   });

// }

//     var Ratings1 = Ratings.toString();
//       arrR=Ratings1.split(",");
//       for(int i = 0; i<int.parse(Count);i++){
//       RatingsList.add(arrR[i]);

// }

// for(int j =0;j<int.parse(Count);j++){

//    recentUsers1 = [
//   RecentUser(
//     icon: "images/icons/xd_file.svg",
//     name: NameList[j],
//     role: "${InstrumentsList[j]} Course",
//     email: EmailsList[j],
//     date: "12333",
//     posts: RatingsList[j],
//   ),
// ];
// }


// return await RatingsList;
//   }

//   //
    
//   late Future c;
//   late Future N;
//   late Future R;
//   late Future I;
//   late Future E;

//   @override

//     void initState(){
//     super.initState(); 
//     c= StudentsCount();
//     N=StudentName();
//     I=StudentInstrument();
//     E=StudentEmail();
//     R=StudentRating();
//      }
//   Widget build(BuildContext context) {
//     print("123");
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Recent Candidates",
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SizedBox(
//               width: double.infinity,
//               child: DataTable(
//                 horizontalMargin: 0,
//                 columnSpacing: defaultPadding,
//                 columns: [
//                   DataColumn(
//                     label: Text("Name Surname"),
//                   ),
//                   DataColumn(
//                     label: Text("Applied Position"),
//                   ),
//                   DataColumn(
//                     label: Text("E-mail"),
//                   ),
//                   DataColumn(
//                     label: Text("Registration Date"),
//                   ),
//                   DataColumn(
//                     label: Text("Status"),
//                   ),
//                   DataColumn(
//                     label: Text("Operation"),
//                   ),
//                 ],
//                 rows: List.generate(
//                   recentUsers1.length,
//                   (index) => recentUserDataRow(recentUsers1[index], context),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
// }


// DataRow recentUserDataRow(RecentUser userInfo, BuildContext context) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             TextAvatar(
//               size: 35,
//               backgroundColor: Colors.white,
//               textColor: Colors.white,
//               fontSize: 14,
//               upperCase: true,
//               numberLetters: 1,
//               shape: Shape.Rectangle,
//               text: userInfo.name!,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(
//                 userInfo.name!,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Container(
//           padding: EdgeInsets.all(5),
//           decoration: BoxDecoration(
//             color: getRoleColor(userInfo.role).withOpacity(.2),
//             border: Border.all(color: getRoleColor(userInfo.role)),
//             borderRadius: BorderRadius.all(Radius.circular(5.0) //
//                 ),
//           ),
//           child: Text(userInfo.role!))),
//       DataCell(Text(userInfo.email!)),
//       DataCell(Text(userInfo.date!)),
//       DataCell(Text(userInfo.posts!)),
//       DataCell(
//         Row(
//           children: [
//             TextButton(
//               child: Text('View', style: TextStyle(color: greenColor)),
//               onPressed: () {},
//             ),
//             SizedBox(
//               width: 6,
//             ),
//             TextButton(
//               child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
//               onPressed: () {
               
//                 showDialog(
//                     context: context,
//                     builder: (_) {
//                       return AlertDialog(
//                           title: Center(
//                             child: Column(
//                               children: [
//                                 Icon(Icons.warning_outlined,
//                                     size: 36, color: Colors.red),
//                                 SizedBox(height: 20),
//                                 Text("Confirm Deletion"),
//                               ],
//                             ),
//                           ),
//                           content: Container(
//                             color: secondaryColor,
//                             height: 70,
//                             child: Column(
//                               children: [
//                                 Text(
//                                     "Are you sure want to delete '${userInfo.name}'?"),
//                                 SizedBox(
//                                   height: 16,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     ElevatedButton.icon(
//                                         icon: Icon(
//                                           Icons.close,
//                                           size: 14,
//                                         ),
//                                         style: ElevatedButton.styleFrom(
//                                             primary: Colors.grey),
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         label: Text("Cancel")),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     ElevatedButton.icon(
//                                         icon: Icon(
//                                           Icons.delete,
//                                           size: 14,
//                                         ),
//                                         style: ElevatedButton.styleFrom(
//                                             primary: Colors.red),
//                                         onPressed: () {},
//                                         label: Text("Delete"))
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ));
//                     });
//               },
//               // Delete
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
