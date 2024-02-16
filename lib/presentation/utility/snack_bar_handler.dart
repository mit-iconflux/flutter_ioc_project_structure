import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';

class SnackBarHandler {
  SnackBarHandler({required this.context});

  final BuildContext context;

  void showSnackBar(
      {required String message,
      required Color color,
      FlashPosition position = FlashPosition.bottom,
      FlashBehavior style = FlashBehavior.floating,
      int duration = 4,
      Key? key,
      double? width}) {
    showFlash(
      context: context,
      duration: Duration(seconds: duration),
      // ignore: always_specify_types
      builder: (_, FlashController controller) {
        // ignore: always_specify_types
        return Flash(
          key: key,
          controller: controller,
          position: position,
          child: SizedBox(
            width: width ?? MediaQuery.of(context).size.width * 0.96,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                message,
                style: const TextStyle(
                    color: CupertinoColors.tertiarySystemBackground),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
