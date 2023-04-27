import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';

///
class DeleteDialog extends StatelessWidget {
  ///
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Вы действительно хотите удалить аккаунт?',
              style: AppTextStyles()
                  .bold_20_27
                  .copyWith(color: AppColors().primaryText),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().secondaryText,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 38,
                      ),
                      child: Text(
                        'Да',
                        style: AppTextStyles().regular_16_21.copyWith(
                              color: AppColors().white,
                            ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().accentGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 64,
                      ),
                      child: Text(
                        'Нет',
                        style: AppTextStyles().bold_16_21.copyWith(
                              color: AppColors().white,
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
