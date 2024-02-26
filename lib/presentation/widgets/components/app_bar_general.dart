import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class AppBarGeneral extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGeneral({
    Key? key,
    required this.title,
    this.description,
    this.hideBackButton = false,
    this.onBackPress,
    this.actions,
  }) : super(key: key);
  final String title;
  final bool hideBackButton;
  final String? description;
  final VoidCallback? onBackPress;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Palette.whiteColor,
      child: Column(
        children: <Widget>[
          AppBar(
            leading: hideBackButton
                ? null
                : GestureDetector(
                    onTap: onBackPress ??
                        () {
                          AppNavigator().pop();
                        },
                    child: Icon(Icons.arrow_back_outlined),
                  ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextLabel(
                  text: title,
                  textStyle: TextStyles.subtitle(),
                )
              ],
            ),
            actions: actions,
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(
                left: Spacings.medium,
                right: Spacings.medium,
              ),
              child: TextLabel(
                text: description!,
                textStyle: TextStyles.normal(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
