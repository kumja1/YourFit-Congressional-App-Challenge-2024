import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourfit/src/services/functions/index.dart';
import 'package:yourfit/src/services/models/index.dart';
import 'package:yourfit/src/utils/functions.dart';

import '../../utils/constants.dart';

@RoutePage()
class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  late UserData _user = getIt<AuthService>().currentUser!;
  late FitnessLLMService _fitnessService = getIt<FitnessLLMService>();
  late double dailyMilesRan;
  late double dailyCalorieBurn;
  late double calBurn;
  int consecutiveDaysOpened = 0;
  DateTime _focusedDay = DateTime.now();

  final Map<String, int> timePeriodToDays = {
    '1 week': 7,
    '2 weeks': 14,
    '3 weeks': 21,
    '1 month': 30,
    '2 months': 60,
    '3 months': 90,
    '6 months': 180,
  };
  String selectedTimePeriod = '1 week';

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    dailyMilesRan = _user.milesTraveled;
    dailyCalorieBurn = dailyMilesRan * 100;
    calBurn = _user.caloriesBurned;
  }

  Future<void> _checkLastGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    final lastGenerationDateString = prefs.getString('lastGeneration');
    var now = DateTime.now();
    var nowString = "${now.year}/${now.month}${now.day}";
    print('lastOpenedDateString: $lastGenerationDateString');
      if (lastGenerationDateString == null || (lastGenerationDateString != null && now.isAfter(DateTime.tryParse(lastGenerationDateString ?? "")!))) {
        var response = await _getResponse();
        if (response == null) {
          _displayErr();
          return;
        }
        _user.exerciseData[nowString] = {
          "day": response["day"],
          "exercises":
              response["exercises"].map((obj) => Exercise.fromJson(obj)),
          "totalCaloriesBurned": response["totalCaloriesBurned"]
        };
        
        await prefs.setString("lastGeneration", nowString);
      }
  }

  @override
  Widget build(BuildContext context) {
    final totalCalorieBurn =
        dailyCalorieBurn * timePeriodToDays[selectedTimePeriod]!;
    final totalMilesRan =
        dailyMilesRan * timePeriodToDays[selectedTimePeriod]!; //  total miles

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Roadmap'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  width: 360,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: TableCalendar(
                    calendarFormat: CalendarFormat.week,
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2024, 10, 1),
                    lastDay: DateTime.utc(2024, 10, 20),
                    selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
                    onDaySelected: (day, focusedDay) {
                      if (!isSameDay(focusedDay, day)) {
                        setState(() => _focusedDay = day);
                      }
                    },
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 1,
                  right: 4,
                  child: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Overview",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/calorie_icon.png',
                                    width: 20),
                                Text('$consecutiveDaysOpened'),
                                //Image.asset('assets/images/running_icon.png', width: 2
                              ],
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/running_icon.png',
                                width: 20),
                            const SizedBox(width: 10),
                            Text('$dailyMilesRan'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: 360,
                    height: 170,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: const Color.fromARGB(255, 84, 83, 83)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Daily Goal',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: selectedTimePeriod,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedTimePeriod = newValue!;
                                    });
                                  },
                                  items: timePeriodToDays.keys
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'if you keep your goal for ${selectedTimePeriod.toLowerCase()} then you'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'should burn ${totalCalorieBurn.toInt()} kcal and run ${totalMilesRan.toInt()} miles'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _getResponse() async {
    if (!await _hasInternet()) return null;
    var response =
        _fitnessService.responseToJson((await _fitnessService.invokeWithUser(
      _user,
      "Give a 1 day exercise plan for the user",
      onError: (err) => _displayErr(),
    ))!);

    return response;
  }

  Future<bool> _hasInternet() async {
    var result = await InternetAddress.lookup("example.com");
    if (result.isEmpty || result[0].rawAddress.isEmpty) {
      _displayErr();
      return false;
    }
    return true;
  }

  _displayErr() => showSnackBar(
      _scaffoldKey.currentContext!,
      AnimatedSnackBarType.error,
      "Could not generate exercises. Try again later.");
}
