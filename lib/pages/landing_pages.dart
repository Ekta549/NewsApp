import 'package:flutter/material.dart';
import 'package:news_application/main.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandinPageState();
}

class _LandinPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(children: [
          Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                "assets/images/building1.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.9,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "News from around the\n       world for you",
            style: TextStyle(
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Best time to read, take your time to read\n           a little more of this world",
            style: TextStyle(
                color: Colors.black45,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 5.0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 73, 162, 236),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      NavigatorKeys.rootNavigationKey.currentState
                          ?.pushReplacementNamed('/home');
                    },
                    child: const Text('Get Started'),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
