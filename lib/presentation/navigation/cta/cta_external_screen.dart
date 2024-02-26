import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/cta/cta_model.dart';

class CTAExternalScreen extends StatelessWidget {
  const CTAExternalScreen({Key? key, required this.cta}) : super(key: key);
  final CTAModel cta;

  @override
  Widget build(BuildContext context) {
    //TODO: iOS USE IOC HERE
    return Container();
    /*return Consumer<IOC>(
      builder: (context, ioc, _) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          final urlOpener = ioc.getDependency<UrlOpener>();
          if (cta.type == CTAType.web) {
            urlOpener.openUrl(cta.url);
          } else if (cta.type == CTAType.externalApp) {
            if (Platform.isIOS) {
              urlOpener.launchUniversalLinkIos(cta.url);
            } else {
              urlOpener.openUrl(cta.url);
            }
          }
          Navigator.pop(context);
        });
        return Container();
      },
    );*/
  }
}
