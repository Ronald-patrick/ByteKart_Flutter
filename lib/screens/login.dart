import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/products_page.dart';
import 'package:shop_app/screens/register.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _pass = FocusNode();
  final formkey = GlobalKey<FormState>();
  var isLoading = false;
  Map<String, String> _authData = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    Future<void> _saveForm() async {
      if (formkey.currentState.validate()) {
        formkey.currentState.save();

        setState(() {
          isLoading = true;
        });

        try {
          await Provider.of<Auth>(context, listen: false)
              .login(_authData['email'], _authData['password']);

          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Logged In Success',
            style: TextStyle(fontSize: 15),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.teal,
        ));

        } catch (error) {
          print(error);
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.toString(),style: TextStyle(fontSize: 15),),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ));
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'ByteKart',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            new TextEditingController().clear();
          },
          child: Column(
            children: [
              Image.asset(
                'lib/logo.png',
                height: 250,
                alignment: Alignment.center,
                width: double.infinity,
              ),
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text(
                                      "SIGN IN",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          _authData['email'] = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Email Cannot be empty';
                                          }
                                          if (!value.contains('@')) {
                                            return 'Email is invalid';
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(_pass);
                                        },
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          labelText: "Email Address",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: TextFormField(
                                        obscureText: true,
                                        onSaved: (value) {
                                          _authData['password'] = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Password cannot be empty';
                                          }
                                          return null;
                                        },
                                        cursorColor: Colors.black,
                                        focusNode: _pass,
                                        decoration: InputDecoration(
                                          labelText: "Password",
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: FlatButton(
                                              onPressed: () {},
                                              child: Text('Forgot Password?')),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    (isLoading)
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          )
                                        : RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 130, vertical: 14),
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {
                                              _saveForm();
                                            },
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("I'm a new user."),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Register()));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
