import 'package:flutter/material.dart';

import 'routes/application_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      /* home: const MyHomePage(title: 'Flutter Demo Home Page'), */
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      initialRoute: '/',
    );
  }
}