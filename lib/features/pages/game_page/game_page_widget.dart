import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/component_styles.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/adaptive_refresh_custom_scroll_view.dart';
import 'package:soft_weather_tennis/components/state_widgets/error_state_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
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
        body: EntityStateNotifierBuilder<GameData>(
          listenableEntityState: wm.gameData,
          loadingBuilder: (_, __) =>
              const Center(child: AdaptiveActivityIndicator()),
          errorBuilder: (_, __, ___) => ErrorStateWidget(
            refresh: wm.onRefresh,
          ),
          builder: (_, gameData) => AdaptiveRefreshCustomScrollView(
            onRefresh: () => wm.onRefresh(),
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
                          for (var player = 0;
                              player < (gameData?.proPlayers.length ?? 0);
                              player++) ...[
                            PlayerCard(
                              rating: gameData?.proPlayers[player].rating ?? 0,
                              description:
                                  gameData?.proPlayers[player].description ??
                                      '',
                              name: gameData?.proPlayers[player].name ?? '',
                              imageUrl:
                                  gameData?.proPlayers[player].imageUrl ?? '',
                              call: () => wm.toStartGame(),
                              info: () => wm.toProPlayerInfo(
                                gameData?.proPlayers[player].id,
                              ),
                            ),
                            if (player != gameData?.proPlayers.length)
                              const SizedBox(
                                height: 16,
                              ),
                          ],
                          const SizedBox(
                            height: 24,
                          ),
                          EntityStateNotifierBuilder<bool>(
                            listenableEntityState:
                                wm.allPlayersButtonLoadingState,
                            builder: (_, allPlayersButtonLoadingState) =>
                                allPlayersButtonLoadingState ?? false
                                    ? const Center(
                                        child: AdaptiveActivityIndicator(),
                                      )
                                    : Center(
                                        child: InkWell(
                                          onTap: wm.toAllProPlayers,
                                          child: Text(
                                            'Все игроки',
                                            style: AppTextStyles()
                                                .regular_14_19
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                        ),
                                      ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors().primaryText,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Прогресс',
                                            style: AppTextStyles()
                                                .bold_16_21
                                                .copyWith(
                                                    color: AppColors().white),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                            'Уровень: 6',
                                            //${workoutData?.level}',
                                            style: AppTextStyles()
                                                .regular_14_19
                                                .copyWith(
                                                  color: AppColors().white,
                                                ),
                                          ),
                                          Text(
                                            'Сложность: Light',
                                            //${workoutData?.complexity}',
                                            style: AppTextStyles()
                                                .regular_14_19
                                                .copyWith(
                                                  color: AppColors().white,
                                                ),
                                          ),
                                        ],
                                      ),
                                      CircularPercentIndicator(
                                        radius: 54.0,
                                        lineWidth: 18.0,
                                        linearGradient:
                                            // workoutData?.percent == 100
                                            //     ? null
                                            //     :
                                            AppComponentStyles()
                                                .greenGradientForCircular,
                                        progressColor:
                                            // workoutData?.percent == 100
                                            //     ? AppColors().white
                                            //     :
                                            null,
                                        rotateLinearGradient: true,
                                        percent: 0.8,
                                        // (workoutData?.percent.toDouble() ?? 0) / 100,
                                        center: Text(
                                          '80%',
                                          style: AppTextStyles()
                                              .bold_14_19
                                              .copyWith(
                                                color: AppColors().accentGreen,
                                              ),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Center(
                                    child: Text(
                                      'Хотите начать стандартную тренировку?',
                                      style: AppTextStyles()
                                          .regular_14_19
                                          .copyWith(
                                            color: AppColors().white,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Builder(
                                    builder: (context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          gradient: AppComponentStyles()
                                              .greenGradient,
                                          borderRadius:
                                              BorderRadius.circular(200),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                TennisIcons.ball_filled,
                                                size: 20,
                                                color: AppColors().white,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Повторить тренировку',
                                                style: AppTextStyles()
                                                    .semibold_16_21
                                                    .copyWith(
                                                        color:
                                                            AppColors().white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
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
                                  for (var trainingIndex = 0;
                                      trainingIndex <
                                          (gameData?.trainings.length ?? 0);
                                      trainingIndex++) ...[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 35,
                                          width: 200,
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
                                                width: 122,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors().primaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 18,
                                                  ),
                                                  child: Text(
                                                    gameData
                                                            ?.trainings[
                                                                trainingIndex]
                                                            .name ??
                                                        '',
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
                                                  gameData
                                                          ?.trainings[
                                                              trainingIndex]
                                                          .efficiency ??
                                                      '',
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
                                        InkWell(
                                          onTap: () => wm.toStartGame(),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 26,
                                                height: 26,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors().primaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    200,
                                                  ),
                                                ),
                                                child: Icon(
                                                  TennisIcons.update,
                                                  size: 20,
                                                  color:
                                                      AppColors().accentGreen,
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
                                                      color: AppColors()
                                                          .secondaryText,
                                                    ),
                                              ),
                                            ],
                                          ),
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
                                  GestureDetector(
                                    onTap: wm.toStatistics,
                                    child: Container(
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
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                                          color:
                                                              AppColors().white,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    200,
                                                  ),
                                                  color:
                                                      AppColors().accentGreen,
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
                              color: AppColors().accentGreen,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  Expanded(
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
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                        190,
                                        228,
                                        83,
                                        1,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: OctoImage(
                                        fit: BoxFit.cover,
                                        width: 90,
                                        height: 90,
                                        placeholderBuilder: (context) =>
                                            const SizedBox(
                                          child: Center(
                                            child: AdaptiveActivityIndicator(),
                                          ),
                                        ),
                                        errorBuilder: (c, e, s) => SizedBox(
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/images/error_placeholder.svg',
                                              colorFilter: ColorFilter.mode(
                                                AppColors().white,
                                                BlendMode.srcIn,
                                              ),
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        ),
                                        image: Image.network(
                                          '',
                                          fit: BoxFit.contain,
                                        ).image,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
