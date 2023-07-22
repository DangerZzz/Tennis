import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/tools/custom_image_crop.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/tools/custom_path_painter.dart';

///
class EditImagePage extends StatelessWidget {
  /// wm
  final IAvatarPageWidgetModel widgetModel;

  ///
  const EditImagePage({required this.widgetModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: EntityStateNotifierBuilder<bool>(
        listenableEntityState: widgetModel.buttonAvailability,
        loadingBuilder: (_, __) => const Center(
          child: AdaptiveActivityIndicator(
            radius: 40,
          ),
        ),
        builder: (_, buttonAvailability) => EntityStateNotifierBuilder<bool>(
          listenableEntityState: widgetModel.isAvatar,
          loadingBuilder: (_, __) => const AdaptiveActivityIndicator(
            radius: 40,
          ),
          builder: (_, isAvatar) => Stack(
            children: [
              EntityStateNotifierBuilder<Uint8List>(
                listenableEntityState: (isAvatar ?? true)
                    ? widgetModel.avatarImageBytes
                    : widgetModel.backgroundImageBytes,
                builder: (_, imageData) => CustomImageCropLib(
                  cropController: widgetModel.controller,
                  image: MemoryImage(
                    imageData!,
                  ),
                  shape: isAvatar!
                      ? CustomCropShapeLib.Circle
                      : CustomCropShapeLib.Square,
                  drawPath: CustomCropPathPainter.drawPath,
                  customProgressIndicator: const AdaptiveActivityIndicator(),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                  onTap: widgetModel.onBackWithIndex,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: AppColors().primaryText,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Icon(
                        TennisIcons.x,
                        color: AppColors().white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                left: 14,
                right: 16,
                child: GestureDetector(
                  onTap: (isAvatar ?? true)
                      ? widgetModel.cropAvatar
                      : widgetModel.cropBackground,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors().gradientStart,
                          AppColors().gradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Сохранить',
                        style: AppTextStyles().semibold_20_27.copyWith(
                              color: AppColors().white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
