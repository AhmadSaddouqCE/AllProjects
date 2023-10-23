import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sara_music/Screens/Search.dart';
import 'package:line_icons/line_icons.dart';
import 'Booking.dart';
import 'package:sara_music/Screens/Homepage.dart';
import 'package:sara_music/globalss.dart';

import 'Profile.dart';
import '../Shop/Shop.dart';
import 'MyDrawer.dart';
import 'dart:math' as math;

class bottom_bar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return bottom_barState();
  }
}

class bottom_barState extends State<bottom_bar> {
  List<Map<String, Widget>> _pages = [
    {
      'page': Homepage(),
    },
    {
      'page': Booking(),
    },
    {
      'page': Search(),
    },
    {
      'page': Shop(),
    },
    {
      'page': Profile(),
    },
  ];
  int _selectedPageIndex = 0;

  void intState() {
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
    
      _selectedPageIndex = index;
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DRawer(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: BottomNavigationBar(
              selectedFontSize: 13,
              iconSize: 23,
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.pink.shade400,
              currentIndex: _selectedPageIndex,
              items: [
                
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home_outlined,size: 25,),
                  activeIcon: Icon(Icons.home,size: 25,)
                ),
                BottomNavigationBarItem(
                  
                  icon: Icon(FontAwesomeIcons.calendar),
                  activeIcon: Icon(FontAwesomeIcons.calendarPlus),
                  label: "Booking",
                ),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.search,size: 18,),
                    activeIcon: Icon(FontAwesomeIcons.search),
                    label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_grocery_store_outlined,size: 25,),
                    activeIcon: Icon(Icons.local_grocery_store,size: 25,),
                     label: "Shop"),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.user), label: "Profile",activeIcon: Icon(FontAwesomeIcons.userAlt)),
                    
              ],
            ),
          ),
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      
      
      
    );
  }
}
