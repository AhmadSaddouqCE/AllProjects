import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sara_music/authi/login.dart';
import 'package:sk_onboarding_screen/flutter_onboarding.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntroPageState();
  }
}

class IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: Colors.pink[600],
        pages: pages,
        skipClicked: (value) {
          Navigator.push(
            context,
            PageTransition(
              alignment: Alignment.bottomCenter,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 1500),
              reverseDuration: Duration(milliseconds: 1500),
              type: PageTransitionType.bottomToTopJoined,
              child: Login(),
              childCurrent: Login()
            ),
          );
        },
        getStartedClicked: (value) {
          Navigator.push(
            context,
            PageTransition(
              alignment: Alignment.bottomCenter,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 1500),
              reverseDuration: Duration(milliseconds: 1500),
              type: PageTransitionType.topToBottomJoined,
              child: Login(),
              childCurrent: Login()
            ),
          );
        },
      ),
    );
  }

  final pages = [
    SkOnboardingModel(
        title: 'Class Booking',
        description:
            'Easily book your class for your favorite instrument to enjoy your favorite music',
        titleColor: Colors.black,
        descripColor: Colors.pink[600],
        imagePath: 'images/Intro-booking.png'),
    SkOnboardingModel(
        title: 'Pick Up or Delivery',
        description:
            'Easily get your instrument either online or by visting our center to start your journey!',
        titleColor: Colors.black,
        descripColor: Colors.pink[600],
        imagePath: 'images/musical-learning.png'),
    SkOnboardingModel(
        title: 'Pay quick and easy',
        description: 'Pay for order using credit or debit card',
        titleColor: Colors.black,
        descripColor: Colors.pink[600],
         imagePath: 'images/Shopping.png'),
  ];
}
