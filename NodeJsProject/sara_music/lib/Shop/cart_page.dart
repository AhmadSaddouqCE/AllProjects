import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sara_music/Screens/Details_screen.dart';
import 'package:sara_music/Shop/Shop.dart';
import 'package:sara_music/Shop/product_detail_page.dart';
import 'product_data.dart';
import 'colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:sara_music/globalss.dart';



class CartPage extends StatefulWidget {
  @override
 
  
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
    Map<String, dynamic>? paymentIntentData;


  late Razorpay _razorpay;
 static const platform = const MethodChannel("razorpay_flutter");


  @override
  late Future count1;
  late Future NAME;
  late Future PRICE;
  late Future IMAGE;
  late Future QUANTITY;
  late Future totall;
  late Future all;
  var count="0";
  var arr;
  var arr1;
  var arr2;
  var arr3;
  var name="";
  var price="";
  var image="";
  var quantity="";
  var total=0;
  List NameCart=[];
  List PriceCart=[];
  List ImageCart=[];
  List QuantityCart=[];
    Future RemoveData(var name)async{
var body1=jsonEncode({
'CartName':name

 });

   var res= await http.post(Uri.parse(globalss.IP+"/tasks/RemoveCart"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ' + globalss.authToken 


  },body: body1);
  if(mounted){
    if(res.statusCode==200){
      _displayErrorMotionT2();


    }
    else{
      print("Choose Something");
    }
  }


  }

  void _displayErrorMotionT2() {
       
    MotionToast.success(
      title: Text(
        "Success",
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
  Future pay(var Pay,var price1,var quantity1,var image1) async{
   var body1 = jsonEncode({
     'CartName':Pay,
     'CartDonePrice':price1,
     'CartDoneQuantity':quantity1,
     'CartDoneImage':image1
   });
     var res= await http.post(Uri.parse(globalss.IP+"/tasks/CartDone"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 


  },body: body1);
  print(Pay.toString());
  print(res.statusCode);
  }
  Future CartCount() async{
try{
   var res= await http.get(Uri.parse(globalss.IP+"/tasks/getCount"),headers: {
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

//
 Future  CartName() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/getName"),headers: {
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


//


//

 Future  CartPrice() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/getPrice"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

  if(res.statusCode==200){
     price=res.body;
     
    }
   
  
    var NAME6 = price.toString();

    arr1 = NAME6.split(",");
  
    for(int i = 0; i<int.parse(count);i++){
      PriceCart.add(arr1[i]);
    }
      for(var j =0;j<int.parse(count);j++){
total+= int.parse(QuantityCart[j]) * int.parse(PriceCart[j]);

}
globalss.TOTALL=total.toString();

        return await [PriceCart,total];
   
    } catch(e){
      print(e);
    }

  

  }


//

//
 Future  CartQuantity() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/getQuantity"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

  if(res.statusCode==200){
     quantity=res.body;
     
    }
   
  
    var NAME7 = quantity.toString();
   
    arr2 = NAME7.split(",");

    for(int i = 0; i<int.parse(count);i++){
      QuantityCart.add(arr2[i]);
    }
    
   
    } catch(e){
      print(e);
    }
    
        return await QuantityCart;
 }
  
  
//
//


//
 Future  CartImage() async{
    
    try{
    var res= await http.get(Uri.parse(globalss.IP+"/tasks/getImage12"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + globalss.authToken 

  });

  if(res.statusCode==200){
     image=res.body;
     
    }
   
  
    var NAME8 = image.toString();
   
    arr3 = NAME8.split(",");

    for(int i = 0; i<int.parse(count);i++){
      ImageCart.add(arr3[i]);
    
    }
   
    } catch(e){
      print(e);
    }
    
        return await ImageCart;
 }
 Future CartAll() async{
   await CartCount();
   await CartName();
   await CartImage();
   await CartQuantity();
      await CartPrice();

 }
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
   
  
    all= CartAll();
  }
//
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
  

   void openCheckout() async {
     print(total);
    var options = {

      'key': "rzp_test_8xyYa69mP2tBT3",
   'amount': total*100, //in the smallest currency sub-unit.
  'name': '${globalss.StudentName}',
  'currency':"USD",
  'timeout': 600, // in seconds
  'prefill': {
    'contact': '',
    'email': '',
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      // debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    pay(name,price,quantity,image);

    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " + response.paymentId!,
    //     toastLength: Toast.LENGTH_SHORT); 
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    //  Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT); 
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    //  Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName!,
    //     toastLength: Toast.LENGTH_SHORT); 
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: getBody(),
    );
    
  }

  Widget getBody() {
    return Waitforme1();
  }
Widget Waitforme1() {
  return FutureBuilder(future:Future.wait<dynamic>([all]), builder:((context,AsyncSnapshot snapshot)  {
   if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
                          return Center(child: CircularProgressIndicator());

         }
    return ListView(
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
                  child: 
                  Text(

                    'My Cart',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                
              ],
            ),  
            SizedBox(height: 50,),    
          Column(
          children:
          List.generate(int.parse(count), (index) {
            return FadeInDown(
              duration: Duration(milliseconds: 350 * index),
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
                                        image: MemoryImage(base64Decode("${ImageCart[index]}")),
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
                              onTap: (){
                                RemoveData("${NameCart[index]}");
                              },
                              child: Icon(Icons.cancel,size: 16,color:Colors.red,),
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
                              "${PriceCart[index]}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${QuantityCart[index]}",
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
          })
          ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total",
                style: TextStyle(
                    fontSize: 22,
                    color: black.withOpacity(0.5),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "\$${total}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.pink[600],
              onPressed: () {
              
            openCheckout();
              },
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    "CHECKOUT",
                    style: TextStyle(
                        color: white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )),
        )
      ],
    );
                
  }));
}


}
