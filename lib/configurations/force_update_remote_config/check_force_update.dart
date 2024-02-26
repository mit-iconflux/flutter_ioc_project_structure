// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ioc_demo/configurations/force_update_remote_config/remote_config_service.dart';
import 'package:ioc_demo/constants/string_constants.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/app_routes.dart';
import 'package:ioc_demo/utilities%20/utility.dart';
import 'package:open_store/open_store.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum UpdateType { forceUpdate, update, notUpdate }

class CheckForceUpdate {
  //KEEP IN MIND: In this scenario logic will not work where version name's middle digit in two digit long
  //for example your current app version is 1.24.1 and remote version in 1.3.0, logically remote version is higher then current app version
  //But in this where remove dots value became for current version is 1241 and remove version is 130, So condition will not satisfied not show the popup

  CheckForceUpdate({required this.remoteConfigService});

  final RemoteConfigService remoteConfigService;
  String androidAppId = StringConstants.packageNameProd;
  String iOSAppId = StringConstants.appIdiOS;

  Future<UpdateType> isForceUpdateRequired() async {
    //FORCE UPDATE
    // const int currentAppVersion = 99;
    // const int lastForceUpdateVersion = 100;
    // const int remoteAppVersion = 98;
    // const bool isForceUpdate = true;

    //UPDATE
    // const int currentAppVersion = 99;
    // const int lastForceUpdateVersion = 99;
    // const int remoteAppVersion = 100;
    // const bool isForceUpdate = false;

    //NO UPDATE
    // const int currentAppVersion = 99;
    // const int lastForceUpdateVersion = 99;
    // const int remoteAppVersion = 98;
    // const bool isForceUpdate = false;

    final int currentAppVersion = await _getAppVersionNumber();

    final int lastForceUpdateVersion = _convertStringToInt(
      Platform.isIOS
          ? remoteConfigService.getIosLastForceUpdateVersion
          : remoteConfigService.getAndroidLastForceUpdateVersion,
    );

    final int remoteAppVersion = _convertStringToInt(
      Platform.isIOS
          ? remoteConfigService.getIosVersion
          : remoteConfigService.getAndroidVersion,
    );

    final bool isForceUpdate = Platform.isIOS
        ? remoteConfigService.getIosForceUpdate
        : remoteConfigService.getAndroidForceUpdate;

    androidAppId = remoteConfigService.getAndroidAppId;
    iOSAppId = remoteConfigService.getIOSAppId;

    Utility.showLog(
      'Force Update Configuration: \n'
      'currentAppVersion:$currentAppVersion\n'
      'lastForceUpdateVersion:$lastForceUpdateVersion\n'
      'remoteAppVersion:$remoteAppVersion\n'
      'isForceUpdate:$isForceUpdate',
    );

    if (currentAppVersion < lastForceUpdateVersion) {
      return UpdateType.forceUpdate;
    } else {
      if (currentAppVersion < remoteAppVersion) {
        if (isForceUpdate) {
          return UpdateType.forceUpdate;
        } else {
          return UpdateType.update;
        }
      } else {
        return UpdateType.notUpdate;
      }
    }
  }

  Future<int> showUpdateDialog(
    BuildContext context, {
    bool isForceUpdate = false,
  }) async {
    int returnResult = 1;

    await AppNavigator().push(
      AppRoutes.customDialog(
        title: StringConstants.labelUpdate,
        message: StringConstants.labelUpdateMsg,
        positiveButtonText: StringConstants.labelUpdate,
        negativeButtonText:
            isForceUpdate ? StringConstants.labelExit : StringConstants.labelOk,
        onCallBack: (int result) async {
          if (result == 0) {
            OpenStore.instance.open(
              appStoreId: iOSAppId,
              androidAppBundleId: androidAppId,
            );
            returnResult =
                await showUpdateDialog(context, isForceUpdate: isForceUpdate);
          } else {
            if (isForceUpdate) {
              exit(0);
            }
            returnResult = 1;
          }
        },
      ),
    );

    return returnResult;
  }

  Future<int> _getAppVersionNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return _convertStringToInt(packageInfo.version);
  }

  int _convertStringToInt(String text) {
    return int.parse(text.replaceAll('.', ''));
  }
}
