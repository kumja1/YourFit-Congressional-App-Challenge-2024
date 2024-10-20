import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Event {}

@RoutePage()
class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  String selectedTimePeriod = '1 week';
  double dailyCalorieBurn = 800;
  String selectedMetric = 'Calorie burn';
  double dailyMilesRan = 6;
  CalendarFormat _calenderFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Date'),
            content: const Text('Did you exercise on this day??'),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCalorieBurn = dailyCalorieBurn *
        (selectedTimePeriod == '1 week'
            ? 7
            : selectedTimePeriod == '1 month'
                ? 30
                : 365);

    double totalDistance = dailyMilesRan *
        (selectedTimePeriod == '1 week'
            ? 7
            : selectedTimePeriod == '1 month'
                ? 30
                : 365);
    final numberFormat = NumberFormat("#,##0", "en_US");
    String formattedCalorieBurn = numberFormat.format(totalCalorieBurn.toInt());
    String formattedDistance = numberFormat.format(totalDistance.toInt());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roadmap'),
      ),
      body: SingleChildScrollView(
          child: Flexible(
        child: Column(
          children: [
            Container(
              width: 350,
              height: 160,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TableCalendar<Event>(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: _onDaySelected,
                    calendarFormat: _calenderFormat,
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(color: Colors.blue),
                      weekendTextStyle: const TextStyle(color: Colors.blueGrey),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () => _changeToCalenderView(),
                    icon: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Exercises",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/calorie_icon.png",
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            DropdownButton<String>(
                              value: selectedMetric,
                              dropdownColor: Colors.grey[300],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMetric = newValue!;
                                });
                              },
                              items: <String>[
                                'Calorie burn',
                                'Distance ran'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                            ),
                            Text(
                              ' will be: ${selectedMetric == 'Calorie burn' ? formattedCalorieBurn : formattedDistance} in ',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            DropdownButton<String>(
                              value: selectedTimePeriod,
                              dropdownColor: Colors.grey[100],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedTimePeriod = newValue!;
                                });
                              },
                              items: <String>[
                                '1 week',
                                '1 month',
                                '1 year'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  _changeToCalenderView() =>
      setState(() => _calenderFormat = _calenderFormat == CalendarFormat.week
          ? CalendarFormat.month
          : CalendarFormat.week);
}
