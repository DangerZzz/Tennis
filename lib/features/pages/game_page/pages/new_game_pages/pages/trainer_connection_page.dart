import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_wm.dart';

///
class TrainerConnectionPage extends StatelessWidget {
  ///
  final INewGamePageWidgetModel wm;

  ///
  const TrainerConnectionPage({required this.wm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'lib/features/pages/authorization_page/assets/images/role_background.png',
          height: wm.height,
          width: wm.width,
          fit: BoxFit.fill,
        ),
        Positioned(
          bottom: 10,
          right: 1,
          left: 1,
          top: wm.height - 225,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: -8.0,
              ),
              child: Container(
                color: AppColors().primaryText.withOpacity(0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 48,
          right: 24,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Колесников Дмитрий',
                    style: AppTextStyles().bold_18_24.copyWith(
                          color: AppColors().white,
                        ),
                  ),
                  Text(
                    'Король SMASH',
                    style: AppTextStyles().medium_14_19.copyWith(
                          color: AppColors().white,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  color: AppColors().white,
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: 102,
                    height: 102,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: OctoImage(
                        width: 102,
                        height: 102,
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) => const Center(
                          child: AdaptiveActivityIndicator(),
                        ),
                        errorBuilder: (c, e, s) => SizedBox(
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/error_placeholder.svg',
                              colorFilter: ColorFilter.mode(
                                AppColors().accentGreen,
                                BlendMode.srcIn,
                              ),
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        image: Image.network(
                          'https://picsum.photos/200',
                        ).image,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 135,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().white,
                  width: 0.3,
                ),
                color: const Color.fromRGBO(168, 219, 25, 0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 32, 32, 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Подключение\nтренера'.toUpperCase(),
                          style: AppTextStyles().super_bold_23_27.copyWith(
                                color: AppColors().accentGreen,
                              ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Подожди, пока тренер все подготовит. '
                          'Можешь воспользоваться моментом, '
                          'чтобы приготовиться морально.',
                          style: AppTextStyles().regular_16_21.copyWith(
                                color: AppColors().white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 62,
          child: Column(
            children: [
              Text(
                'Ожидание',
                style: AppTextStyles().regular_16_21.copyWith(
                      color: AppColors().white,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
