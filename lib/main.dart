import 'package:flutter/material.dart';
import 'package:news_application/pages/home.dart';
import 'package:news_application/pages/landing_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: NavigatorKeys.rootNavigationKey,
      initialRoute: '/landing', // Set the initial route to landing page
      routes: {
        '/home': (context) => const Home(),
        '/landing': (context) => const LandingPage(),
      },
    );
  }
}

class NavigatorKeys {
  static final GlobalKey<NavigatorState> rootNavigationKey =
      GlobalKey<NavigatorState>();
}
