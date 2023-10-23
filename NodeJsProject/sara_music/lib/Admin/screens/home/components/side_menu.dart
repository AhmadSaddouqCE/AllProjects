import '../../../core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [          
                Image.asset(
                  "images/Logo.png",
                  scale: 1.2,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text("Do Re Mi Music Center")
              ],
            )),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "images/icons/menu_dashbord.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Posts",
              svgSrc: "images/icons/menu_tran.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Pages",
              svgSrc: "images/icons/menu_task.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Categories",
              svgSrc: "images/icons/menu_doc.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Appearance",
              svgSrc: "images/icons/menu_store.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Users",
              svgSrc: "images/icons/menu_notification.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Tools",
              svgSrc: "images/icons/menu_profile.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "images/icons/menu_setting.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}