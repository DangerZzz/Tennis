import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_wm.dart';

class Test extends StatelessWidget {
  /// wm
  final IAvatarPageWidgetModel widgetModel;

  const Test({required this.widgetModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<MemoryImage>(
      listenableEntityState: widgetModel.avatarImageCropped,
      loadingBuilder: (_, __) => const AdaptiveActivityIndicator(
        radius: 40,
      ),
      builder: (_, state) => Column(
        children: [
          const Text(
            'Тестовая страница для проверки обрезки фото, после подключения бэка'
            ' будет выполняться сохранение изображения без предпросмотра на '
            'этой странице',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 100,
          ),
          Image(
            image: state!,
          ),
        ],
      ),
    );
  }
}
