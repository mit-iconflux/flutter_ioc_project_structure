import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({
    Key? key,
    this.message = 'Loading...',
    this.isCard = true,
    this.isCurve = false,
    this.color = Colors.white,
    this.isOpacity = false,
    this.height,
    this.width,
  }) : super(key: key);

  String message = '';
  bool isCard = false;
  Color color;
  bool isOpacity = false;
  bool isCurve = false;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return isCard
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isCurve ? 20 : 0),
                topRight: Radius.circular(isCurve ? 20 : 0),
              ),
            ),
            height: height ?? MediaQuery.of(context).size.height,
            width: width ?? MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: width == null
                    ? MediaQuery.of(context).size.width * 0.5
                    : width! * 0.5,
                height: height == null
                    ? MediaQuery.of(context).size.height * 0.25
                    : height! * 0.25,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Palette.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextLabel(
                          text: message,
                          textAlign: TextAlign.center,
                          textStyle: TextStyles.normal(
                            color: Palette.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.primaryColor),
              ),
            ),
          );
  }
}
