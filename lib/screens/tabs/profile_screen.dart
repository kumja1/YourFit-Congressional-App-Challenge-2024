import 'package:flutter/material.dart';
import 'package:yourfit/services/functions/index.dart';
import 'package:yourfit/utils/constants.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    late AuthService _authService = getIt<AuthService>();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        CircleAvatar(
            maxRadius: 55,
            backgroundColor: Color.fromARGB(64, 197, 199, 200),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(235, 227, 227, 0),
              maxRadius: 50,
              child: Icon(
                Icons.account_circle,
                color: Color.fromARGB(255, 134, 130, 130),
                size: 52.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            )),
        SizedBox(height: 16),
        Text(
          'Mr Sigma',
          style: TextStyle(fontSize: 24),
        ),
        Text('@sigma99',
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center),
        SizedBox(height: 16),
        Text(
          "Overview",
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          'Achievements',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Ranks',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ListTile(
          title: Text('NAME'),
          subtitle: Text('@USERNAME'),
          leading: Icon(Icons.looks_one),
        ),
        ListTile(
          title: Text('NAME2'),
          subtitle: Text('@USERNAME2'),
          leading: Icon(Icons.looks_two),
        )
      ],
    ));
  }
}
