import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sara_music/Screens/Booking.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/globalss.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:convert';

class Details_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Details_ScreenState();
  }
}

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
    


class Details_ScreenState extends State<Details_Screen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff7e1f2),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.all(15),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 35.0,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          // Image.asset(  
          //  imageProvider.toString(),
          //   height: size.height * 0.3,
          //   fit: BoxFit.fill,

          // ),
          Image(
                

            image:MemoryImage(base64Decode(globalss.courseimage))
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${globalss.Coursname}",
                            style: GoogleFonts.sansita(fontSize: 32),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Row(
                            
                          //   children: [
                          //     SmoothStarRating(
                          //       color: Colors.yellow,
                          //       borderColor: Colors.yellow,
                          //     ),
                          //     SizedBox(
                          //       width: 15,
                          //     ),
                          //     Text(
                          //       ".",
                          //       style: GoogleFonts.sansita(
                          //           color: Colors.grey[700]),
                          //     )
                          //   ],
                          // ),
                        ],
                      )),
                      ClipPath(
                        clipper: PricerCliper(),
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          height: 70,
                          width: 65,
                          color: Colors.pink[400],
                          child: Text(
                            "${globalss.courseprice}",
                            style: GoogleFonts.sansita(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "${globalss.coursedescription}",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey[700], height: 1.5)),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      child: Text("Start Now"),
                      onPressed: () {
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Booking()),
            
            );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[600],
                        onPrimary: Colors.white,
                        minimumSize: const Size(150, 40),
                        textStyle: TextStyle(
                          fontSize: 18,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
