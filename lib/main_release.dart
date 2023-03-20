import 'package:soft_weather_tennis/config/app_config.dart';
import 'package:soft_weather_tennis/config/debug_options.dart';
import 'package:soft_weather_tennis/config/environment/build_types.dart';
import 'package:soft_weather_tennis/config/environment/environment.dart';
import 'package:soft_weather_tennis/config/urls.dart';
import 'package:soft_weather_tennis/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.release,
    config: AppConfig(
      url: Url.prodUrl,
      proxyUrl: Url.prodProxyUrl,
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
