import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../Shop/colors.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'images/icons-back.png',
                      height: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    'About',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset("images/Logo.png"),
            ),
            SizedBox(
              height: 50,
            ),
            FadeInDown(
              delay: Duration(microseconds: 500),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                          "This center has been established in 2018 and it aims to teach music for those who has a musician talent. This center teaches how to profession any instrument such as Violin, Oud, Tabla, Qanun, Guitar, Piano and also it teaches Singing. This center teaches to profession reading notes. Also this center teaches the importance of music and how music share happiness between the families and friends.",
                          style: TextStyle(fontSize: 16),
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text('Al-Adel St., Nablus, Palestine'),
                      leading: Icon(
                        Icons.location_pin,
                        color: Colors.pink[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text('+970 599 350 872'),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.pink[600],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text('+970 599 350 876'),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.pink[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
