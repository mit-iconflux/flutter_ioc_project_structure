import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class CustomDialogView {
  Future<int?> showDialogCustom({
    required BuildContext context,
    required String title,
    required String content,
    bool isSingleButton = false,
    bool barrierDismissible = true,
    bool onWillPop = false,
    String positiveButtonText = 'Ok',
    String negativeButtonText = 'Cancel',
  }) {
    return showDialog<int>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => onWillPop,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Spacings.custom15),
              topLeft: Radius.circular(Spacings.custom15),
              bottomRight: Radius.circular(Spacings.custom15),
              bottomLeft: Radius.circular(Spacings.custom15),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: Spacings.small,
                  horizontal: Spacings.custom15,
                ),
                child: TextLabel(
                  text: title,
                  textStyle: TextStyles.subtitle(color: Palette.primaryColor),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: Spacings.small,
                  horizontal: Spacings.custom15,
                ),
                child: TextLabel(
                  text: content,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: Spacings.small,
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.all(Spacings.small),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(
                      Spacings.custom5,
                    ),
                    bottom: Radius.circular(
                      Spacings.custom5,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, 0);
                        },
                        child: Center(
                          child: TextLabel(
                            text: positiveButtonText,
                          ),
                        ),
                      ),
                    ),
                    if (!isSingleButton)
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white,
                      ),
                    if (!isSingleButton)
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context, 1);
                          },
                          child: Center(
                            child: TextLabel(
                              text: negativeButtonText,
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
    );
  }
}
