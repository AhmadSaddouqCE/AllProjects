import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:sara_music/Admin/models/recent_user_model.dart';
import 'package:sara_music/Admin/core/utils/colorful_tag.dart';
import 'package:sara_music/Admin/core/constants/color_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../core/constants/color_constants.dart';

import '../../../core/utils/colorful_tag.dart';
import '../../../models/recent_user_model.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';
import 'package:intl/intl.dart';

import '../../home/home_screen.dart';



class RecentShop extends StatefulWidget {
  const RecentShop({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentShop> createState() => _RecentShopState();
}




class _RecentShopState extends State<RecentShop> {
  var Name;
   late Future N;
  late Future P;
  late Future C;
  late Future Q;
  late Future All;
  TextEditingController A = TextEditingController();
  var arr;
  var InstrumentNameList=[];
  var Count="0";
  List <dynamic>recentUsers4 = [
  ];
Future DeleteThisInstrument(var name) async{
var body1 = jsonEncode({
 "name":name.toString(),


});
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/DeleteInstrument"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(mounted){
  if(res.statusCode==200){
     Navigator.pushAndRemoveUntil(
  			context,
  			MaterialPageRoute(builder: (context) => HomeScreen()), // this mymainpage is your page to refresh
  			(Route<dynamic> route) => false,
		);
      _displayErrorMotionT(context);
  }
  else{

 _displayErrorMotionT1(context);

  }
}
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
      description: Text("This Instrument doesn't exist!"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

 void _displayErrorMotionToast(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Sucess',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Instrument Quantity is updated :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast2(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Sucess',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Instrument Price is updated :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast3(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("Instrument doesn't exist"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

 void _displayErrorMotionToast4(BuildContext context) {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("Instrument Description updated sucessfully"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }



  //
Future ChangeDes(var name,var A) async{
var body1 = jsonEncode({
 "name":name.toString(),
"Description":A.toString() 


});
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/ChangeDes"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
 if(mounted){
  if(res.statusCode==200){
      _displayErrorMotionToast4(context);
  }
  else{

 _displayErrorMotionToast3(context);

  }
 }
}


  //
Future ChangeQuantity(var name,var A) async{
var body1 = jsonEncode({
 "name":name.toString(),
"Quantity":A.toString() 


});
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/ChangeQuantity"),headers: {
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

 _displayErrorMotionToast3(context);

  }
 }
}
Future ChangePrice(var name,var A) async{
var body1 = jsonEncode({
 "name":name.toString(),
"Price":A.toString() 


});
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/ChangePrice"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);
if(mounted){
  if(res.statusCode==200){
      _displayErrorMotionToast2(context);
  }
  else{

 _displayErrorMotionToast3(context);

  }
}
}

Future InstrumentCount() async{
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/count"),headers: {
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
  Future InstrumentName() async{
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/getName"),headers: {
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
      InstrumentNameList.add(arr[i]);

}
return await [InstrumentNameList];
  }

var Price="";
var arrP;
var InstrumentPriceList=[];
   Future InstrumentPrice() async{
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/price"),headers: {
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
      InstrumentPriceList.add(arrP[i]);

}
return await [InstrumentPriceList];
  }
  var Qauntity="";
  var arrQ;
  var InstrumentQuantityList=[];
   Future InstrumentQuantity() async{
var res= await http.post(Uri.parse(globalss.IP+"/Instruments/getQuantity"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
if(res.statusCode==200) {
  setState(() {
    Qauntity= res.body;
  });

}
}
    var Quantity1 = Qauntity.toString();
      arrQ=Quantity1.split(",");
      for(int i = 0; i<int.parse(Count);i++){
      InstrumentQuantityList.add(arrQ[i]);

}
return await [InstrumentQuantityList];
  }


  Future WaitForAll()async{
    if(mounted){
await InstrumentCount();
await InstrumentName();
await InstrumentPrice();
await InstrumentQuantity();

   for(int j =0;j<int.parse(Count);j++){
  recentUsers4.addAll({
     RecentUser(
    icon: "images/icons/xd_file.svg",
    name: "${InstrumentNameList[j]}",
    role: "${InstrumentQuantityList[j]}",
    email: "${InstrumentPriceList[j]}",
  ),

    
  }
  );



}
    }
return await [recentUsers4];

  }
 
 
  String? selectedValue;
  List<String> items = [
    'Quantity',
    'Price',
    'Description'
  ];
  @override


  @override
   void initState(){
    super.initState();
    C=InstrumentCount();
     N=InstrumentName();
     Q=InstrumentQuantity();
     P=InstrumentPrice();
     All=WaitForAll();
         selectedValue = items[0];


  }
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
        
  return FutureBuilder( future:Future.wait([C,N,Q,P,All]), builder:((context,  snapshot)  {

    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }
         return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shop",
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
                  showCheckboxColumn: true,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("instrument name"),
                    ),
                    // DataColumn(
                    //   label: Text("ID number"),
                    // ),
                    DataColumn(
                      label: Text("Quantity"),
                    ),
                    DataColumn(
                      label: Text("Price"),
                    ),
                    // DataColumn(
                    //   label: Text("Rate"),
                    // ),
                    DataColumn(
                      label: Text("Operation"),
                    ),
                  ],
                  rows: List.generate(
                    recentUsers4.length,
                    (index) => recentUserDataRow1(recentUsers4[index], context),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
      }));
  }

  DataRow recentUserDataRow1(RecentUser userInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              TextAvatar(
                size: 35,
                backgroundColor: Colors.white,
                textColor: Colors.white,
                fontSize: 14,
                upperCase: true,
                numberLetters: 1,
                shape: Shape.Rectangle,
                text: userInfo.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  userInfo.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: getRoleColor(userInfo.role).withOpacity(.2),
              border: Border.all(color: getRoleColor(userInfo.role)),
              borderRadius: BorderRadius.all(Radius.circular(5.0) //
                  ),
            ),
            child: Text(userInfo.role!))),
        DataCell(Text(userInfo.email!)),
        // DataCell(Text(userInfo.date!)),
        // DataCell(Text(userInfo.posts!)),
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
                              child: Text("Edit Store Info"),
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
                                        controller: A,
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
                                                 if(selectedValue=="Quantity"){
                                                       print(userInfo.name);
                                                     ChangeQuantity(userInfo.name,A.text);
                                                 }
                                                 else if(selectedValue=="Price"){
                                                          
                                                          ChangePrice(userInfo.name,A.text);


                                                 }
                                                 else if(selectedValue=="Description"){
                                                        ChangeDes(userInfo.name,A.text);

                                                      
                                                 }

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
                            ));
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
                                            DeleteThisInstrument(userInfo.name);
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
