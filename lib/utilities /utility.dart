import 'dart:developer';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class Utility {
  static void showLog(String value, {String key = 'Result'}) {
    if (kDebugMode) {
      log('$key : $value');
    }
  }

  static RegExp getEmailRegExp() {
    return RegExp(
      r'''
^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$''',
    );
  }

  static bool isValidEmail(String email) {
    return getEmailRegExp().hasMatch(email);
  }

  static void showCenterFlash({
    required String message,
    FlashPosition position = FlashPosition.top,
    FlashBehavior style = FlashBehavior.floating,
    bool isIcon = false,
    bool isSuccess = false,
    int duration = 3,
    GlobalKey? key,
    required BuildContext context,
  }) {
    context.showFlash(
      duration: Duration(seconds: duration),
      barrierDismissible: true,
      builder: (BuildContext _, FlashController<dynamic> controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flash<dynamic>(
              controller: controller,
              position: FlashPosition.bottom,
              child: Padding(
                padding: const EdgeInsets.all(Spacings.xLarge),
                child: Wrap(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: isSuccess
                            ? Palette.toastSuccess
                            : Palette.toastError,
                      ),
                      padding: const EdgeInsets.all(Spacings.large / 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (isIcon)
                            const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.warning,
                                color: Palette.whiteColor,
                                size: 18,
                              ),
                            ),
                          Expanded(
                            child: TextLabel(
                              text: message,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              textStyle: TextStyles.normalMedium(
                                color: Palette.whiteColor,
                                decoration: TextDecoration.none,
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
          ],
        );
      },
    );
  }
}
