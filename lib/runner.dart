import 'dart:async';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:soft_weather_tennis/app/app.dart';
import 'package:soft_weather_tennis/util/header_version_app.dart';
import 'package:soft_weather_tennis/util/secure_storage_cleaner.dart';
import 'package:surf_logger/surf_logger.dart';

/// App launch.
Future<void> run() async {
  /// It must be called so that the orientation does not fall.
  WidgetsFlutterBinding.ensureInitialized();

  /// Fix orientation.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // await Firebase.init();

  _initLogger();

  // await FlutterDownloader.initialize(
  //   debug: Environment<AppConfig>.instance().isDebug,
  //   ignoreSsl: Environment<AppConfig>.instance().isDebug,
  // );

  await clearSecureStorage();

  headerVersionApp = HeaderVersionApp();
  await headerVersionApp.initPackageInfo();

  _initAnalytics();

  _runApp();
}

void _runApp() {
  runZonedGuarded<Future<void>>(
    () async {
      // FlutterError.onError =
      //     FirebaseCrashlytics.instance.recordFlutterFatalError;
      runApp(const App());
    },
    (exception, stack) {
      // FirebaseCrashlytics.instance.recordError(exception, stack);
    },
  );
}

void _initLogger() {
  // RemoteLogger.addStrategy(CrashlyticsRemoteLogStrategy());
  Logger.addStrategy(DebugLogStrategy());
  Logger.addStrategy(RemoteLogStrategy());
}

void _initAnalytics() {
  // Analytics.addStrategy(FirebaseAnalyticsService());
  // Analytics.logEvent(
  //   'headerVersionApp',
  //   {
  //     'appVersion': headerVersionApp.appVersion,
  //   },
  // );
  // сюда пишем заполнение аналитики стратегиями
}

// void _initPerformance() {
//   Performance.addStrategy(FirebaseStrategy());
// }
