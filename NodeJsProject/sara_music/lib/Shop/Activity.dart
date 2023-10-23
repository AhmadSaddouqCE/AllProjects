
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sara_music/Shop/product_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sara_music/Shop/Shop.dart';
import 'package:sara_music/Shop/colors.dart';
import 'package:sara_music/globalss.dart';


class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  var count="0";
  late Future COUNT;
  late Future PRICE;
  late Future IMAGE;
  late Future QUANTITY;
  late Future NAME;
    Future CartCount() async{
try{
   var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentCartDoneCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization': 'Bearer ' + globalss.authToken 


  });
  if(res.statusCode==200){
    count=res.body;
  
  }
  }catch(e){
    print(e);
  }
return  await count;
  
}

var name="";
var arr;
var NameCart=[];
 Future  CartName() async{
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentCartDoneName"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

  if(res.statusCode==200){
     name=res.body;
     
    }
   
  
    var NAME5 = name.toString();
 
    arr = NAME5.split(",");
   
    for(int i = 0; i<int.parse(count);i++){
      NameCart.add(arr[i]);
    }
    
   
    } catch(e){
      print(e);
    }
     
        return await NameCart;

  }
var quantity2="";
var arr1;
var QuantityList=[];
 Future  CartQuantity() async{
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentCartDoneQuantity"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

  if(res.statusCode==200){
     quantity2=res.body;
     
    }
   
  
    var quantity25 = quantity2.toString();
 
    arr1 = quantity25.split(",");
   
    for(int i = 0; i<int.parse(count);i++){
      QuantityList.add(arr1[i]);
    }
    
   
    } catch(e){
      print(e);
    }
     
        return await QuantityList;

  }

var image2="";
var arr3;
var ImageList=[];
  Future  CartImage() async{
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentCartDoneImage"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

  if(res.statusCode==200){
     image2=res.body;
     
    }
   
  
    var image25 = image2.toString();
 
    arr3 = image25 .split(",");
   
    for(int i = 0; i<int.parse(count);i++){
      ImageList.add(arr3[i]);
    }
    
   
    } catch(e){
      print(e);
    }
     
        return await ImageList;

  }
var price2="";
var arr4;
var PriceList=[];
  Future  CartPrice() async{
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/StudentCartDonePrice"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

  if(res.statusCode==200){
     price2=res.body;
     
    }
   
  
    var price25 = price2.toString();
 
    arr4= price25 .split(",");
   
    for(int i = 0; i<int.parse(count);i++){
      PriceList.add(arr4[i]);
    }
    
   
    } catch(e){
      print(e);
    }
     
        return await PriceList;

  }
  late Future all;
  Future CartAll() async{
   await CartCount();
   await CartName();
   await CartPrice();
   await CartQuantity();
   await CartPrice();

  }
      
      void initState(){
        super.initState();
        COUNT = CartCount();
        NAME = CartName();
        PRICE=CartPrice();
        QUANTITY = CartQuantity();
        IMAGE = CartImage();
        all = CartAll();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
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
                  Navigator.pop(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.topCenter,
                      child: Shop(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
              child: Text(
                'Acivity',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
       Waitforme1()
      ],
    ));
  }

  Widget Waitforme1() {
  return FutureBuilder(future:Future.wait<dynamic>([all]), builder:((context,AsyncSnapshot snapshot)  {
   if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
                          return Center(child: CircularProgressIndicator());

         }
    return  Column(
          children: List.generate(int.parse(count),(index) {
            return FadeInDown(
              duration: Duration(milliseconds: 345 * index),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 231, 241, 241),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0.5,
                                color: black.withOpacity(0.1),
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 25, right: 25, bottom: 25),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 140,
                                height: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            MemoryImage(base64Decode("${ImageList[index]}")),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${NameCart[index]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                RemoveCart(NameCart[index]);
                              },
                              child: Icon(Icons.cancel,size: 20,color: Colors.red,)
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "\$ " + "${PriceList[index]}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${QuantityList[index]}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            );
          }),
        ); 
  }));
}


   Future<void> RemoveCart(var name) async{
   

      var body1 = jsonEncode({
  'name': name.toString(),
 

     });
              
    var res= await http.post(Uri.parse(globalss.IP+"/tasks/RemoveOneCart"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globalss.authToken 
  },body: body1);
  
 if(mounted){
   if(res.statusCode==200){
     _displayErrorMotionToast();
     return;
   }
 }
    }
        void _displayErrorMotionToast() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Removed From List.'),
      animationType: ANIMATION.fromLeft,
      position: MOTION_TOAST_POSITION.top,
      width: 300,
    ).show(context);
  }
}
