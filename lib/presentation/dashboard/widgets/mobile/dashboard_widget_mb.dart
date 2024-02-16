import 'package:flutter/material.dart';

class DashboardWidgetMb extends StatelessWidget {
  const DashboardWidgetMb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Welcome to the Test Mobile Screen')));
  }
}
