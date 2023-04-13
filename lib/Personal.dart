import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Productin/auth.dart';
import 'package:Productin/main.dart';
import 'package:Productin/contribute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Productin/user_image.dart';
import 'package:win32/win32.dart';

import 'child.dart';
import 'flutterfire.dart';
import 'package:Productin/search.dart';

class Personal extends StatefulWidget {
  String uid;
  String name;
  String photourl;
  Personal(this.uid, this.name, this.photourl);

  @override
  _PersonalState createState() => _PersonalState(uid, name, photourl);
}

validate(var e) {
  if (e == "")
    return "Enter url...";
  else if (e.length != 0 &&
      (!((e.startsWith("https://") && e.contains(".com/")) ||
          e.contains("www."))))
    return "Enter valid url";
  else
    return null;
}

class _PersonalState extends State<Personal> {
  String uid;
  String name;
  String photourl;
  int count = 0, count1 = 0;
  String authuid = FirebaseAuth.instance.currentUser!.uid;
  _PersonalState(this.uid, this.name, this.photourl);
  String? imageUrl = FirebaseAuth.instance.currentUser!.photoURL;

  final key1 = new GlobalKey<ScaffoldState>();
  String fac = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController linkedin_url = TextEditingController();
  TextEditingController leetcode_url = TextEditingController();
  TextEditingController codechef_url = TextEditingController();
  TextEditingController github_url = TextEditingController();
  var users_data_1 = FirebaseFirestore.instance.collection('Users_data');
  bool first_time = false;
  final _formKey = GlobalKey<FormState>();
  var lim1 = true, lim2 = true;
  init() {
    if (uid.length == 0) {
      setState(() {
        uid = authuid;
      });
    }
  }

  cliprect(var provider, double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Image(
        image: provider,
        height: height,
        width: width,
      ),
    );
  }

  Future changeProfilePhoto(bool l) async {
    setState(() {
      imageUrl = l ? FirebaseAuth.instance.currentUser!.photoURL! : photourl;
    });
  }

  Future<bool> king() async {
    try {
      var l = await users_data_1.doc(uid).get();
      if (!l.exists) {
        setState(() {
          first_time = true;
        });
      }
      // print(FirebaseAuth.instance.currentUser!.uid);
      return l.exists;
    } catch (e) {
      return false;
    }
  }

  PersonalData(String s, bool lim1, int l, String fac) {
    return Container(
        child: FutureBuilder(
            future: s == 'contributed'
                ? FirebaseFirestore.instance
                    .collection('Contributed')
                    .doc(fac)
                    .collection(fac)
                    .orderBy('timestamp', descending: true)
                    // .limit(lim1 == true ? 3 : 100)
                    .get()
                : FirebaseFirestore.instance
                    .collection('Users_liked')
                    .doc(fac)
                    .collection(fac)
                    .orderBy('liked', descending: true)
                    // .limit(lim1 == true ? 3 : 100)
                    .get(),
            //
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              int c = 0;

              return Column(children: [
                Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                  c++;

                  return Class1(
                      document,
                      s == 'liked',
                      s == 'liked' ||
                          document['liked'].contains(
                              FirebaseAuth.instance.currentUser!.uid));
                }).toList()),
                c == 0 ? Text('No Articles Found') : Text(''),
              ]);
            }));
  }

  Widget fun(Map<String, dynamic> data) {
    List<Widget> list = [], list1 = [];
    data.forEach((key, value) {
      list.add(Container(
        alignment: Alignment.center,
        child: Text(
          key,
          style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(0, 10, 200, 100),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.15),
        ),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        margin: EdgeInsets.fromLTRB(0, 4, 4, 4),
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
      ));
      list1.add(Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: GestureDetector(
          child: SelectableText(
            value,
          ),
          onLongPress: () {
            Clipboard.setData(new ClipboardData(text: value));
            // key1.currentState!.showBottomSheet((context) =>
            //     const SnackBar(content: Text('Copied to ClipBoard')));
          },
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: EdgeInsets.fromLTRB(4, 4, 0, 4),
        width: MediaQuery.of(context).size.width - 150,
        height: 40,
      ));
    });

    return Container(
      child: Row(
        children: [
          Column(children: list),
          Column(
            children: list1,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      alignment: Alignment.center,

      decoration: BoxDecoration(
          // color: Color.fromRGBO(224, 224, 224, 100),
          borderRadius: BorderRadius.circular(10)),
      //   width: MediaQuery.of(context).size.width / 1.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    init();
    changeProfilePhoto(uid == FirebaseAuth.instance.currentUser!.uid);
    return MaterialApp(
        home: Scaffold(
            key: key1,
            persistentFooterButtons: [
              SizedBox(height: 50, width: double.infinity, child: nav_bottom(4))
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
              uid != FirebaseAuth.instance.currentUser!.uid
                  ? GestureDetector(
                      child: Row(children: [
                        Container(
                          // width: 80,
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(children: [
                            Text("Back", style: TextStyle(color: Colors.white))
                          ]),
                        )
                      ]),
                      onTap: () => {Navigator.pop(context)})
                  : Container(),
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                      uid != FirebaseAuth.instance.currentUser!.uid
                          ? name + "'s Profile"
                          : "Your's Profile",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 23))),
              //  imageUrl == null?
              uid != FirebaseAuth.instance.currentUser!.uid
                  ? Container(
                      //  margin: EdgeInsets.only(left: 30),
                      child: ClipRRect(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: photourl == ''
                            ? Icon(Icons.account_circle,
                                size: 80, color: Colors.grey.shade600)
                            : Image(
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                image: NetworkImage(photourl)),
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ))
                  : UserImage(
                      onFileChanged: (i) {
                        setState(() {
                          this.imageUrl = i;
                        });
                      },
                      s: true),

              //  Text(FirebaseAuth.instance.currentUser.toString()),
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.shade100,
                          Colors.grey.shade50,
                          Colors.white
                        ]),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 5,
                          color: Colors.grey.shade300)
                    ],
                  ),
                  child: FutureBuilder<DocumentSnapshot>(
                      future: users_data_1.doc(uid).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.data?.data() == null) {
                          king();
                          if (uid != fac) {
                            return Container(
                                child: fun({
                              "Linkedin": '',
                              "Github": '',
                              "Codechef": '',
                              "Leetcode": ''
                            }));
                          }
                          return Column(children: [
                            Form(
                                key: _formKey,
                                child: Column(children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: TextFormField(
                                      toolbarOptions: ToolbarOptions(
                                          copy: true,
                                          cut: true,
                                          paste: true,
                                          selectAll: true),
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 10, 200, 100)),
                                      controller: linkedin_url,
                                      validator: (e) => validate(e),
                                      decoration: InputDecoration(
                                        hintText: "Enter your LinkedIn URL",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        labelText: "LinkedIn URL",
                                        labelStyle: TextStyle(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: TextFormField(
                                      toolbarOptions: ToolbarOptions(
                                          copy: true,
                                          cut: true,
                                          paste: true,
                                          selectAll: true),
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 10, 200, 100)),
                                      controller: leetcode_url,
                                      validator: (e) => validate(e),
                                      decoration: InputDecoration(
                                        hintText: "Enter your LeetCode URL",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        labelText: "LeetCode URL",
                                        labelStyle: TextStyle(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: TextFormField(
                                      toolbarOptions: ToolbarOptions(
                                          copy: true,
                                          cut: true,
                                          paste: true,
                                          selectAll: true),
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 10, 200, 100)),
                                      validator: (e) => validate(e),
                                      controller: codechef_url,
                                      decoration: InputDecoration(
                                        hintText: "Enter your Codechef URL",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        labelText: "Codechef URL",
                                        labelStyle:
                                            TextStyle(color: Colors.purple),
                                      ),
                                    ),
                                  ),
                                  //   Clipboard(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: TextFormField(
                                      toolbarOptions: ToolbarOptions(
                                          copy: true,
                                          cut: true,
                                          paste: true,
                                          selectAll: true),
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(0, 10, 200, 100)),
                                      validator: (e) => validate(e),
                                      controller: github_url,
                                      decoration: InputDecoration(
                                        hintText: "Enter your Github URL",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        labelText: "Github URL",
                                        labelStyle: TextStyle(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                  ),
                                ])),
                            first_time &&
                                    uid ==
                                        FirebaseAuth.instance.currentUser!.uid
                                ? Container(
                                    width: 110,
                                    height: 40,
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                            color: Colors.deepPurpleAccent,
                                            width: 1.5)),
                                    child: GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        padding:
                                            EdgeInsets.fromLTRB(7, 5, 8, 5),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Update",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1.5,
                                                      color: Colors
                                                          .deepPurpleAccent))
                                            ]),
                                      ),
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Updating Data')),
                                          );

                                          await update_profile(
                                              linkedin_url.text,
                                              leetcode_url.text,
                                              codechef_url.text,
                                              github_url.text);
                                        }
                                      },
                                    ),
                                  )
                                : Container(),
                          ]);
                        } else {
                          if (snapshot.data?.data() == null) return Text("pp");
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Container(child: fun(data));
                        }
                      })),

              PersonalContainer("Following", ""),
              Following(uid),
              PersonalContainer("Followers", ""),
              Followers(uid),
              PersonalContainer("Contributed", "Articles"),
              PersonalData("contributed", lim1, 0, uid),
              PersonalContainer("Saved", "Articles"),
              PersonalData("liked", lim2, 1, uid),
              GestureDetector(
                  child: Text("logout"),
                  onTap: () {
                    logout();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authentication()));
                  }),
              Container(
                margin: EdgeInsets.only(bottom: 15),
              )
            ])))));
  }
}

//
Following(String fac) {
  // String fac = FirebaseAuth.instance.currentUser!.uid;
  Color color = Colors.pink;
  int count = 0;
  return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Auth_Users')
              .where('follow', arrayContains: fac)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Container();
            //////

            //  if (count == 0) return Text("No one Following...");
            //  var user = FirebaseAuth.instance.currentUser!.displayName;
            return Container(
                child: Column(children: [
              Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  count++;
                  return GestureDetector(
                      child: Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                offset: Offset(5, 2),
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: Colors.grey.shade300)
                          ]),
                          child: Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 30),
                                child: ClipRRect(
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: document['photourl'] == ''
                                        ? Icon(Icons.account_circle,
                                            size: 60,
                                            color: Colors.grey.shade600)
                                        : Image(
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                document['photourl'])),
                                  ),
                                  borderRadius: BorderRadius.circular(200),
                                )),
                            Container(
                              width: 150,
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                document['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.deepPurple),
                              ),
                            )
                          ]),
                          width: MediaQuery.of(context).size.width - 50,
                          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                          margin: EdgeInsets.fromLTRB(0, 4, 0, 4)),
                      onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Personal(
                                      document['uid'],
                                      document['name'],
                                      document['photourl'])),
                            )
                          });
                }).toList(),

                //  flag == false ? Text("NO data") : Container()
              ),
              count == 0 ? Text("No one Following...") : Text("")
            ]));
          }));
}

help(List follow) {
  return follow.map((e) => Container(child: Finding(e))).toList();
}

Finding(var e) {
  return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Auth_Users')
              .where('uid', isEqualTo: e)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Container();
            //////
            //  var user = FirebaseAuth.instance.currentUser!.displayName;
            return Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return GestureDetector(
                    child: Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  offset: Offset(5, 2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.grey.shade300)
                            ]),
                            child: Row(children: [
                              Container(
                                  margin: EdgeInsets.only(left: 30),
                                  child: ClipRRect(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: document['photourl'] == ''
                                          ? Icon(Icons.account_circle,
                                              size: 60,
                                              color: Colors.grey.shade600)
                                          : Image(
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  document['photourl'])),
                                    ),
                                    borderRadius: BorderRadius.circular(200),
                                  )),
                              Container(
                                width: 150,
                                child: Text(
                                  document['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.deepPurple),
                                ),
                              )
                            ]),
                            width: MediaQuery.of(context).size.width - 50,
                            padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 4));
                      }).toList(),
                    ),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Personal(document['uid'],
                                    document['name'], document['photourl'])),
                          )
                        });
              }).toList(),
            );
            //  flag == false ? Text("NO data") : Container()
          }));
}

Followers(String fac) {
  // String fac = FirebaseAuth.instance.currentUser!.uid;
  int count = 0;
  return Container(
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Auth_Users')
              .where('uid', isEqualTo: fac)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Column(children: [
              Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  document['follow'].map((e) => count++);
                  List doc = document['follow'];
                  for (int i = 0; i < doc.length; i++) {
                    count++;
                  }
                  return Column(children: help(document['follow']));
                }).toList(),
              ),
              count == 0 ? Text("No Followers...") : Text("")
            ]);
          }));
}

PersonalContainer(String s, String uid) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
    //   width: MediaQuery.of(context).size.width - 95,
    child: Text(
      "$s $uid",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.pink,
      ),
    ),
  );
}

mink(bool lim1, String fac) async {
  var c = await FirebaseFirestore.instance
      .collection('Contributed')
      .doc(fac)
      .collection(fac)
      .orderBy('timestamp', descending: true)
      .limit(lim1 == true ? 3 : 100)
      .snapshots()
      .length;
  return c;
}

Future finder(bool lim1, String fac) async {
  var k = await FirebaseFirestore.instance
      .collection('Contributed')
      .doc(fac)
      .collection(fac)
      .orderBy('timestamp', descending: true)
      .limit(lim1 == true ? 3 : 100)
      .snapshots();
  return k.length;
}

finder1() async {
  var data = await finder(true, FirebaseAuth.instance.currentUser!.uid);
  return data;
}
