import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

late HeaderVersionApp headerVersionApp;

class HeaderVersionApp {
  String? get apiVersion => _apiVersion;
  String? get appVersion => _appVersion;
  String? get buildNumber => _buildNumber;
  String? get platform => _platform;

  String? _apiVersion;
  String? _appVersion;
  String? _buildNumber;
  String? _platform;

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _apiVersion = '1.0.0';
    _appVersion = info.version;
    _buildNumber = info.buildNumber;
    _platform = Platform.isAndroid ? 'android' : 'ios';
  }
}
