import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Productin/child.dart';

import 'main.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController edit = TextEditingController();
  bool m = false;
  int count = 0;
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
                  Container(
                    child: TextField(
                      //   autofocus: true,
                      controller: edit,
                      decoration: InputDecoration(
                          labelText: "Search",
                          fillColor: Colors.pink,
                          labelStyle: TextStyle(color: Colors.pink),
                          focusColor: Colors.purple),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  GestureDetector(
                    child: Container(
                        height: MediaQuery.of(context).size.width / 8,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.deepPurple,
                              Colors.deepPurpleAccent
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        //  padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                        alignment: Alignment.centerLeft,
                        child: Center(
                            child: Text("Search",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white)))),
                    onTap: () => setState(() {
                      m = true;
                    }),
                  ),
                  m == false
                      ? Container()
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) return new Text("");
                            String fac = FirebaseAuth.instance.currentUser!.uid;

                            return Container(
                                child: Column(
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                              String v = document['text'],
                                  l = document['titletext'];
                              List m = document['liked'];

                              return (v.contains(edit.text) ||
                                          l.contains(edit.text)) &&
                                      edit.text.length != 0
                                  ? Class1(document, false, m.contains(fac))
                                  : Container();
                            }).toList()));
                          }),
                ])))));
  }
}

class SearchItem extends StatefulWidget {
  String? s;
  SearchItem(this.s);
  @override
  _SearchItemState createState() => _SearchItemState(s);
}

class _SearchItemState extends State<SearchItem> {
  String? s;
  _SearchItemState(this.s);
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("pp"));
  }
}
