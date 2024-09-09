import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/reservation_screen.dart';
import '../screens/QRCodeScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
    

      },
    );
  }
}
