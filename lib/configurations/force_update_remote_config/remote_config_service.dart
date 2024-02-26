// ignore_for_file: constant_identifier_names, lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:ioc_demo/constants/string_constants.dart';
import 'package:ioc_demo/utilities%20/utility.dart';

const String _IOS_VERSION = 'ios_version';
const String _ANDROID_VERSION = 'android_version';
const String _IOS_FORCE_UPDATE = 'ios_force_update';
const String _ANDROID_FORCE_UPDATE = 'android_force_update';
const String _IOS_LAST_FORCE_UPDATE_VERSION = 'ios_last_force_update_version';
const String _ANDROID_LAST_FORCE_UPDATE_VERSION =
    'android_last_force_update_version';
const String _UNDER_MAINTENANCE = 'under_maintenance';
const String _UNDER_MAINTENANCE_DESCRIPTION = 'under_maintenance_description';
const String _UNDER_MAINTENANCE_TITLE = 'under_maintenance_title';
const String _ANDROID_APP_ID = 'android_app_id';
const String _IOS_APP_ID = 'ios_app_id';

//KEEP IN MIND: In this scenario logic will not work where version name's middle digit in two digit long
//for example your current app version is 1.24.1 and remote version in 1.3.0, logically remote version is higher then current app version
//But in this where remove dots value became for current version is 1241 and remove version is 130, So condition will not satisfied not show the popup

class RemoteConfigService {
  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;
  final FirebaseRemoteConfig _remoteConfig;

  final Map<String, dynamic> defaults = <String, dynamic>{
    _IOS_VERSION: '',
    _ANDROID_VERSION: '',
    _IOS_FORCE_UPDATE: false,
    _ANDROID_FORCE_UPDATE: false,
    _IOS_LAST_FORCE_UPDATE_VERSION: '',
    _ANDROID_LAST_FORCE_UPDATE_VERSION: '',
    _UNDER_MAINTENANCE: false,
    _UNDER_MAINTENANCE_DESCRIPTION: '',
    _UNDER_MAINTENANCE_TITLE: '',
    _ANDROID_APP_ID: StringConstants.packageNameProd,
    _IOS_APP_ID: StringConstants.appIdiOS,
  };

  static RemoteConfigService? _instance;

  static Future<RemoteConfigService> getInstance() async {
    await Firebase.initializeApp();
    final FirebaseRemoteConfig mFirebaseRemoteConfig =
        FirebaseRemoteConfig.instance;

    final RemoteConfigSettings configSettings = RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 1),
    );
    mFirebaseRemoteConfig.setConfigSettings(configSettings);
    _instance ??= RemoteConfigService(
      remoteConfig: FirebaseRemoteConfig.instance,
    );
    return _instance!;
  }

  bool get getUnderMaintenance => _remoteConfig.getBool(_UNDER_MAINTENANCE);

  String get getUnderMaintenanceDescription =>
      _remoteConfig.getString(_UNDER_MAINTENANCE_DESCRIPTION);

  String get getUnderMaintenanceTitle =>
      _remoteConfig.getString(_UNDER_MAINTENANCE_TITLE);

  String get getIosVersion => _remoteConfig.getString(_IOS_VERSION);

  String get getAndroidVersion => _remoteConfig.getString(_ANDROID_VERSION);

  bool get getIosForceUpdate => _remoteConfig.getBool(_IOS_FORCE_UPDATE);

  bool get getAndroidForceUpdate =>
      _remoteConfig.getBool(_ANDROID_FORCE_UPDATE);

  String get getIosLastForceUpdateVersion =>
      _remoteConfig.getString(_IOS_LAST_FORCE_UPDATE_VERSION);

  String get getAndroidLastForceUpdateVersion =>
      _remoteConfig.getString(_ANDROID_LAST_FORCE_UPDATE_VERSION);

  String get getAndroidAppId => _remoteConfig.getString(_ANDROID_APP_ID);

  String get getIOSAppId => _remoteConfig.getString(_IOS_APP_ID);

  Future<void> initialize() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _remoteConfig.ensureInitialized();
      await _remoteConfig.fetchAndActivate();
      Utility.showLog('REMOTE CONFIG DETAILS: '
          '\nandroid_version:$getAndroidVersion '
          '\nandroid_force_update:$getAndroidForceUpdate'
          '\ngetAndroidLastForceUpdateVersion:$getAndroidLastForceUpdateVersion'
          '\nIOS_version:$getIosVersion '
          '\nIOS_force_update:$getIosForceUpdate'
          '\nIOSLastForceUpdateVersion:$getIosLastForceUpdateVersion'
          '\n$_UNDER_MAINTENANCE:$getUnderMaintenance'
          '\n$_UNDER_MAINTENANCE_DESCRIPTION:$getUnderMaintenanceDescription'
          '\n$_ANDROID_APP_ID:$getAndroidAppId'
          '\n$_IOS_APP_ID:$getIOSAppId');
    } catch (e) {
      Utility.showLog(
        'Unable to fetch remote config. Default value will be used',
      );
    }
  }
}
