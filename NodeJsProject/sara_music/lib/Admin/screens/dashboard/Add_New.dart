import 'dart:convert';
import 'package:path/path.dart' as Path;
import 'dart:io' as file;
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:sara_music/Admin/screens/home/home_screen.dart';
import 'package:sara_music/authi/IntroPage.dart';
import 'package:shape_of_view_null_safe/generated/i18n.dart';
import 'package:toggle_bar/toggle_bar.dart';

import 'package:sara_music/responsive.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:sara_music/globalss.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  String? selectedValue;
  List<String> items = [];
  List<String> labels = ["Teacher", "Student" , "Course" ,"Instrument"];
  int currentIndex = 0;
  int value = 0;
  TextEditingController dateinput = TextEditingController();
  TextEditingController PhoneN = TextEditingController();
  TextEditingController UserName = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Emaill= TextEditingController();
  TextEditingController Salaryy= TextEditingController();

  TextEditingController phonenum = TextEditingController();
  TextEditingController SN = TextEditingController();
  TextEditingController SP = TextEditingController();
  TextEditingController SE= TextEditingController();
    TextEditingController SA= TextEditingController();

        TextEditingController Pricee= TextEditingController();
    TextEditingController CourseName= TextEditingController();
    TextEditingController Des= TextEditingController();

          TextEditingController InstrumentPrice= TextEditingController();
    TextEditingController InstrumentName= TextEditingController();
    TextEditingController InstrumentDes= TextEditingController();
        TextEditingController InstrumentQuantity= TextEditingController();



  String Instrument = "";

  @override
  var count ="0";
  var courses="";
  var arrC;
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
  if(int.parse(count)!=0){
return  await count;
  }
}

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
      items.add(arrC[i]);

}
      }
      }catch(e){
        print(e);
      }

return await [items];
}
late Future Countt;
late Future CourseNamee;
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
    Countt=CoursesCount();
    CourseNamee=CoursesName();
  }

  TextEditingController Date = TextEditingController();
  TextEditingController Gendeer = TextEditingController();

  Widget CustomRadioButton(
      String text, int index, TextEditingController Gendeer) {       
   return OutlineButton(
      hoverColor: Colors.pink,
      onPressed: () {
        Gendeer.text = text;
        setState(() {
          value = index;

          TextFormField(
            controller: Gendeer,
          );
        });
      },
      padding: EdgeInsets.all(15),
      child: Text(
        text,
        style: TextStyle(
          color: (value == index)
              ? Color.fromARGB(255, 12, 51, 113)
              : Colors.black,
          fontWeight:  (value == index)
              ? FontWeight.bold
              : FontWeight.normal,   
          fontSize:  (value == index)?15:14,    
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),     
      borderSide: BorderSide(
          color: (value == index)
              ? Color.fromARGB(255, 12, 51, 113) 
              : Colors.black),
              
    );
  }

  late file.File imagepicker;

  Future getImageFromGallery() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagepicker = file.File(image.path);
    });
  }

  @override
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
              SizedBox(
                width: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: InkWell(
                  child: Image.asset(
                    'images/icons-close.jpg',
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
                  'Add New',
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
            backgroundColor: Color.fromARGB(255, 154, 173, 175),
            selectedTabColor: Color.fromARGB(255, 12, 51, 113),
            onSelectionUpdated: (index) => setState(() => currentIndex = index),
          ),
          SizedBox(
            height: 10,
          ),
         if( currentIndex == 0)
               FadeInDown(
                  delay: Duration(microseconds: 500),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: UserName,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Username",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: Emaill,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Email",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 5),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: Password,
                                  decoration: InputDecoration(
                                    
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Password",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  cursorColor: Color(0xFFcb1772),
                                  controller: dateinput,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Enter Date",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(3000));

                                    if (pickedDate != null) {
                                      print(pickedDate);
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(formattedDate);

                                      setState(() {
                                        dateinput.text = formattedDate;
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: Salaryy,
                                  decoration: InputDecoration(
                                    
                                    prefixIcon: Icon(
                                      FontAwesome.dollar,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Salary",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Waitforme(),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 75, top: 5),
                                  height: 45,
                                  child: Row(                                  
                                    children: [
                                      CustomRadioButton("Male", 1, Gendeer),
                                      SizedBox(width: 30,),
                                      CustomRadioButton("Female", 2, Gendeer),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Stack(
                                  children: [
                                  if(currentIndex==0)
                                    
                                    InternationalPhoneNumberInput(
                                      
                                      
                                      inputDecoration: InputDecoration(
                                        
                                        prefixIcon: Icon(
                                          FontAwesome.phone,
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                        ),
                                        
                                        labelText: "Phone number",
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
                                      cursorColor:
                                          Color.fromARGB(255, 12, 51, 113),
                                      textFieldController: phonenum,
                                      onInputChanged: (PhoneNumber number) {
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: ElevatedButton(
                                    child: Text("ADD"),
                                    onPressed: () {
                                      AddTeacher(context);

                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(150, 40),
                                      primary: Color.fromARGB(255, 12, 51, 113),
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if( currentIndex == 1)
               FadeInDown(
                  delay: Duration(microseconds: 500),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: SN,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Username",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: SE,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Email",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 5),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller:SP,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Password",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  cursorColor: Color(0xFFcb1772),
                                  controller: dateinput,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Enter Date",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(3000));

                                    if (pickedDate != null) {
                                      print(pickedDate);
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(formattedDate);

                                      setState(() {
                                        dateinput.text = formattedDate;
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // TextFormField(
                                //   controller: SA,
                                //   decoration: InputDecoration(
                                //     prefixIcon: Icon(
                                //       FontAwesome.address_book,
                                //       color: Color.fromARGB(255, 12, 51, 113),
                                //     ),
                                //     labelText: "Address",
                                //     enabledBorder: UnderlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: Colors.grey, width: 4),
                                //     ),
                                //     focusedBorder: UnderlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color:
                                //               Color.fromARGB(255, 12, 51, 113),
                                //           width: 5),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 75, top: 5),
                                  height: 45,
                                  child: Row(                                  
                                    children: [
                                      CustomRadioButton("Male", 1, Gendeer),
                                      SizedBox(width: 30,),
                                      CustomRadioButton("Female", 2, Gendeer),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Stack(
                                  children: [
                                    if(currentIndex==1)
                                    InternationalPhoneNumberInput(
                                      inputDecoration: InputDecoration(
                                        prefixIcon: Icon(
                                          FontAwesome.phone,
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                        ),
                                        labelText: "Phone number",
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
                                      cursorColor:
                                          Color.fromARGB(255, 12, 51, 113),
                                      textFieldController: phonenum,
                                     
                                      onInputChanged: (PhoneNumber number3) {
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: ElevatedButton(
                                    child: Text("ADD"),
                                    onPressed: () {
                                      AddStudent(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(150, 40),
                                      primary: Color.fromARGB(255, 12, 51, 113),
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if(currentIndex==3) 
              FadeInDown(
                  delay: Duration(microseconds: 500),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: InstrumentName,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesome.music,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Instrument name",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: InstrumentQuantity,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesome.shopping_cart,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Quantity",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: InstrumentPrice,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesome.dollar,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Price",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    getImageFromGallery();
                                  },
                                  child: TextFormField(
                                   
                                    enabled: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        FontAwesome.photo,
                                        color: Color.fromARGB(255, 12, 51, 113),
                                      ),
                                      labelText: "Images",
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 4),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                   controller: InstrumentDes,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesome.sticky_note_o,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Description",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: ElevatedButton(
                                    child: Text("ADD"),
                                    onPressed: () {
                                      Upload1(imagepicker);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(150, 40),
                                      primary: Color.fromARGB(255, 12, 51, 113),
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if(currentIndex==2)
                 FadeInDown(
                  delay: Duration(microseconds: 500),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: CourseName,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesome.music,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Course name",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),                            
                                TextFormField(
                                  controller: Pricee,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesome.dollar,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Price",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    getImageFromGallery();
                                  },
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        FontAwesome.photo,
                                        color: Color.fromARGB(255, 12, 51, 113),
                                      ),
                                      labelText: "Image",
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 4),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: Des,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      FontAwesome.sticky_note_o,
                                      color: Color.fromARGB(255, 12, 51, 113),
                                    ),
                                    labelText: "Description",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 4),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 12, 51, 113),
                                          width: 5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: ElevatedButton(
                                    child: Text("ADD"),
                                    onPressed: () {
                           Upload(imagepicker);

                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(150, 40),
                                      primary: Color.fromARGB(255, 12, 51, 113),
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.all(10),
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ]))));
        
  }
   void _displayErrorMotionToas(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Course Exist!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToas1() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('New Course Added Succefully :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToas2(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This instrument already exist!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
     void _displayErrorMotionToas3() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('New Instrument Added to the shop Succefully :)'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  
  void _displayErrorMotionToast1(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Invalid Email'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast2(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Password Must Be Matched!'),
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
      description: Text('Invalid Phone Number!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  void _displayErrorMotionToast7(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('User name length > 4'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToastt1(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This email is already used by other users!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToastt2(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Phone-number is already used by other users!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
     void _displayErrorMotionToast10(BuildContext context) {
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Password Must Be > 7'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
     
       void _displayErrorMotionToast4(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This User name is already used!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast5(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Phone number is already used!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToast6(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Email is already used!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Fill All the Fields!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast8(BuildContext context) {
    MotionToast.success(
      title: Text(
        "New User inserted ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Success!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  void _displayErrorMotionToast13(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Phone-Number must be above or equal to 10 numbers'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
    void _displayErrorMotionToastt(BuildContext context) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This name is already used by other users!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  Future AddTeacher(BuildContext context) async{
  var body1 = jsonEncode({
  'name':UserName.text,
  'email': Emaill.text,
  'birthday':dateinput.text,
  'Salary': Salaryy.text,
  'password': Password.text,
  'Phone': phonenum.text,
  'Gender':Gendeer.text
  

  });
   var body2 = jsonEncode({
  "instrument":Instrument.toString(),
  

  });
   var res= await http.post(Uri.parse(globalss.IP+"/teachers"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  } ,body: body1);


    if(Gendeer.text.isNotEmpty&& phonenum.text.isNotEmpty&&UserName.text.isNotEmpty && Emaill.text.isNotEmpty && dateinput.text.isNotEmpty && Password.text.isNotEmpty){
      

         if(!(Emaill.text.contains(RegExp(r'[@]'))&&Emaill.text.contains('.com'))){
           return _displayErrorMotionToast1(context);
        
                                       


        }
        else if(phonenum.text.contains(RegExp(r'[A-Za-z]'))){
         return _displayErrorMotionToast3(context);
          
                    

        }
        else if(phonenum.text.contains(RegExp(r'[`!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?~]'))){
       
                return _displayErrorMotionToast3(context);

        }
        
       

           if(res.body=="Nooo"){
                       return _displayErrorMotionToastt(context);

           }
               if(res.body=="Nooo1"){
                       return _displayErrorMotionToastt1(context);

           }
               if(res.body=="Nooo2"){
                       return _displayErrorMotionToastt2(context);

           }
         if(res.body=="UserMin"){
          return _displayErrorMotionToast7(context);
          
         }
           if(res.body=="PhoneN"){
          return _displayErrorMotionToast13(context);
           }
            
              if(res.body=="PASS"){
          return _displayErrorMotionToast10(context);
           }
     
              
      print("Code:${res.statusCode}");
      if (res.statusCode == 201) {
               Map<String, dynamic> DB = jsonDecode(res.body);

        globalss.SignPage = 1;
        globalss.authToken = DB['token'];
 var res1= await http.post(Uri.parse(globalss.IP+"/taskss"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 

 
 
 
 },body: body2 );
  print(res1.statusCode);
        String responseString = res.body;
        print("Response String: " + responseString);
        
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            
            );
            _displayErrorMotionToast8(context);

      }     
 
    }
 else{
            _displayErrorMotionToast(context);

}
  }

   Future<void> AddStudent(BuildContext context) async{
   

      var body1 = jsonEncode({
  'name': SN.text,
  'email': SE.text,
  'birthday': dateinput.text,
  'password': SP.text,
  'Phone': phonenum.text,
  'Gender': Gendeer.text
     });
              
    var res= await http.post(Uri.parse(globalss.IP+"/users"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  } ,body: body1);


  
    if(Gendeer.text.isNotEmpty&&phonenum.text.isNotEmpty&&SN.text.isNotEmpty && SE.text.isNotEmpty && dateinput.text.isNotEmpty && SP.text.isNotEmpty){
      
      
         if(!(SE.text.contains(RegExp(r'[@]'))&&SE.text.contains('.com'))){
           return _displayErrorMotionToast1(context);
        
                                       


        }
        else if(phonenum.text.contains(RegExp(r'[A-Za-z]'))){
         return _displayErrorMotionToast3(context);
          
                    

        }
        else    if(phonenum.text.contains(RegExp(r'[`!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?~]'))){
       
                return _displayErrorMotionToast3(context);

        }
        
       
               if(res.body=="Nooo"){
                       return _displayErrorMotionToastt(context);

           }
               if(res.body=="Nooo1"){
                       return _displayErrorMotionToastt1(context);

           }
               if(res.body=="Nooo2"){
                       return _displayErrorMotionToastt2(context);

           }
         if(res.body=="UserMin"){
          return _displayErrorMotionToast7(context);
          
         }
           if(res.body=="PhoneN"){
          return _displayErrorMotionToast13(context);
           }
            
              if(res.body=="PASS"){
          return _displayErrorMotionToast10(context);
           }
      
              
      print("Code:${res.statusCode}");
      if (res.statusCode == 201) {
               Map<String, dynamic> DB = jsonDecode(res.body);

        globalss.SignPage = 1;
        globalss.authToken = DB['token'];
 var res1= await http.post(Uri.parse(globalss.IP+"/tasks"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 

 
 
 
 } );
  print(res1.statusCode);
        String responseString = res.body;
        print("Response String: " + responseString);
        
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            
            );
            _displayErrorMotionToast8(context);

      }     
 
    }
 else{
            _displayErrorMotionToast(context);

}
  }
 Future Upload(File imageFile) async {  
   try{
   var body1 = jsonEncode({
     'name':CourseName.text,
     'Price':Pricee.text,
     'Description':Des.text
   });

  var stream  = new http.ByteStream(imageFile.openRead());
stream.cast();
      var length = await imageFile.length();

      var uri = Uri.parse(globalss.IP+"/Courses");

     var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile('upload', stream, length,
          filename: Path.basename(imageFile.path));
          Map<String, String> headers = {
             'Content-Type': 'application/json; charset=UTF-8',
          };
         
          
                      request.headers["token"]=globalss.authToken;
                      request.headers["Content-Type"]='application/json; charset=UTF-8';
                         request.fields['name']=CourseName.text;
                         request.fields['Price']=Pricee.text;
                         request.fields['Description']=Des.text;

request.headers.addAll(headers);
  
      request.files.add(multipartFile);
     var response = await request.send();
    if(response.statusCode==400){
              _displayErrorMotionToas(context);
              return;

    }
         

      if(response.statusCode==201){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            
            );
                    _displayErrorMotionToas1();

      }
      
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
   }catch(e){
     print(e);
   }
      
    }
     Future Upload1(File imageFile) async {  
   var body1 = jsonEncode({
     'name':InstrumentName.text,
     'Price':InstrumentPrice.text,
     'Description':InstrumentDes.text,
     'Quantity':InstrumentQuantity.text
   });
  var stream  = new http.ByteStream(imageFile.openRead());
stream.cast();
      var length = await imageFile.length();

      var uri = Uri.parse(globalss.IP+"/Instruments");

     var request = new http.MultipartRequest("POST", uri,);

      var multipartFile = new http.MultipartFile('upload', stream, length,
          filename: Path.basename(imageFile.path));
          Map<String, String> headers = {
             'Content-Type': 'application/json; charset=UTF-8',
          };
                      request.headers["token"]=globalss.authToken;
                      request.headers["Content-Type"]='application/json; charset=UTF-8';
                         request.fields['name']=InstrumentName.text;
                         request.fields['Price']=InstrumentPrice.text;
                         request.fields['Description']=InstrumentDes.text;
                            request.fields['Quantity']=InstrumentQuantity.text;

request.headers.addAll(headers);

      request.files.add(multipartFile);
      var response = await request.send();
      if(response.statusCode==400){
                _displayErrorMotionToas2(context);

      }
      if(response.statusCode==201){

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            
            );
                            _displayErrorMotionToas3();

      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }





    Widget Waitforme() {
  
  return FutureBuilder( future: Countt, builder:((context, snapshot)  {

      return snapshot.data==null||snapshot.data==""?  Center(child: CircularProgressIndicator()): 
      Container(
                                  width: double.maxFinite,
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
                                              'Select Course',
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
                                          selectedValue = value as String;
                                          Instrument = selectedValue.toString();
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
                                        color:
                                            Color.fromARGB(255, 231, 241, 241),
                                      ),
                                      buttonElevation: 2,
                                      itemHeight: 40,                                    
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 14),
                                      dropdownMaxHeight: 200,
                                      dropdownWidth:390,
                                      dropdownPadding: null,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color:
                                            Color.fromARGB(255, 231, 241, 241),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius:
                                          const Radius.circular(40),
                                      scrollbarThickness: 6,
                                      scrollbarAlwaysShow: true,
                                      offset: const Offset(-20, 0),
                                    ),
                                  ),
                                );


  }));
}
  
}