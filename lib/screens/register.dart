import 'package:flutter/material.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/login.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _pass = FocusNode();
  final _cpass = FocusNode();
  final pass = TextEditingController();

  final formkey = GlobalKey<FormState>();
  var isLoading = false;
  Map<String, String> _authData = {'email': '', 'password': ''};
  Future<void> _saveForm() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      setState(() {
        isLoading = true;
      });

      try {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Account Created Successfully',
            style: TextStyle(fontSize: 15),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.teal,
        ));

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));

      } catch (error) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            error.toString(),
            style: TextStyle(fontSize: 15),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Card(
                          elevation: 10,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text(
                                "SIGN UP",
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
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_pass);
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
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: "Email Address",
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextFormField(
                                  onSaved: (value) {
                                    _authData['password'] = value;
                                  },
                                  focusNode: _pass,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_cpass);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password Cannot be empty';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  cursorColor: Colors.black,
                                  controller: pass,
                                  decoration: InputDecoration(
                                    labelText: "Create Password",
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2),
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
                                  focusNode: _cpass,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password Cannot be empty';
                                    }
                                    if (value != pass.text) {
                                      return "Password's dont match";
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) {},
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    labelStyle: TextStyle(color: Colors.black),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              (isLoading)
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 130, vertical: 14),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        _saveForm();
                                      },
                                      child: Text(
                                        'Sign UP',
                                        style: TextStyle(color: Colors.white),
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
                          Text("Already a user?",
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen()));
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
