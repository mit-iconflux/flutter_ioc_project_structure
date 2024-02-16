import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/dashboard/widgets/desktop/dashboard_widget_ds.dart';
import 'package:ioc_demo/presentation/dashboard/widgets/mobile/dashboard_widget_mb.dart';
import 'package:ioc_demo/presentation/wrapper/os_wrapper.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return const OsWrapper(
        desktopWidget: DashboardWidgetDs(), mobileWidget: DashboardWidgetMb());
  }
}
