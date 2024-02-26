import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionCodeWidget extends StatelessWidget {
  const VersionCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacings.medium),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FutureBuilder<String?>(
          future: getVersionCode(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              return TextLabel(
                text: snapshot.data ?? '',
                textStyle: TextStyles.normal(color: Palette.whiteColor),
              );
            } else {
              return const SizedBox(
                height: 75,
                width: 75,
              );
            }
          },
        ),
      ),
    );
  }
}

Future<String?> getVersionCode() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
