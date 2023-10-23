
import 'package:sara_music/Admin/screens/dashboard/components/user_details_mini_card.dart';
import 'package:sara_music/Admin/core/constants/color_constants.dart';
import 'package:sara_music/Admin/screens/dashboard/components/charts.dart';
import 'package:sara_music/Admin/screens/dashboard/components/calendart_widget.dart';
import 'package:flutter/material.dart';

class UserDetailsWidget extends StatefulWidget {
  const UserDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarWidget(),        
        ],
      ),
    );
  }
}