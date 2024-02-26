import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ioc_demo/presentation/themes/font_constants.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';

class AppTheme {
  static ThemeData androidTheme() {
    return ThemeData(
      brightness: Brightness.light,
      datePickerTheme: DatePickerThemeData(
        cancelButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Palette.primaryColor,
          ),
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Palette.primaryColor,
          ),
        ),
        todayForegroundColor: MaterialStateProperty.all<Color>(
          Palette.primaryColor,
        ),
        dayOverlayColor: MaterialStateProperty.all<Color>(
          Palette.whiteColor,
        ),
        dayBackgroundColor:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Palette.primaryColor;
          }
          return Palette.whiteColor;
        }),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Palette.whiteColor,
        onPrimary: Palette.blackColor,
        secondary: Palette.primaryColor,
        onSecondary: Palette.whiteColor,
        surface: Palette.whiteColor,
        onSurface: Palette.blackColor,
        error: Palette.toastError,
        onError: Palette.whiteColor,
        background: Palette.whiteColor,
        onBackground: Palette.blackColor,
      ),
      primaryColor: Palette.primaryColor,
      highlightColor: Palette.primaryColor.withAlpha(Palette.opacity20),
      splashColor: Palette.primaryColor.withAlpha(Palette.opacity20),
      fontFamily: FontConstants.fontName,
      scaffoldBackgroundColor: Palette.whiteColor,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          //minimumSize: const Size(88, ButtonPrimary.defaultHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 2,
        ),
      ),
      // TODO need to remove after migration from RaisedButton to ElevatedButton
      buttonTheme: ButtonThemeData(
        //TODO: Button height
        //height: ButtonPrimary.defaultHeight,
        buttonColor: Palette.primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      cupertinoOverrideTheme: cupertinoTheme(),
      cardTheme: const CardTheme(
        elevation: 1.0,
        color: Palette.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Palette.primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const _NoUnderlineInputBorder(),
        fillColor: Palette.whiteColor,
        contentPadding: const EdgeInsets.all(Spacings.medium),
        filled: true,
        hintStyle: TextStyles.normalMedium(color: Palette.colorTextFieldHint),
        floatingLabelStyle: TextStyles.normalSmall(),
        labelStyle: TextStyles.normalSmall(color: Palette.colorTextFieldLabel),
        isCollapsed: true,
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Palette.whiteColor,
        elevation: 0,
        centerTitle: true,
        //TODO: Secondary color
        // iconTheme: IconThemeData(color: Palette.secondary),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: Palette.colorBottomSheetBackground,
      ),
    );
  }

  static CupertinoThemeData cupertinoTheme() {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: Palette.primaryColor,
      primaryContrastingColor: Palette.primaryColor,
      scaffoldBackgroundColor: Palette.colorScaffoldBackground,
      barBackgroundColor: Palette.colorScaffoldBackground,
    );
  }
}

class _NoUnderlineInputBorder extends UnderlineInputBorder {
  const _NoUnderlineInputBorder()
      : super(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        );
}
