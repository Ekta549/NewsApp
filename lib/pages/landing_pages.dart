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
      backgroundColor: Color.fromRGBO(233, 253, 179, 0.824),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 10.0),
        child: Column(children: [
          Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                "assets/images/news image.jpg",
                width: MediaQuery.of(context).size.width / 1.0,
                height: MediaQuery.of(context).size.height / 1.7,
                fit: BoxFit.fitWidth,
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                NavigatorKeys.rootNavigationKey.currentState
                    ?.pushReplacementNamed('/home');
              },
              child: const Text('Get Started'),
            ),
          ),
        ]),
      ),
    );
  }
}
