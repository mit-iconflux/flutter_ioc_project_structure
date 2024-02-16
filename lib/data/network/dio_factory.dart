import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:ioc_demo/data/network/interceptors/app_version_interceptor.dart';
import 'package:ioc_demo/data/network/interceptors/os_type_interceptor.dart';

/// DioFactory
class DioFactory {
  static const Duration _defaultMaxStale = Duration(days: 1);

  /// create
  static Dio create() {
    final BaseOptions options = BaseOptions(
      contentType: 'application/json',
      headers: <String, String>{
        'X-M2H-Partner': 'swisscom',
        'X-M2H-Market': 'swisscom-ch',
        'X-M2H-App-id': 'zvolt',
      },
    );
    final Dio dio = Dio(options);

    final cacheOptions = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),

      // All subsequent fields are optional.
      // Default.
      policy: CachePolicy.request,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: _defaultMaxStale,
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );

    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    dio.interceptors.add(AppVersionInterceptor());
    dio.interceptors.add(OSTypeInterceptor());
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (Object obj) => print('$obj'),
    ));
    //dio.transformer = FlutterTransformer();
    return dio;
  }
}
