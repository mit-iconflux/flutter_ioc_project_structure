import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';
import 'package:ioc_demo/presentation/widgets/custom_widgets/custom_card_view.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key, this.msg, this.funRetry});

  final String? msg;
  final Function()? funRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: customCardView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: funRetry != null ? 1 : 2,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      // child: ImageAssets.noDataFound(),
                      child: Icon(Icons.warning),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          child: TextLabel(
                            text: msg ?? 'No Data Found',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (funRetry != null)
                          Container(
                            alignment: Alignment.topCenter,
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: InkWell(
                              onTap: () {
                                funRetry!();
                              },
                              child: SizedBox(
                                width: 150,
                                height: 50,
                                child: Card(
                                  color: Theme.of(context).primaryColor,
                                  elevation: 3,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: TextLabel(
                                      text: 'Retry',
                                      textStyle: TextStyles.normal(
                                          color: Palette.whiteColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
