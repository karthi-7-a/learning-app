import 'package:Productin/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'opening.dart';

class Authentication extends StatefulWidget {
  // Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  bool flag = false;
  String verify = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //
        home: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Create Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
                child: Text(verify,
                    style: TextStyle(
                      color: Colors.blue,
                    ))),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                cursorColor: Colors.white,
                //    autofocus: true,
                style: TextStyle(color: Colors.white),
                controller: _username,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  hintText: "Name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailField,
                decoration: InputDecoration(
                  hintText: "something@email.com",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _passwordField,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    String shouldNavigate = await register(
                        _emailField.text, _passwordField.text, _username.text);
                    print(shouldNavigate);
                    if (shouldNavigate == "True") {
                      setState(() {
                        verify = 'Verification Email Sent!';
                      });
                      _emailField.text = '';
                      _passwordField.text = '';
                      _username.text = '';
                    } else {
                      setState(() {
                        verify = shouldNavigate;
                      });
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already an user? ",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    GestureDetector(
                        child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signin(),
                            ),
                          );
                        })
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}

class Signin extends StatefulWidget {
  // Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  String verify = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //
      home: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                  child: Text(verify,
                      style: TextStyle(
                        color: Colors.blue,
                      ))),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  //    autofocus: true,
                  style: TextStyle(color: Colors.white),
                  controller: _emailField,
                  decoration: InputDecoration(
                    hintText: "something@email.com",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    String shouldNavigate = await signin(
                        _emailField.text, _passwordField.text, _username.text);
                    print(shouldNavigate == "False");
                    if (shouldNavigate == "True") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    } else if (shouldNavigate == "False") {
                      setState(() {
                        verify = 'Kindly verify your email!';
                      });
                    } else {
                      setState(() {
                        verify = shouldNavigate;
                      });
                    }
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New user? ",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      GestureDetector(
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Authentication(),
                              ),
                            );
                          })
                    ],
                  ))
            ])),
      ),
    );
  }
}
