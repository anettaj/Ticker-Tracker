import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/EarningsProvider.dart';
import 'Views/HomeScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EarningsProvider()),
      ],
      child: EarningsApp(),
    ),
  );
}

class EarningsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticker Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
