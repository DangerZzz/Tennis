import 'dart:ui';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/user_info.dart';

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
          top: wm.height / 2,
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
          child: EntityStateNotifierBuilder<UserInfo>(
            listenableEntityState: wm.userData,
            builder: (_, userData) => Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${userData?.name} ${userData?.surname}',
                      style: AppTextStyles().bold_18_24.copyWith(
                            color: AppColors().white,
                          ),
                    ),
                    Text(
                      '${userData?.rank}',
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
                            '${userData?.avatarUrl}',
                          ).image,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: wm.height - 535,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors().white,
                width: 0.3,
              ),
              color: AppColors().white.withOpacity(0.2),
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
                  padding: const EdgeInsets.fromLTRB(24.0, 44, 24, 24),
                  child: Column(
                    children: [
                      EntityStateNotifierBuilder<String>(
                        listenableEntityState: wm.qrImage,
                        loadingBuilder: (_, __) => const SizedBox(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: AdaptiveActivityIndicator(),
                          ),
                        ),
                        builder: (_, qrImage) => QrImageView(
                          data: qrImage ?? '',
                          size: 200.0,
                        ),
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      Text(
                        'Подключение тренера'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles().super_bold_23_27.copyWith(
                              color: AppColors().accentGreen,
                            ),
                      ),
                    ],
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
