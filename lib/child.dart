import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Productin/Grand_child.dart';
import 'package:Productin/flutterfire.dart';
import 'package:Productin/main.dart';
import 'package:Productin/search.dart';

import 'contribute.dart';

class Child extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser?.uid;
  String l;
  Child(this.l);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
            home: Scaffold(
                persistentFooterButtons: [
          SizedBox(height: 50, width: double.infinity, child: nav_bottom(0))
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      l,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Colors.pink),
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users_data')
                          .doc(l)
                          .collection(l)
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        //////
                        //  if (!snapshot.hasData) return Text("LL");
                        //  return Text(snapshot.connectionState.toString());
                        String fac = FirebaseAuth.instance.currentUser!.uid;

                        return !snapshot.hasData || snapshot.data!.docs.length == 0
                            ? Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "No Articles Found !",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                //   margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child: Column(
                                  children: snapshot.data!.docs.map((document) {
                                    return Class1(document, true,
                                        document['liked'].contains(fac));
                                  }).toList(),
                                ));
                      }),
                ])))));
  }
}

/*
  StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      //.where('title', isEqualTo: l)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Container(
                            child: Row(
                          children: [
                            Text("ppp"),
                            Text("Price:"),
                          ],
                        ));
                      }).toList(),
                    );
                  }),
                  */

class Personal1 extends StatefulWidget {
  const Personal1({Key? key}) : super(key: key);

  @override
  _Personal1State createState() => _Personal1State();
}

class _Personal1State extends State<Personal1> {
  bool wid = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AnimatedContainer(
          duration: Duration(seconds: 2),
          child: Text("PP"),
          width: !wid == true ? 100 : 0),
      MaterialButton(
        child: Text("pp"),
        onPressed: () => setState(() {
          wid = !wid;
        }),
      )
    ]);
  }
}

class Class1 extends StatefulWidget {
  DocumentSnapshot document;
  bool val;
  bool isliked;

  Class1(this.document, this.val, this.isliked);
  @override
  _Class1State createState() => _Class1State(document, val, isliked);
}

class _Class1State extends State<Class1> with SingleTickerProviderStateMixin {
  DocumentSnapshot document;
  bool val;
  late Animation anim_color;
  bool isliked;
  _Class1State(this.document, this.val, this.isliked);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Grand_child(document)),
          );
        },
        child: Container(
            child: Row(
          children: [
            //   MaterialButton(child: Text("pp"),onPressed:,),
            // TweenAnimationBuilder(tween: tween, duration: duration, builder: builder)
            Container(
                margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                width: MediaQuery.of(context).size.width - 30,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(5, 2),
                          blurRadius: 5,
                          spreadRadius: 5,
                          color: Colors.grey.shade200)
                    ]),
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(
                          "By ",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          document['user'] + "  ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.pink),
                        ),
                        Text(
                          document['format'],
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.green),
                        ),
                      ]),
                      //  Text(document['timestamp']),

                      //  mainAxisAlignment: MainAxisAlignment.start,
                      Row(
                          //     //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width - 80,
                                child: Text(document['titletext'],
                                    overflow: TextOverflow.ellipsis,
                                    textWidthBasis: TextWidthBasis.parent,
                                    maxLines: 3,

                                    // textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.65,
                                        color:
                                            Color.fromRGBO(19, 13, 13, 100)))),
                            GestureDetector(
                                onTap: () async {
                                  isliked = true;
                                  await liked(document);
                                },
                                child: Icon(
                                  Icons.add_to_drive_outlined,
                                  color: isliked
                                      ? Colors.deepPurpleAccent
                                      : Colors.black,
                                ))

                            //Text("pp")
                            //   width: MediaQuery.of(context).size.width,
                            // )
                          ])
                    ]))
          ],
          //)
        )));
  }
}
