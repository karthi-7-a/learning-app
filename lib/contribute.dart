import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Productin/Personal.dart';
import 'package:Productin/main.dart';
import 'package:Productin/user_image.dart';
import 'package:provider/provider.dart';
import 'child.dart';
import 'package:Productin/search.dart';

import 'flutterfire.dart';

class Contribute extends StatefulWidget {
  const Contribute({Key? key}) : super(key: key);

  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  TextEditingController edit = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController edit_head = TextEditingController();
  final keyText = GlobalKey();
  Offset? pos;
  Size? size;
  final _formKey = GlobalKey<FormState>();

  void cal() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final RenderBox box =
          keyText.currentContext!.findRenderObject()! as RenderBox;
      setState(() {
        pos = box.localToGlobal(Offset.zero);
        size = box.size;
      });
    });
  }

  List images = [];
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
  List arr1 = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ChangeNotifierProvider(
            create: (context) => change(),
            child: Container(
                child: Column(children: [
              Consumer<change>(builder: (context, t, child) {
                return Expanded(
                    child: MaterialApp(
                        home: Scaffold(
                            persistentFooterButtons: [
                      SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: nav_bottom(3))
                    ],
                            backgroundColor: Color.fromRGBO(255, 255, 255, 5),
                            appBar: AppBar(
                                toolbarHeight: 60,
                                backgroundColor:
                                    Color.fromRGBO(161, 0, 27, 100),
                                title: Center(
                                    child: Row(children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          60,
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
                                          MaterialPageRoute(
                                              builder: (context) => Search()),
                                        );
                                      })
                                ]))),
                            body: SingleChildScrollView(
                                child: Container(
                                    child: Column(children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                  child: Text(
                                    "Want to Contribute",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.15,
                                        color: Colors.green),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Container(
                                        //color: Colors.white,
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding:
                                            EdgeInsets.fromLTRB(30, 5, 30, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(5, 2),
                                                  blurRadius: 2,
                                                  spreadRadius: 2,
                                                  color: Colors.grey.shade300)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: DropdownButton<String>(
                                          value: t.text,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 4,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            t.changing(newValue!);
                                          },
                                          items: arr
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Center(
                                                  child: Text(
                                                value,
                                                style: TextStyle(fontSize: 16),
                                                textAlign: TextAlign.center,
                                              )),
                                            );
                                          }).toList(),
                                        ),
                                      ),

                                      Text(
                                        "Heading",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.pink),
                                      ),
                                      // Article(1, 3, edit_head, 'heading'),
                                      Container(
                                          margin: EdgeInsets.all(10),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: TextFormField(
                                              toolbarOptions: ToolbarOptions(
                                                  copy: true,
                                                  cut: true,
                                                  paste: true,
                                                  selectAll: true),
                                              cursorColor:
                                                  Colors.deepPurpleAccent,
                                              minLines: 1,
                                              maxLines: 3,
                                              enabled: true,
                                              validator: (e) => validator(e),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textInputAction:
                                                  TextInputAction.newline,
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 20),
                                              controller: edit_head,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Type your article  here',
                                                //  focusedBorder: InputBorder(borderSide: Border.fromBorderSide(side)),
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(5, 2),
                                                    blurRadius: 2,
                                                    spreadRadius: 2,
                                                    color: Colors.grey.shade300)
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      Text(
                                        "Summary",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.pink),
                                      ),

                                      Article(2, 4, summary, 'summary'),
                                      Text(
                                        "Article-Body",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.pink),
                                      ),

                                      Article(5, 100, edit, 'body'),

                                      Column(
                                          children: arr1.map((l) {
                                        return UserImage1(
                                            onFileChanged: (i) {
                                              setState(() {
                                                images.add(i);
                                              });
                                            },
                                            s: false);
                                      }).toList()),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
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
                                                  offset: Offset(2, 2),
                                                  blurRadius: 2,
                                                  spreadRadius: 2,
                                                  color: Colors.grey.shade300)
                                            ],
                                          ),
                                          child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  arr1.add(1);
                                                });
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.add,
                                                        color: Colors.green),
                                                    Text(
                                                      "Add image",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.green),
                                                    ),
                                                  ]))),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        width: // MediaQuery.of(context).viewInsets,
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                                offset: Offset(2, 2),
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                                color: Colors.grey.shade300)
                                          ],
                                        ),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                        Text('Updating Data')),
                                              );
                                              bool shouldNavigate =
                                                  await contribute(
                                                      t.text,
                                                      edit.text,
                                                      edit_head.text,
                                                      summary.text,
                                                      images);
                                              if (shouldNavigate) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyApp(),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: Text(
                                            "Contribute...",
                                            style: TextStyle(
                                                letterSpacing: 1.5,
                                                fontSize: 18,
                                                color: Colors.green),
                                          ),
                                        ),
                                      ),

                                      // Text(dropdownValue)
                                    ],
                                  ))
                            ]))))));
              })
            ]))));
  }
}

class change extends ChangeNotifier {
  String text = "Arrays";
  void changing(String news) {
    text = news;
    print(text);
    notifyListeners();
  }
}

validator(var e) {
  if (e == "") return "Should not be empty";
}

Widget Article(int min, int max, var contr, String head_body) {
  return Container(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          toolbarOptions: ToolbarOptions(
              copy: true, cut: true, paste: true, selectAll: true),
          cursorColor: Colors.deepPurpleAccent,
          minLines: min,
          maxLines: max,
          enabled: true,
          validator: (e) => validator(e),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          style: TextStyle(color: Colors.blue, fontSize: 20),
          controller: contr,
          decoration: InputDecoration(
            hintText: 'Type your article $head_body here',
            //  focusedBorder: InputBorder(borderSide: Border.fromBorderSide(side)),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(5, 2),
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.grey.shade300)
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)));
}
