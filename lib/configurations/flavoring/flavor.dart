import 'package:ioc_demo/constants/string_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Flavor { dev, prod, uat }

Flavor _flavor = Flavor.dev;
const String _baseUrl = 'http://dev-base-url';
const String _networkPingUrl = 'http://dev-base-url/ping';
String _appId = StringConstants.packageNameDev;
const String _debugBanner = 'DEV';
late Map<String, String> _config;

Future<void> setFlavor() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  _appId = packageInfo.packageName;

  if (packageInfo.packageName == StringConstants.packageNameDev) {
    _flavor = Flavor.dev;
    _config = devConstants;
  } else if (packageInfo.packageName == StringConstants.packageNameUat) {
    _flavor = Flavor.uat;
    _config = uatConstants;
  } else {
    _flavor = Flavor.prod;
    _config = prodConstants;
  }
}

Flavor get flavor {
  return _flavor;
}

String get getApplicationId {
  return _appId;
}

String get apiBaseUrl {
  return _config[_baseUrl] ?? _baseUrl;
}

String get debugBanner {
  return _config[_debugBanner] ?? _debugBanner;
}

String get networkPingUrl {
  return _config[_networkPingUrl] ?? _networkPingUrl;
}

Map<String, String> devConstants = <String, String>{
  _baseUrl: 'http://dev-base-url',
  _networkPingUrl: 'http://dev-base-url/ping',
  _debugBanner: 'DEV'
};

Map<String, String> prodConstants = <String, String>{
  _baseUrl: 'http://prod-base-url',
  _networkPingUrl: 'http://prod-base-url/ping',
  _debugBanner: ''
};

Map<String, String> uatConstants = <String, String>{
  _baseUrl: 'http://uat-base-url',
  _networkPingUrl: 'http://uat-base-url/ping',
  _debugBanner: 'UAT'
};
