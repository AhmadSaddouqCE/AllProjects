import 'package:sara_music/Admin/core/constants/color_constants.dart';
import 'package:sara_music/Admin/core/models/data.dart';
import 'package:sara_music/Admin/core/widgets/calendar_item.dart';

import 'package:flutter/material.dart';

class ListCalendarData extends StatefulWidget {
  final List<CalendarData> calendarData;

  const ListCalendarData({Key? key, required this.calendarData})
      : super(key: key);

  @override
  State<ListCalendarData> createState() => _ListCalendarDataState();
}

class _ListCalendarDataState extends State<ListCalendarData> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: widget.calendarData
          .asMap()
          .entries
          .map(
            (data) => Padding(
              padding: EdgeInsets.only(
                  bottom:
                      data.key != widget.calendarData.length - 1 ? defaultPadding : 0),
              child: CalendarItem(
                calendarItemData: data.value,
              ),
            ),
          )
          
          .toList(),
    );
    
  }
  
}
