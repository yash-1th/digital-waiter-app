import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = [
    '0',
    '1',
    '2',
    '3',
    '4',
  ];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputdecoration,
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a name' : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputdecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _currentSugars = value),
                  ),
                  Slider(
                    value: (_currentstrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentstrength ?? 100],
                    inactiveColor: Colors.brown[_currentstrength ?? 100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentstrength = val.round()),
                  ),
                  ElevatedButton(
                    // color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentstrength);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
