import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';
import 'package:Productin/search.dart';

import 'Personal.dart';
import 'child.dart';
import 'flutterfire.dart';
import 'main.dart';

class Recommendations extends StatefulWidget {
  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  int n = 0;

  String fac = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
            home: Scaffold(
                persistentFooterButtons: [
          SizedBox(height: 50, width: double.infinity, child: nav_bottom(1))
        ],
                backgroundColor: Color.fromRGBO(255, 255, 255, 5),
                appBar: AppBar(
                    toolbarHeight: 60,
                    backgroundColor: Colors.deepPurple,
                    title: Center(
                        child: Row(children: [
                      Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Text("Productin",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  // color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'RobotoMono'))),
                      GestureDetector(
                          child: Icon(Icons.search),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Search()),
                            );
                          })
                    ]))),
                body: SingleChildScrollView(
                    child: Container(
                        child: Column(children: [
                  Container(child: AuthUsersdata1(0))
                ]))))));
  }
}

class Recommendations1 extends StatefulWidget {
  @override
  _Recommendations1State createState() => _Recommendations1State();
}

class _Recommendations1State extends State<Recommendations1> {
  int n = 0;

  String fac = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
            home: Scaffold(
                persistentFooterButtons: [
          SizedBox(height: 50, width: double.infinity, child: nav_bottom(2))
        ],
                backgroundColor: Color.fromRGBO(255, 255, 255, 5),
                appBar: AppBar(
                    toolbarHeight: 60,
                    backgroundColor: Colors.deepPurple,
                    title: Center(
                        child: Row(children: [
                      Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Text("Productin",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  // color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'RobotoMono'))),
                      GestureDetector(
                          child: Icon(Icons.search),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Search()),
                            );
                          })
                    ]))),
                body: SingleChildScrollView(
                    child: Container(
                        child: Column(children: [
                  Container(child: AuthUsersdata(1))
                ]))))));
  }
}

class AuthUsersdata1 extends StatefulWidget {
  var n;
  AuthUsersdata1(this.n);
  @override
  _AuthUsersdata1State createState() => _AuthUsersdata1State(n);
}

class _AuthUsersdata1State extends State<AuthUsersdata1> {
  var n, t = 0;

  _AuthUsersdata1State(this.n);
  String fac = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                'Recommendations',
                style: TextStyle(
                    fontSize: 22, color: Colors.pink, letterSpacing: 1.15),
              ))),
      Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Auth_Users')
                  .where('uid', isNotEqualTo: fac)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text("");
                //////
                return Container(
                    child: Column(children: [
                  Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return Recommendations1Data(document, n);
                    }).toList(),
                  ),
                  //  flag == false ? Text("NO data") : Container()
                ]));
              }))
    ]);
  }
}

class Recommendations1Data extends StatefulWidget {
  DocumentSnapshot? document;
  var n;
  Recommendations1Data(this.document, this.n);
  @override
  _Recommendations1DataState createState() =>
      _Recommendations1DataState(document, n);
}

class _Recommendations1DataState extends State<Recommendations1Data> {
  String fac = FirebaseAuth.instance.currentUser!.uid;

  finduid(DocumentSnapshot doc) {
    List l = doc['follow'];
    for (String i in l) {
      if (i == fac) return true;
    }
    return false;
  }

  DocumentSnapshot? document;
  var v = false;
  var n;
  _Recommendations1DataState(this.document, this.n);

  @override
  Widget build(BuildContext context) {
    if (finduid(document!)) {
      setState(() {
        v = true;
      });
    }
    return v == true ? kingofkings(document!['uid']) : Container();
  }
}

class AuthUsersdata extends StatefulWidget {
  var n;
  AuthUsersdata(this.n);
  @override
  _AuthUsersdataState createState() => _AuthUsersdataState(n);
}

class _AuthUsersdataState extends State<AuthUsersdata> {
  var n;
  _AuthUsersdataState(this.n);
  String fac = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Text(
                'Active Users',
                style: TextStyle(
                    fontSize: 22, color: Colors.pink, letterSpacing: 1.15),
              ))),
      Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Auth_Users')
                  .where('uid', isNotEqualTo: fac)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Container();
                return Container(
                    child: Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return RecommendationsData(document, n);
                  }).toList(),
                ));
              }))
    ]);
  }
}

class RecommendationsData extends StatefulWidget {
  DocumentSnapshot? document;
  var n;
  RecommendationsData(this.document, this.n);
  @override
  _RecommendationsDataState createState() =>
      _RecommendationsDataState(document, n);
}

class _RecommendationsDataState extends State<RecommendationsData> {
  String fac = FirebaseAuth.instance.currentUser!.uid;

  finduid(DocumentSnapshot doc) {
    List l = doc['follow'];
    for (String i in l) {
      if (i == fac) return true;
    }
    return false;
  }

  DocumentSnapshot? document;
  Color color = Colors.pink;
  String text = "Follow";
  var n;
  _RecommendationsDataState(this.document, this.n);

  @override
  Widget build(BuildContext context) {
    if (finduid(document!)) {
      setState(() {
        text = "Following";
        color = Colors.blue;
      });
    }

    return GestureDetector(
        child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset(5, 2),
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Colors.grey.shade300)
            ]),
            child: Row(children: [
              Container(
                  child: Text(
                    document!['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                  ),
                  width: MediaQuery.of(context).size.width - 120),
              GestureDetector(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.fromLTRB(
                        text == "Following" ? 20 : 30, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: Row(children: [
                      Text(text, style: TextStyle(color: Colors.white))
                    ]),
                  ),
                  onTap: () => {
                        setState(() {
                          text = "Following";
                          color = Colors.blue;
                        }),
                        Follow(document!['uid']),
                      })
            ]),
            padding: EdgeInsets.fromLTRB(0, 8, 10, 8),
            margin: EdgeInsets.fromLTRB(0, 4, 0, 4)),
        onTap: () => {
              if (text == "Following")
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Personal(document!['uid'],
                            document!['name'], document!['photourl'])),
                  )
                }
            });
  }
}

Widget kingofkings(String doc) {
  String fac = FirebaseAuth.instance.currentUser!.uid;

  return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('contributed', isEqualTo: doc)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            //  var user = FirebaseAuth.instance.currentUser!.displayName;
            return Container(
                child: Column(
                    children: snapshot.data!.docs.map((document) {
              return Class1(document, true, document['liked'].contains(fac));
            }).toList()));
          }));
}
