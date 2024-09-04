// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:iller_ilceler_proje/main_page.dart';

void main() {
  runApp(const MainAppPage());
}

class MainAppPage extends StatelessWidget {
  const MainAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}
