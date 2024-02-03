import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:valentines/pages/home_page.dart';

void main() {
  runApp(const Valentines());
}

class Valentines extends StatefulWidget {
  const Valentines({super.key});

  @override
  State<Valentines> createState() => _ValentinesState();
}

class _ValentinesState extends State<Valentines> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      const ApplicationSwitcherDescription(label: "Valentines"),
    );

    return _buildApp();
  }

  MaterialApp _buildApp() {
    return const MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
