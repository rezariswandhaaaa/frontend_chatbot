import 'package:flutter/material.dart';
import 'package:my_project/ui/landingpage.dart';



void main() {
  runApp(ChatAIApp());
}

class ChatAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat AI',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
