import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/widgets/rating_box.dart';

///
class PlayerCallPage extends StatelessWidget {
  ///
  final ProPlayer proPlayer;

  ///
  const PlayerCallPage({
    required this.proPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: OctoImage(
                height: 288,
                width: width,
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
                  proPlayer.imageUrl ?? '',
                  fit: BoxFit.fitWidth,
                ).image,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
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
                onTap: () {}, //TODO
                child: Container(
                  height: 240,
                  width: width,
                  color: AppColors().accentGreen,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150.0),
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
              bottom: 124,
              child: Container(
                height: height - 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    24,
                  ),
                  color: AppColors().white,
                ),
                width: width,
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
                            proPlayer.name ?? '',
                            style: AppTextStyles().bold_20_27.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          proPlayer.description ?? '',
                          style: AppTextStyles().regular_14_19.copyWith(
                                color: AppColors().primaryText,
                              ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        RatingBox(
                          name: 'Сила удара',
                          rating: proPlayer.ratings.impactForce ?? 0,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RatingBox(
                          name: 'Выносливость',
                          rating: proPlayer.ratings.endurance ?? 0,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RatingBox(
                          name: 'Тактика',
                          rating: proPlayer.ratings.tactic,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RatingBox(
                          name: 'Сложность',
                          rating: proPlayer.ratings.complexity,
                        ),
                      ],
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
