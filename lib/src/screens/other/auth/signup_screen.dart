import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:onboarding/onboarding.dart';
import 'package:yourfit/src/widgets/sized_decorated_box.dart';

@RoutePage()
class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final List<Widget> _pages = [
    DetailsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        swipeableBody: _pages,
        buildFooter: (context, netDragDistance, pagesLength, currentIndex,
            setIndex, slideDirection) {
          return SizedDecoratedBox(
              height: 100,
              width: 600,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.elliptical(3, 3),
                      right: Radius.elliptical(3, 3))),
              child: BottomAppBar(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text(
                        "Back",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        if (currentIndex != 0) {
                          setIndex(currentIndex - 1);
                        }
                      },
                    ),
                    NiceButtons(
                      onTap: () {
                        if (currentIndex != pagesLength - 1) {
                          setIndex(currentIndex + 1);
                        }
                      },
                      stretch: false,
                      borderRadius: 10,
                      startColor: Colors.blue,
                      endColor: Colors.blue,
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late TextEditingController _age;
  late TextEditingController _height;
  late TextEditingController _name;
  late TextEditingController _weight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter details",
            style: TextStyle(fontSize: 30),
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Age"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Weight"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Height"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Name"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _age = TextEditingController();
    _height = TextEditingController();
    _weight = TextEditingController();
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _age.dispose();
    _name.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }
}
