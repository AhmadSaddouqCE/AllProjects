import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sara_music/Screens/MyDrawer.dart';
import 'package:sara_music/Screens/Settings_Page.dart';
import 'package:sara_music/Screens/SettingsForAll.dart';

import 'package:search_widget/search_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sara_music/globalss.dart';


void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class TSearch extends StatefulWidget {
  @override
  TSearchState createState() => TSearchState();
}

class TSearchState extends State<TSearch> {



  LeaderBoard _selectedItem = LeaderBoard("", 0);
 
 List<LeaderBoard> list = <LeaderBoard>[];
  bool _show = true;
  var StudentsSigned="";
  var StudentsSignedList=[];
  var arr;
  var TeachersSigned="";
  var TeachersSignedList=[];
  var arr1;
  var count="";
  var count1="";
  late Future Students;
  late Future CountStudents;
  late Future CountTeachers;
  late Future Teachers;
  late Future all;
Future UsersCount() async{
 var res= await http.get(Uri.parse(globalss.IP+"/users/GetAllUsersCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
    if(res.statusCode==200){
      count=res.body;
    }
  }
  return count;
}

Future TeachersCount() async{
 var res= await http.get(Uri.parse(globalss.IP+"/teachers/GetAllTeachersCount"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
  if(mounted){
    if(res.statusCode==200){
      count1=res.body;
    }
  }
  return count1;
}

Future TeachersAvailable() async{
  try{
  var res= await http.get(Uri.parse(globalss.IP+"/teachers/GetAllTeachers"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
  if(res.statusCode==200){
     TeachersSigned = res.body;
  }
     
    }
     var TeachersSigned1 = TeachersSigned.toString();
      arr1=TeachersSigned1.split(",");
      for(int i = 0; i<int.parse(count1);i++){
      TeachersSignedList.add(arr1[i]);


      }
      }catch(e){
        print(e);

      }
return await [TeachersSignedList];
}


Future StudentsAvailable() async{
  try{
  var res= await http.get(Uri.parse(globalss.IP+"/users/GetAllUsers"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  });
if(mounted){
  if(res.statusCode==200){
     StudentsSigned = res.body;
  }
     
    }
     var StudentsSigned1 = StudentsSigned.toString();
      arr=StudentsSigned1.split(",");
      if(int.parse(count)!=0){
      for(int i = 0; i<int.parse(count);i++){
      StudentsSignedList.add(arr[i]);

}
      }
      }catch(e){
        print(e);
      }
return await [StudentsSignedList];
}
Future Add() async{
await TeachersCount();
await UsersCount();
await TeachersAvailable();
await StudentsAvailable();

for(var i=0;i<int.parse(count);i++){
list.addAll({
    LeaderBoard("${StudentsSignedList[i]}", 54),

});

}
for(var j=0;j<int.parse(count1);j++){
list.addAll({
    LeaderBoard("${TeachersSignedList[j]}", 100),

});

}

 return [list];
}
void initState() {
  super.initState();
  
  all=Add();

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Waitforme()
      ),
    );
  }
   Widget Waitforme() {
  
  return FutureBuilder(future: Future.wait([all]), builder:((context, snapshot)  {

    if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
              print(snapshot.error.toString());
         }      
     return  Column(
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
                      'images/icons-menu.png',
                      height: 30,
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'Search',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            // if (_show)
            SearchWidget<LeaderBoard>(
              dataList: list,
              hideSearchBoxWhenItemSelected: false,
              
              listContainerHeight: MediaQuery.of(context).size.height,
              queryBuilder: (query, list) {
                return list
                    .where((item) => item.username
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
              },
              popupListItemBuilder: (item) {
                return PopupListItemWidget(item);
              },
              selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                return SelectedItemWidget(selectedItem, deleteSelectedItem);
              },
              // widget customization
              noItemsFoundWidget: NoItemsFound(),
              textFieldBuilder: (controller, focusNode) {
                return MyTextField(controller, focusNode);
              },
              onItemSelected: (item) {
                setState(() {
                  _selectedItem = item;
                });
              },
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "${_selectedItem != null ? _selectedItem.username : ""
                  "No item selected"}",
            ),
          ],
        );

  }));
}
}

class LeaderBoard {
  LeaderBoard(this.username, this.score);

  final String username;
  final double score;
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final LeaderBoard selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: InkWell(
                onTap: () {
                  globalss.searchname=selectedItem.username;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Settings_Page1()));
                },
                child: Text(
                  selectedItem.username,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: deleteSelectedItem,
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900]?.withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900]?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final LeaderBoard item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.username,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}