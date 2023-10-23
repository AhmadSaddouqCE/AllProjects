import 'package:sara_music/Admin/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class UserDetailsMiniCard extends StatefulWidget {
  const UserDetailsMiniCard({
    Key? key,
    required this.title,
    required this.color,
    required this.amountOfFiles,
    required this.numberOfIncrease,
  }) : super(key: key);

  final Color color;
  final String title, amountOfFiles;
  final int numberOfIncrease;

  @override
  State<UserDetailsMiniCard> createState() => _UserDetailsMiniCardState();
}

class _UserDetailsMiniCardState extends State<UserDetailsMiniCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
              height: 20,
              width: 20,
              child: Container(
                color: widget.color,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${widget.numberOfIncrease}",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Text(widget.amountOfFiles)
        ],
      ),
    );
  }
}