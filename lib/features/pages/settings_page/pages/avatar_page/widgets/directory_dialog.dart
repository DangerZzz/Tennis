import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';

///
class DirectoryDialog extends StatelessWidget {
  ///
  final bool isAvatar;

  ///
  final VoidCallback onGallery;

  ///
  final VoidCallback onCamera;

  ///
  const DirectoryDialog({
    required this.onCamera,
    required this.onGallery,
    required this.isAvatar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isAvatar
                  ? 'Как вы хотите загрузить аватар?'
                  : 'Как вы хотите загрузить обложку?',
              style: AppTextStyles()
                  .bold_20_27
                  .copyWith(color: AppColors().primaryText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: onGallery,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().accentGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 38,
                      ),
                      child: Center(
                        child: Text(
                          'Из галереи',
                          style: AppTextStyles().bold_16_21.copyWith(
                                color: AppColors().white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: onCamera,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().accentGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 38,
                      ),
                      child: Center(
                        child: Text(
                          'Открыть камеру',
                          style: AppTextStyles().bold_16_21.copyWith(
                                color: AppColors().white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
