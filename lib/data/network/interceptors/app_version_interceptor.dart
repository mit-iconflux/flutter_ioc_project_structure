import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Map<String, dynamic> headers =
        Map<String, dynamic>.from(options.headers);
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    headers['X-M2H-Client-Version'] = packageInfo.version;
    options.headers = headers;
    handler.next(options);
  }
}
