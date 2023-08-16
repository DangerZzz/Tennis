import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';

///Используемый снэк-бар для отображения информации
class ShowSnackBar {
  /// Для ошибки
  ScaffoldMessengerState showError(
    BuildContext context,
  ) {
    final snackBar = _snackBar();
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Для информации
  ScaffoldMessengerState showSuccess(
    BuildContext context,
    String code,
  ) {
    final snackBar = SnackBar(
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors().accentGreen,
      closeIconColor: AppColors().white,
      showCloseIcon: true,
      duration: const Duration(
        seconds: 20,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ваш код:',
            style: AppTextStyles().bold_18_24,
          ),
          Text(
            code,
            style: AppTextStyles().bold_18_24,
          ),
        ],
      ),
    );
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // TODO(daniil): настроить
  SnackBar _snackBar() {
    return SnackBar(
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors().gridRed,
      closeIconColor: AppColors().white,
      showCloseIcon: true,
      duration: const Duration(
        seconds: 5,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Что-то пошло не так...',
            style: AppTextStyles().bold_18_24,
          ),
          Text(
            'Попробуйте повторить запрос.',
            style: AppTextStyles().regular_14_19,
          ),
        ],
      ),
    );
  }
}
