import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sara_music/globalss.dart';

class TeacherSched extends StatefulWidget {
 TeacherSched({Key? key}) : super(key: key);

  @override
  State <TeacherSched> createState() =>  TeacherSchedState();
}

class  TeacherSchedState extends State <TeacherSched> {
  late Future all;
  var Count="0";
Future GetCount() async{
  try{
  var body1 = jsonEncode({
    "name":globalss.TeacherName
  });
    var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/TeachersBCount1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);

    if(mounted){
      if(res.statusCode==200){
        Count=res.body;
      }
    }
    return Count;
  }catch(e){
    print(e);
  }
}
List ListofDates=[];
var dates="";
Future GetListOfDates() async{
  try{
  var body1 = jsonEncode({
    "name":globalss.TeacherName
  });
    var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/TeachersBDates1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);

    if(mounted){
      if(res.statusCode==200){
        dates=res.body;
      }
    }
    var dates1= dates.toString().split(",");
    for(int i=0;i<int.parse(Count);i++){
      ListofDates.add(dates1[i]);
    }

    return [ListofDates];
  }catch(e){
    print(e);
  }
}
List ListofTimes=[];
var times="";
Future GetListOfTimes() async{
  try{
  var body1 = jsonEncode({
    "name":globalss.TeacherName
  });
    var res= await http.post(Uri.parse(globalss.IP+"/Ttasks/TeachersBTimes1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  },body: body1);

    if(mounted){
      if(res.statusCode==200){
        times=res.body;
      }
    }
    var times1= times.toString().split(",");
    for(int i=0;i<int.parse(Count);i++){
      ListofTimes.add(times1[i]);
    }

    return [ListofTimes];
  }catch(e){
    print(e);
  }
}
Future All() async{
  await GetCount();
  await GetListOfDates();
  await GetListOfTimes();
}
  @override
  void initState(){
    super.initState();
    all = All();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Image.asset(
            'images/icons-back.png',
            scale: 1.5,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Appointments",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,),
        body: 
              Waitforme()
            
    );
  }
   Widget Waitforme() {
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {
    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }      
     return MediaQuery.removePadding(
                
    context: context,
    
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing:20 ,
        crossAxisSpacing: 10,
        
            
      ),
      itemCount: int.parse(Count),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.only(top: 20),
          color: Color.fromARGB(255, 231, 241, 241),
          child: Stack(
                            children: [
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 60,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[600],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "${ListofTimes[index]}",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: 80,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[600],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "${ListofDates[index]}",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        SizedBox(height: 5,),
                                   
                                    
                                   
                                  ],
                                ),
                              ),
                              
                              
                            ],
                          ),
        );
      }
    ),
     );

  }));
}
}