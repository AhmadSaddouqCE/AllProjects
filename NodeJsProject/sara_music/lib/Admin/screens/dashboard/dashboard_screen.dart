import 'package:flutter/material.dart';
import 'package:sara_music/Admin/screens/dashboard/components/recent_shop.dart';

import 'package:sara_music/Screens/Details_screen.dart';
import 'package:sara_music/authi/login.dart';
import 'package:sara_music/responsive.dart';
import 'components/header.dart';
import 'components/mini_information_card.dart';
import 'components/recent_forums.dart';
import 'components/recent_users copy.dart';
import 'components/recent_teachers.dart';
import 'components/user_details_widget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              MiniInformation(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        SizedBox(height: defaultPadding),
                        RecentUsers(),
                        SizedBox(height: defaultPadding),
                        RecentTeacher(),
                        SizedBox(height: defaultPadding),
                        RecentShop(),
                        SizedBox(height: defaultPadding),
                        RecentDiscussions(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: UserDetailsWidget(),
                    ),

             
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 12, 51, 113)),onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Login()));
              }, icon: Icon(Icons.logout_outlined),label: Text("Logout"),)
            ],
          ),
        ),
      ),
    );
  }
}