import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_wm.dart';
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
      child: Stack(
        children: [
          CustomImageCrop(
            cropController: widgetModel.controller,
            image: const NetworkImage(
              'https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png',
            ),
            //FileImage(File(widgetModel.avatarImage.path)),
            drawPath: CustomCropPathPainter.drawPath,
            customProgressIndicator: const AdaptiveActivityIndicator(),
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
              onTap: widgetModel.cropImage,
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
    );
  }
}
