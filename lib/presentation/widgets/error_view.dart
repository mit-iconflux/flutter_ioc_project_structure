import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/assets.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/button_primary.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

enum ErrorType { noInternet, error, noData }

const String errorNoInternet = 'No Internet';
const String errorNoData = 'No data found';
const String errorErrorView = 'Technical Error';
const String msgNoInternetConnection = """
You don't seem to have an active internet connection. Please check your connection and try again.""";
const String msgNoData =
    'Result which you are looking for is not available currently';
const String msgErrorView = """
Something went wrong\nSorry, we're having some technical issue here, Try to refresh the page""";

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.height,
    this.width,
    required this.onReconnect,
    required this.errorType,
    this.buttonText,
    this.errorMsg,
    this.errorTitle,
    this.isShowRefreshButton = true,
    this.showIcon = true,
    this.allowHeightNullable = false,
  });

  final double? height;
  final double? width;
  final Function() onReconnect;
  final ErrorType errorType;
  final String? errorTitle;
  final String? buttonText;
  final String? errorMsg;
  final bool isShowRefreshButton;
  final bool showIcon;
  final bool allowHeightNullable;

  @override
  Widget build(BuildContext context) {
    late Widget image;
    late String msg;
    late String errorTitle;
    late String buttonText;

    switch (errorType) {
      case ErrorType.noInternet:
        image = ImageAssets.setImage(imagePath: ImageAssets.noInternetPath);
        msg = msgNoInternetConnection;
        buttonText = 'Reconnect';
        errorTitle = errorNoInternet;
        break;
      case ErrorType.error:
        image = ImageAssets.setImage(
          imagePath: ImageAssets.technicalErrorImagePath,
        );
        msg = msgErrorView;
        buttonText = 'Refresh';
        errorTitle = errorErrorView;
        break;
      case ErrorType.noData:
        image = ImageAssets.setImage(imagePath: ImageAssets.noDataImagePath);
        msg = msgNoData;
        buttonText = 'Refresh';
        errorTitle = errorNoData;
        break;
      default:
        image = ImageAssets.setImage(imagePath: ImageAssets.noInternetPath);
        msg = msgErrorView;
        buttonText = 'Refresh';
        errorTitle = errorErrorView;
        break;
    }

    return SizedBox(
      height: height ??
          (allowHeightNullable ? null : MediaQuery.of(context).size.height),
      width: width ?? MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: width == null
              ? MediaQuery.of(context).size.width * 0.9
              : width! * 0.5,
          height: height == null
              ? MediaQuery.of(context).size.height * 0.7
              : height! * 0.25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (showIcon)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(Spacings.large),
                      child: image,
                    ),
                  ),
                const SizedBox(
                  height: Spacings.xLarge,
                ),
                TextLabel(
                  textAlign: TextAlign.center,
                  text: this.errorTitle ?? errorTitle,
                  textStyle: TextStyles.subtitle(
                    size: Spacings.custom30,
                  ),
                ),
                const SizedBox(
                  height: Spacings.medium,
                ),
                TextLabel(
                  textAlign: TextAlign.center,
                  text: errorMsg ?? msg,
                  textStyle: TextStyles.normal(
                    color: Palette.greyColor,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: Spacings.xxxLarge,
                ),
                if (isShowRefreshButton)
                  ButtonPrimary(
                    onTap: () {
                      onReconnect();
                    },
                    text: this.buttonText ?? buttonText,
                  ),
                const SizedBox(
                  height: Spacings.small,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
