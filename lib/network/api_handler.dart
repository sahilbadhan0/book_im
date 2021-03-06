
import 'package:book_im/utils/sharedPref/memory_management.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_urls.dart';

class RestClient {
  static Dio dio;

  Dio create(
      {bool isLoggedIn = true, bool isSetHeader = true, String baseURL}) {
  /*  if (dio != null && isLoggedIn) {
      return dio;
    }*/
    BaseOptions baseOptions = new BaseOptions(
      baseUrl: baseURL != null ? baseURL : ApiURL.baseUrl,
    );

    if (isSetHeader) {
      final header ={
        "Authorization":"${MemoryManagement?.getAccessToken()??""}",
        "Token":"${MemoryManagement?.getAccessToken()??""}"

//        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFndTk0LnJhZ2hhdkBnbWFpbC5jb20iLCJmaXJzdE5hbWUiOiJSYWdoYXYifQ.UwxGHn2x1l5xycY5Xwpqp-fxMVaH_I0kRUt-opfh3hQzPJd90UMY1PIIdTKEZv98yuDU7LMNvW-1hXniE5iv9WKF4KgKI3ujL4xQqZsidY0trsRnqvlSKeRxlXInBwm4evY4alVmIetpvi5ZNRxpXrGd5Wc0YuJ5ecrWuDhaJSRFjlWOzJD4Zpj8N7oGyUwPudFWLMnZhUb8PdhBe05AT50J6egcBaPP2rYn1KWwu3NZPPbUk8KM5OEAqcTxSiJqLPjJuLAsyeSJwAjDqKCsLZoBdLBr8UdOduxAG_IQi1jh1PdPuclcPYhFlyM2Ngg5Z-EIqy8003CbtEyqfOc2wg"
      };
      // MemoryManagement.getAccessToken();
      baseOptions.headers = header;//{"access_token": "${header}"};
    }

    // baseOptions.headers["device_token"] = LocalDb().getDeviceToken();
    baseOptions.connectTimeout = 60000;
    baseOptions.receiveTimeout = 60000;
    baseOptions.followRedirects = false;
    dio = new Dio(baseOptions);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: true,
    ));

    return dio;
  }
}
