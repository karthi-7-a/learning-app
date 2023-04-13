import 'package:flutter/material.dart';
import 'package:Productin/Personal.dart';
import 'package:Productin/main.dart';
import 'package:Productin/user_image.dart';
import 'child.dart';
import 'contribute.dart';
import 'package:Productin/search.dart';

class Grand_child extends StatelessWidget {
  var doc;
  Grand_child(this.doc);
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
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 15, 5),
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Icon(
                                            Icons.arrow_left_outlined,
                                            color: Colors.white,
                                          ),
                                          Text("Back",
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ]),
                                      ),
                                      onTap: () => Navigator.pop(context)),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(doc['format'],
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green)),
                                        Row(children: [
                                          Text("By ",
                                              style: TextStyle(fontSize: 16)),
                                          Text(
                                            doc['user'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.pink),
                                          ),
                                        ])
                                      ])
                                ]),
                            Grand_child_widget(doc, 'Title', doc['titletext']),
                            Grand_child_widget(doc, 'Summary', doc['summary']),
                            Padding(
                              child: Find(doc['imageurl']),
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Grand_child_widget(doc, 'Article', doc['text']),
                          ],
                        ))))));
  }
}

class Find extends StatelessWidget {
  List? images;
  Find(this.images);
  List<Widget> list = [];
  find(double k) {
    for (String i in images!) {
      list.add(
          // AppRoundImage.url(
          //   i,
          //   width: 100,
          //   height: k,
          //   selected: true,
          // ),
          Container(
              margin: EdgeInsets.only(top: 15),
              child: myImage(NetworkImage(i), k)));
    }
  }

  @override
  Widget build(BuildContext context) {
    find(MediaQuery.of(context).size.width - 50);
    return Column(
      children: list,
    );
  }
}

myImage(var k, var size) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image(
      image: k,
      width: size,
    ),
  );
}

class Grand_child_widget extends StatelessWidget {
  var doc;
  String? text, title;
  Grand_child_widget(this.doc, this.title, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            title!,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.pink,
            ),
          ),
        ]),
      ),
      Container(
        width: MediaQuery.of(context).size.width - 30,
        padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
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
        child: Text(
          text!,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(12, 12, 12, 100),
              letterSpacing: 1.15,
              height: 1.75,
              wordSpacing: 1.15),
        ),
      )
    ]);
  }
}
