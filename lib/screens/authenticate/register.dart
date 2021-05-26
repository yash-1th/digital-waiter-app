import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Sign up to Brew Crew'),
              elevation: 0.0,
              // actions: <Widget>[
              //   FlatButton.icon(
              //       onPressed: widget.toggleView,
              //       icon: Icon(Icons.person),
              //       label: Text('Sign in'))
              // ],
               actions: <Widget>[
                TextButton.icon(
                    onPressed: widget.toggleView,
                    icon: Icon(Icons.person),
                    label: Text('Sign in'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputdecoration.copyWith(hintText: 'Email'),
                        validator: (value) =>
                            value.isEmpty ? 'Enter email' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputdecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (value) => value.length < 6
                            ? 'Enter password with atleast 6 characters'
                            : null,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          child: Text('Sign up'),
                          // color: Colors.pink,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with these credentials';
                                });
                              }
                            }
                          }),
                      SizedBox(height: 20.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
