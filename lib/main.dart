import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/commons/theme.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/notfound/not_found.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/commons/routes/page_routes.dart';
import 'package:siangmalam/screens/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:siangmalam/commons/bindings/splash/splash_binding.dart';

/*Created By Dwi Sutrisno*/

void main() async {
  // HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(const MyApp());
  // configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('id', ''), // indonesia, no country code
        ],
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: theme(),
        home: const SplashScreen(),
        initialBinding: SplashBinding(),
        getPages: PageRoutes.pages,
        unknownRoute: GetPage(
          name: RouteName.unknownScreen,
          page: () => const UnknownScreen(),
        ),
      );
    });
  }
}
