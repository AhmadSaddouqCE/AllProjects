import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Screens/MyDrawer.dart';
import 'TBreak.dart';
import 'TSchedule.dart';
import 'THomepage.dart';
import 'TSearch.dart';
import 'TProfile.dart';

class Tbottom_bar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Tbottom_barState();
  }
}

class Tbottom_barState extends State<Tbottom_bar> {
  List<Map<String, Widget>> _pages = [
    {
      'page': THomepage(),
    },
    {
      'page': TSchedule(),
    },
    {
      'page': TSearch(),
    },
    {
      'page': TBreak(),
    },
    {
      'page': TProfile(),
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
              selectedItemColor: Color.fromARGB(255, 46, 23, 172),
              currentIndex: _selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(FontAwesomeIcons.home),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(FontAwesomeIcons.calendarAlt),
                  icon: Icon(FontAwesomeIcons.calendar),
                  label: "Schedule",
                ),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.search,size: 20,),       
                    activeIcon: Icon(FontAwesomeIcons.search,),            
                    label: "Search"),
                BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.calendarAlt),activeIcon:Icon(FontAwesomeIcons.calendarTimes) ,label: "Break"),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.user),
                    activeIcon: Icon(FontAwesomeIcons.userAlt), 
                    label: "Profile"),
              ],
            ),
          ),
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }
}
