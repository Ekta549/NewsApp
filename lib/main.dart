import 'package:flutter/material.dart';
import 'package:news_application/pages/home.dart';
import 'package:news_application/pages/landing_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const LandingPage(), // Set the initial route to LandingPage
      routes: {
        '/home': (context) => const Home(),
      },
    );
  }
}

class NavigatorKeys {
  static final GlobalKey<NavigatorState> rootNavigationKey =
      GlobalKey<NavigatorState>();
}
