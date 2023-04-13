import 'dart:async';

import 'package:Productin/child.dart';
import 'package:flutter/material.dart';
import 'package:Productin/auth.dart';
// new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:google_fonts/google_fonts.dart';
import 'package:Productin/search.dart';
import 'package:provider/provider.dart';
import 'package:win32/win32.dart';

import 'Personal.dart';
import 'Recommendations.dart';
import 'contribute.dart';
import 'opening.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Open());
}

class Open extends StatefulWidget {
  @override
  _OpenState createState() => _OpenState();
}

class _OpenState extends State<Open> {
  bool isopen = true;
  fun() {
    Timer(
        Duration(seconds: 2),
        () => setState(() {
              isopen = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    fun();
    return MaterialApp(
        home: (isopen == true
            ? Opening()
            : FirebaseAuth.instance.currentUser != null
                // ? FirebaseAuth.instance.currentUser!.emailVerified == true
                ? MyApp()
                //   : Verification()
                : Authentication()));
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

/*
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  void c() {
    Consumer<ApplicationState>(
      builder: (context, appState, _) => Authentication(
        email: appState.email,
        loginState: appState.loginState,
        startLoginFlow: appState.startLoginFlow,
        verifyEmail: appState.verifyEmail,
        signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
        cancelRegistration: appState.cancelRegistration,
        registerAccount: appState.registerAccount,
        signOut: appState.signOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Firebase Meetup'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/codelab.png'),
          SizedBox(height: 8),
          // Add from here
          ElevatedButton(onPressed: c, child: Text('ppp')),
          // to here
          Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          Header("What we'll be doing"),
          Paragraph(
            'Join us for a day full of Firebase Workshops and Pizza!',
          ),
        ],
      ),
    ));
  }
}
*/
class BoxContainer extends StatefulWidget {
  String l;
  bool m;
  var color;

  var k = Colors.blue;
  BoxContainer(this.l, this.m, this.color);

  @override
  _BoxContainerState createState() => _BoxContainerState(l, m, color);
}

class _BoxContainerState extends State<BoxContainer> {
  String l;
  bool m;
  var color;
  bool isdelay = false;
  var k = Colors.blue;
  _BoxContainerState(this.l, this.m, this.color);
  time() {
    Timer(
        Duration(milliseconds: 2000),
        () => setState(() {
              isdelay = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    // time();
    return GestureDetector(
        child: Container(
            // duration: Duration(seconds: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 10,
                      spreadRadius: 5,
                      color: Colors.grey.shade100)
                ]
                //  border: Border.all(color: Colors.pink, width: 2),
                ),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(l,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      // color: Color.fromRGBO(1, 1, 1, 100),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.35,
                      // decorationThickness: 9,
                    ))),
            height: MediaQuery.of(context).size.height / 12,
            width: MediaQuery.of(context).size.width / 1.35,
            margin: EdgeInsets.fromLTRB(m ? 0 : 50, 15, m ? 50 : 0, 5)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Child(l)),
          );
        });
  }
}

class Nav_bottom extends StatelessWidget {
  int n, i;
  Nav_bottom(this.n, this.i);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Icon(
          n == 0
              ? Icons.home
              : n == 1
                  ? Icons.recommend
                  : n == 2
                      ? Icons.add_circle
                      : n == 3
                          ? Icons.flag
                          : Icons.person,
          color: n == i ? Colors.pink : Color.fromRGBO(5, 5, 5, 100),
          size: 30,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => n == 0
                    ? MyApp()
                    : n == 1
                        ? Recommendations()
                        : n == 2
                            ? Recommendations1()
                            : n == 3
                                ? Contribute()
                                : Personal("", "", "")),
          );
        });
  }
}

Widget nav_bottom(int i) {
  List<Widget> list = [];
  for (int n = 0; n < 5; n++) {
    list.add(Nav_bottom(n, i));
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: list,
  );
}

class Con extends StatelessWidget {
  String l = "";
  Con(this.l); // const Con({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
            color: Colors.lightBlue),
        margin: EdgeInsets.only(top: 18, bottom: 8),
        child: Column(children: [
          const Image(
            height: 150,
            image: NetworkImage(
                'https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png'),
          ),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                l,
                style: TextStyle(
                  fontSize: 30,
                ),
              )),
        ]),
      ),
    );
  }
}

class MyAppState extends State<MyApp> {
  var stateval = "Arrays";
  var sel = false;
  var user = FirebaseAuth.instance.currentUser?.uid;
  Widget c() {
    var arr = {
      'Arrays': 'ap',
      'Stack': 'bp',
      'Queue': 'cl',
      'Trees': 'dp',
      'Graphs': 'ep'
    };
    List<Widget> list = [];
    for (int i = 0; i < arr.length; i++) {
      list.add(Con(arr[stateval]!));
    }
    return Column(
      children: list,
    );
  }

  Widget co() {
    var arr = [
      'Arrays',
      'Stack',
      'Queue',
      'Binary Tree',
      'Binary Search Tree',
      'Heap',
      'Graphs',
      'Linked List',
      'Backtracking',
      'Greedy',
      'Dynamic Programming',
      'Divide and Conquer',
      'Graph Algorithms',
      'Mathematical'
    ];
    var color = [
      Colors.red,
      Colors.pink,
      Colors.orange,
    ];
    List<Widget> list = [];
    for (int i = 0; i < arr.length; i++) {
      list.add(BoxContainer(arr[i], i % 2 == 0, color[i % 3]));
    }
    return Column(
      children: list,
    );
  }

  //MyAppState({Key? key}) : super(key: key);
  //Map<String, String>? arr = {'DS': 'd', 'PP': 'p', 'LL': 'l'};

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
            home: Scaffold(
                persistentFooterButtons: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: nav_bottom(0),
          )
        ],
                backgroundColor: Color.fromRGBO(255, 255, 255, 5),
                appBar: AppBar(
                    toolbarHeight: 60,
                    backgroundColor: Color.fromRGBO(0, 0, 200, 100),
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
                    child: Column(children: [
                  //  Text(FirebaseAuth.instance.currentUser!.uid),
                  Container(
                    child: co(),
                    width: 10000,
                    margin: EdgeInsets.only(bottom: 5),
                  ),
                ])))));
  }
}
/*
*/
