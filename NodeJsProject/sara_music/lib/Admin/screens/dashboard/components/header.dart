import '../../../../responsive.dart';
import '../../../core/constants/color_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isMobile(context))
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello Admin 👋",style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.black),),
              SizedBox(
                height: 8,
              ),
              Text(
                "Welcome to your dashboard",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        
          
          if (Responsive.isMobile(context))
        Expanded(child: Text("Hello Admin 👋",style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.black),)),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color.fromARGB(255, 231, 241, 242)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(""),
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Khaled Sadouq"),
            ),
        ],
      ),
    );
  }
}

