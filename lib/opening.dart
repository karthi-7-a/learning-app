import 'dart:async';

import 'package:Productin/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'flutterfire.dart';

class Opening extends StatelessWidget {
  const Opening({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            child: Column(children: [
              Image(
                width: 100,
                height: 100,
                image: AssetImage('assets/Productin1.png'),
              ),
              Container(
                //  margin: EdgeInsets.only(left: move),
                child: Text("Productin",
                    style: TextStyle(
                        // color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 40,
                        fontWeight: FontWeight.w600)),
              ),
              Container(
                // margin: EdgeInsets.only(right: move),
                child: Text("The Ultimate Programmers Guide",
                    style: TextStyle(
                        //   color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              )
            ])),
      )),
    );
  }
}

class Verification extends StatelessWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FirebaseAuth.instance.currentUser!.emailVerified
            ? MyApp()
            : MaterialApp(
                home: Scaffold(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 15),
                    appBar: AppBar(
                        toolbarHeight: 60,
                        backgroundColor: Color.fromRGBO(0, 0, 200, 100),
                        title: Container(
                            width: MediaQuery.of(context).size.width - 60,
                            child: Text("Productin",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    // color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'RobotoMono')))),
                    body: SingleChildScrollView(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                            child: Column(children: [
                              Text(FirebaseAuth
                                  .instance.currentUser!.emailVerified
                                  .toString()),
                              Text(FirebaseAuth.instance.currentUser!
                                  .toString()),
                              GestureDetector(
                                  child: Text("Cont"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Authentication()));
                                    logout();
                                  })
                            ]))))));
  }
}
