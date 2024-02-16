import 'package:dio/dio.dart';
import 'package:ioc_demo/domain/common/locale_provider.dart';

class LocaleInterceptor extends Interceptor {
  LocaleInterceptor(this._localeProvider);

  final LocaleProvider _localeProvider;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept-Language'] = await _localeProvider.currentLocale();
    handler.next(options);
  }
}
