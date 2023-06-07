import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/pro_player_info.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/game_page/widgets/rating_box.dart';

/// Main widget for ProPlayerInfoPage module
class ProPlayerInfoPageWidget
    extends ElementaryWidget<IProPlayerInfoPageWidgetModel> {
  ///
  const ProPlayerInfoPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultProPlayerInfoPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IProPlayerInfoPageWidgetModel wm) {
    return SafeArea(
      child: EntityStateNotifierBuilder<ProPlayerInfoData>(
        listenableEntityState: wm.proPlayerInfoData,
        loadingBuilder: (_, __) =>
            const Center(child: AdaptiveActivityIndicator()),
        builder: (_, proPlayerInfoData) => Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: OctoImage(
                height: 288,
                width: wm.width,
                fit: BoxFit.cover,
                placeholderBuilder: (context) => const Center(
                  child: AdaptiveActivityIndicator(
                    radius: 40,
                  ),
                ),
                errorBuilder: (c, e, s) => Center(
                  child: SvgPicture.asset(
                    'assets/images/error_placeholder.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors().accentGreen,
                      BlendMode.srcIn,
                    ),
                    height: 60,
                    width: 60,
                  ),
                ),
                image: Image.network(
                  proPlayerInfoData?.imageUrl ?? '',
                  fit: BoxFit.fitWidth,
                ).image,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: wm.back,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColors().primaryText,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Icon(
                      TennisIcons.back,
                      color: AppColors().white,
                      size: 12,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () => wm.toGame(),
                child: Container(
                  height: 240,
                  width: wm.width,
                  color: AppColors().accentGreen,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            TennisIcons.ball_filled,
                            color: AppColors().white,
                            size: 28,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Начать',
                            style: AppTextStyles()
                                .bold_32_37
                                .copyWith(color: AppColors().white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 254,
              child: SizedBox(
                height: wm.height - 230 - 220,
                child: Container(
                  height: wm.height - 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      24,
                    ),
                    color: AppColors().white,
                  ),
                  width: wm.width,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              proPlayerInfoData?.name ?? '',
                              style: AppTextStyles().bold_20_27.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            proPlayerInfoData?.description ?? '',
                            style: AppTextStyles().regular_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          RatingBox(
                            name: 'Сила удара',
                            rating: proPlayerInfoData?.rating1 ?? 0,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RatingBox(
                            name: 'Сила удара',
                            rating: proPlayerInfoData?.rating2 ?? 0,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RatingBox(
                            name: 'Сила удара',
                            rating: proPlayerInfoData?.rating3 ?? 0,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          RatingBox(
                            name: 'Сила удара',
                            rating: proPlayerInfoData?.rating4 ?? 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
