import 'package:flutter/material.dart';
import 'package:yourfit/services/functions/index.dart';
import 'package:yourfit/utils/constants.dart';

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  DateTime _selectedDate = DateTime.now();
  late AuthService _authService = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roadmap'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2.0)),
                constraints:
                    const BoxConstraints(maxHeight: 300.0, maxWidth: 500.0),
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  currentDate: _selectedDate,
                  onDateChanged: (DateTime newDate) {
                    if (newDate.isBefore(DateTime.now())) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('past date'),
                            content: const Text('past date info.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    }
                  },
                ),
              ),
            ),
            // Gray square with rounded corners and header
            Container(
              width: 300, // Increased width
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light gray background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity, // Stretch across full width
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[400], // Darker gray header
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Align(
                      // Align header text to the left
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Goals', // Header text
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Content of the panel with big body text
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '12', // Replace with your desired body text
                        style: TextStyle(
                          fontSize: 24, // Big font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("Today's Exercise's"),
          ],
        ),
      ),
    );
  }
}
