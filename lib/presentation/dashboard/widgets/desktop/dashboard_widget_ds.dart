import 'package:flutter/material.dart';

class DashboardWidgetDs extends StatelessWidget {
  const DashboardWidgetDs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Welcome to the Test Desktop Screen')));
  }
}
