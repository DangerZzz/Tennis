import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_refresh_custom_scroll_view.dart';
import 'package:soft_weather_tennis/features/pages/game_page/game_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/game_page/widgets/prof_player_card.dart';

/// Main widget for GamePage module
class GamePageWidget extends ElementaryWidget<IGamePageWidgetModel> {
  ///
  const GamePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultGamePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGamePageWidgetModel wm) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors().white,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          shadowColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 16,
              bottom: 32,
            ),
            child: Text(
              'Игра',
              style: AppTextStyles().bold_24_32.copyWith(
                    color: AppColors().primaryText,
                  ),
            ),
          ),
        ),
        body: AdaptiveRefreshCustomScrollView(
          // onRefresh: () => wm.onRefresh(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Профессиональные игроки',
                          style: AppTextStyles().bold_16_21.copyWith(
                                color: AppColors().primaryText,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 60.0,
                            top: 8,
                          ),
                          child: Text(
                            'Хочешь тренироваться как PRO? Выбери '
                            'одного из известных игроков и сделай '
                            'себе вызов!',
                            style: AppTextStyles().light_12_16.copyWith(
                                  color: AppColors().secondaryText,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const PlayerCard(),
                        const SizedBox(
                          height: 16,
                        ),
                        const PlayerCard(),
                        const SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: Text(
                            'Все игроки',
                            style: AppTextStyles().regular_14_19.copyWith(
                                  color: AppColors().primaryText,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors().white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(238, 238, 238, 0.7),
                                // offset: Offset(, 2),
                                spreadRadius: 0.1,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Начать стандартную тренировку?',
                                  style: AppTextStyles().bold_16_21.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Уровень: 6',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Сложность: Light',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors().gradientStart,
                                        AppColors().gradientEnd,
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          TennisIcons.ball_filled,
                                          size: 16,
                                          color: AppColors().white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Начать',
                                          style: AppTextStyles()
                                              .semibold_16_21
                                              .copyWith(
                                                color: AppColors().white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors().white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(238, 238, 238, 0.7),
                                // offset: Offset(, 2),
                                spreadRadius: 0.1,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ваши последние игры',
                                  style: AppTextStyles().bold_16_21.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                for (var i = 0; i < 4; i++) ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: AppColors().white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                241,
                                                241,
                                                241,
                                                1,
                                              ),
                                              offset: Offset(0, 4),
                                              spreadRadius: 0.1,
                                              blurRadius: 20,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: AppColors().primaryText,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 18,
                                                ),
                                                child: Text(
                                                  'Стандартная',
                                                  style: AppTextStyles()
                                                      .medium_14_19
                                                      .copyWith(
                                                        color:
                                                            AppColors().white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 25,
                                                right: 20,
                                              ),
                                              child: Text(
                                                '79%',
                                                style: AppTextStyles()
                                                    .light_12_16
                                                    .copyWith(
                                                      color: AppColors()
                                                          .primaryText,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 26,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              color: AppColors().primaryText,
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                            ),
                                            child: Icon(
                                              TennisIcons.update,
                                              size: 20,
                                              color: AppColors().accentGreen,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Повторить',
                                            style: AppTextStyles()
                                                .light_12_16
                                                .copyWith(
                                                  color:
                                                      AppColors().secondaryText,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'lib/features/pages/profile_page/assets/images/rating_place_background.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors()
                                          .primaryText
                                          .withOpacity(0.88),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Личная статистика',
                                                style: AppTextStyles()
                                                    .bold_20_27
                                                    .copyWith(
                                                      color: AppColors()
                                                          .accentGreen,
                                                    ),
                                              ),
                                              Text(
                                                'Не забывай отслеживать изменения!',
                                                style: AppTextStyles()
                                                    .light_12_16
                                                    .copyWith(
                                                      color: AppColors().white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: AppColors().accentGreen,
                                            ),
                                            child: Icon(
                                              Icons.chevron_right,
                                              size: 22,
                                              color: AppColors().white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Builder(
                          builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width - 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'lib/features/pages/profile_page/assets/images/rating_place_background.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      AppColors().primaryText.withOpacity(0.88),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    40,
                                    60,
                                    40,
                                  ),
                                  child: Text(
                                    'Оставаться в форме тебе помогут\n'
                                    'пакровские батончики с высоким\n'
                                    'содержанием чего-нибудь.',
                                    style:
                                        AppTextStyles().medium_14_19.copyWith(
                                              color: AppColors().white,
                                            ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
