import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sara_music/Games/GamePage.dart';
import 'package:sara_music/Games/Snake.dart';
import 'package:sara_music/Games/tic_tac_toe.dart';
import 'package:sara_music/Screens/Categories_Screen.dart';
import 'package:sara_music/Screens/Category.dart';
import 'package:sara_music/Screens/Change_Password.dart';
import 'package:sara_music/Screens/Details_screen.dart';
import 'package:sara_music/Screens/Profile.dart';
import 'package:sara_music/Screens/Settings_Page.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/Teacher/TDetails.dart';
import 'package:sara_music/authi/ForgetPassword.dart';
import 'package:sara_music/authi/ResetPassword.dart';
import 'package:sara_music/authi/Verify.dart';
import 'package:sara_music/authi/login.dart';
import 'package:sara_music/authi/Signup.dart';
import 'package:sara_music/Screens/Homepage.dart';
import 'package:sara_music/authi/IntroPage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:sara_music/Admin/screens/home/home_screen.dart';
import 'package:sara_music/notifications.dart';
import 'package:sara_music/responsive.dart';
import 'Admin/core/init/provider_list.dart';
import 'Teacher/Tbottom_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notifications', //title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
    name: 'sara_music',
    options: FirebaseOptions(
      apiKey: "XXX",
      appId: "XXX",
      messagingSenderId: "XXX",
      projectId: "XXX",
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

   await  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

Widget build(BuildContext context) {
  return MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: FutureBuilder(
        builder: (context, snapshot) {
          return MyApp();
        },
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      theme: ThemeData(
          textTheme: GoogleFonts.sansitaTextTheme(Theme.of(context).textTheme),
          primaryColor: Colors.pink[600],
          buttonColor: Colors.pink[600],
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Color.fromARGB(255, 231, 241, 241),
              labelStyle: TextStyle(color: Colors.grey.shade800),
              iconColor: Colors.pink.shade600,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.pink.shade600),
              ))),
      routes: {
        "login": (context) => Login(),
        "Signup": (context) => Signup(),
        "ForgetPassword": (context) => ForgetPassword(),
        "HomePage": (context) => Homepage(),
        "Bottom_bar": (context) => bottom_bar(),
        "Categories": (context) => Categories_Screen(),
        "ResetPass": (context) => ResetPassword(),
        "Settings": (context) => Settings_Page(),
      },
    );
  }
}
