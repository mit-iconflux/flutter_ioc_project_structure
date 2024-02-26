import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/primary_header_container.dart';

class AppBarSmallLib extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSmallLib({
    Key? key,
    required this.title,
    this.color = Palette.whiteColor,
    this.isFromInnerClass = false,
  }) : super(key: key);
  final String title;
  final Color? color;
  final bool isFromInnerClass;

  @override
  Size get preferredSize => const Size.fromHeight(196);

  Size get innerPreferredSize => const Size.fromHeight(157);

  @override
  Widget build(BuildContext context) {
    return PrimaryHeaderContainer(
      height:
          isFromInnerClass ? innerPreferredSize.height : preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Spacings.medium),
        child: Container(
          alignment: Alignment.bottomCenter,
          constraints: const BoxConstraints(minHeight: 121),
          padding: const EdgeInsets.only(
            left: Spacings.medium,
            right: Spacings.medium,
            bottom: Spacings.large,
            top: Spacings.xxLarge,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: isFromInnerClass
                    ? TextStyles.subtitle(color: Palette.greyColor)
                    : color != null
                        ? TextStyles.subtitle(color: color)
                        : TextStyles.subtitle(color: Palette.greyColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
