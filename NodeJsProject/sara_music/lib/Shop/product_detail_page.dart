
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'cart_page.dart';
import 'colors.dart';

import 'product_slider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sara_music/globalss.dart';
import 'dart:convert';
import 'dart:io';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cart_page.dart';

import 'dart:io' as file;
import 'package:path/path.dart' as Path;
import 'colors.dart';
import 'product_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sara_music/globalss.dart';


class ProductDetailPage extends StatefulWidget {
  final String id;
  final String name;
  final String img;
  final String price;
  final String image;
  final List size;
  
  const ProductDetailPage(
      {Key? key,
      required this.id,
      required this.name,
      required this.img,
      required this.price,
      required this.image,
      required this.size})
      : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
   
  int _currentIntValue = 0;
  int activeSize = 0;
  bool fav_bool = false;
  late Future Q;

var quantityvalue="";
Future getQuantity() async{

var body1=jsonEncode({
'CartName':globalss.InstrumentsName,

 });
 var res= await http.post(Uri.parse(globalss.IP+"/Instruments/QunatityValue"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);
if(mounted){
  if(res.statusCode==200){
        quantityvalue = res.body;
  
  }

  }
return await quantityvalue;
  }

   Future sendData(int quantity) async{

var P = globalss.InstrumentsPrice.toString();
var arr= P.split("\$");

var body1=jsonEncode({
"Name": globalss.StudentName,
'CartPrice':arr[0].toString(),
'CartName':globalss.InstrumentsName,
'CartQuantity':quantity.toString(),
'CartImage':globalss.InstrumentsImage
 });
 var res= await http.post(Uri.parse(globalss.IP+"/tasks/data"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + globalss.authToken 

  }, body: body1);
if(mounted){
  if(res.statusCode==200){
       Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
   _displayErrorMotionToast4();
  }

  }
if(res.statusCode==400){
    if(res.body=="NO"){
 _displayErrorMotionToast();
    }
     else if(res.body=="Over"){
_displayErrorMotionToast2();
    }
    else {
      _displayErrorMotionToast1();
    }
  }
  }
 void _displayErrorMotionToast4() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("Please confirm your purchase"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }

 void _displayErrorMotionToast2() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("The quantity you're trying to order is over the specified quantity!"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast1() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This instrument is out of sale, looking forward to update the quantity!'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
   void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text("Sorry but '0' quantity is not allowed"),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
  @override
    void initState() {
    super.initState();
    Q = getQuantity();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Waitforme()
      
    );
  }
   Widget Waitforme() {
  
    
  return FutureBuilder(future: Future.wait([Q]), builder:((context, snapshot)  {
      return snapshot.data==null?  Center(child: CircularProgressIndicator()):
      Column(
        children: <Widget>[
          SizedBox(
            height: 35,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: black.withOpacity(0.1),
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 231, 241, 241),
            ),
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                FadeInDown(
                  child: Padding(
                    padding: EdgeInsets.only(left: 80,top: 50,right: 50,bottom: 50),
                    child: Image(image:
                              MemoryImage(base64Decode("${globalss.InstrumentsImage}")),fit:BoxFit.fill,
                  
                              ),
                  )
                ),
                Positioned(
                  
                  top: 30,
                  left: 10,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: black,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),          
          FadeInDown(
            delay: Duration(milliseconds: 350),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
"${(globalss.InstrumentsName)}",
                    style: TextStyle(
                        fontSize: 35, fontWeight: FontWeight.w600, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
             Padding(
              padding: const EdgeInsets.only(left: 25, right: 25,top: 10),
              child: Text(
"${(globalss.InstrumentsPrice)}",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w500, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
             ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
         
          FadeInDown(
            delay: Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
"${(globalss.InstrumentsDes1)}",
              style: TextStyle(
                    fontSize: 18,color: Color.fromARGB(255, 71, 68, 68)),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
           FadeInDown(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove,color: Colors.red,),
                  onPressed: () => setState(() {
                    final newValue = _currentIntValue - 1;
                    _currentIntValue = newValue.clamp(0, 100);


                    
                  }),
                ),
                Text(
                  'Number of items:  $_currentIntValue',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add,color: Colors.red,),
                  onPressed: () => setState(() {
                    final newValue = _currentIntValue + 1;
                    _currentIntValue = newValue.clamp(0, 100);
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FadeInDown(
            
            delay: Duration(milliseconds: 550),
            child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: <Widget>[
                  Text("Amount: ${quantityvalue}"),
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             spreadRadius: 0.5,
                  //             blurRadius: 1,
                  //             color: black.withOpacity(0.1))
                  //       ],
                  //       color: grey),
                  //   child: Center(
                  //       child: IconButton(
                  //     icon: fav_bool? Icon(FontAwesomeIcons.solidHeart,color: Colors.red,):Icon(FontAwesomeIcons.heart),
                  //     onPressed: () {
                  //       setState(() {
                  //         fav_bool = !fav_bool;
                  //       });
                  //     },
                  //   )),
                  // ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.pink[600],
                          onPressed: () {
                            
                                     sendData(_currentIntValue);
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                "ADD TO CART",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
        ],
      );
   
  }));
}
}