import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/* Created By Dwi Sutrisno */

class DioConfig {
  //dio attributes
  static Dio dio = Dio(dioBaseOptions());
  static CookieJar cookiejar = CookieJar();

  //get dio object
  static Future<Dio> getDio() async {
    Dio dio = Dio(dioBaseOptions());

    var cookieManager = await getCookieManager();
    //load cookies for next request
    cookiejar.loadForRequest(Uri.parse(serverHost));

    dio.interceptors.add(cookieManager);
    // dio.interceptors.add(dioPrettyLog());
    return dio;
  }

  static Future<CookieJar> getCookieJar() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    cookiejar =
        PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));
    return cookiejar;
  }

  static Future<CookieManager> getCookieManager() async {
    var cookies = await getCookieJar();
    return CookieManager(cookies);
  }

  static PrettyDioLogger dioPrettyLog() {
    return PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90);
  }

  static BaseOptions dioBaseOptions() {
    return BaseOptions(
      baseUrl: serverHost,
      connectTimeout: connectTimeOut,
      receiveTimeout: receiveTimeOut,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
