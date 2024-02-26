import 'package:flutter/material.dart';
import 'package:ioc_demo/configurations/flavoring/flavor.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';
import 'package:ioc_demo/presentation/widgets/custom_widgets/app_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: TextLabel(
          text: 'Initial screen : ${flavor.name}',
        ),
      ),
    );
  }
}
