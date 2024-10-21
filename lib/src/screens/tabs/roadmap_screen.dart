import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@RoutePage()
class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({super.key});

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  String selectedTimePeriod = '1 week';
  double dailyCalorieBurn = 800;
  String selectedMetric = 'Calorie burn';
  double dailyMilesRan = 6;

  final _calorieController = TextEditingController();
  final _milesController = TextEditingController();

  @override
  void dispose() {
    _calorieController.dispose();
    _milesController.dispose();
    super.dispose();
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
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Exercises",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Flexible(
              child: Center(
                child: Container(
                  width: 350,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _calorieController,
                        decoration: const InputDecoration(
                          labelText: 'Daily Calorie Burn',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            dailyCalorieBurn =
                                double.tryParse(value) ?? dailyCalorieBurn;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _milesController,
                        decoration: const InputDecoration(
                          labelText: 'Daily Miles Ran',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            dailyMilesRan = double.tryParse(value) ?? dailyMilesRan;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                        style: const TextStyle(
                                            color: Colors.black)),
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
                                        style: const TextStyle(
                                            color: Colors.black)),
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
            ),
          ],
        ),
      ),
    );
  }
}
