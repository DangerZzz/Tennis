import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/component_styles.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/state_widgets/error_state_widget.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/training_info.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/profile_page_wm.dart';

/// Страница с информацией о тренеровке
class WorkoutInformationPage extends StatelessWidget {
  ///
  final IProfilePageWidgetModel wm;

  ///
  const WorkoutInformationPage({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors().white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: wm.onStatistics,
          child: Icon(
            TennisIcons.back,
            color: AppColors().primaryText,
            size: 14,
          ),
        ),
        title: Text(
          'Статистика',
          style: AppTextStyles().bold_24_32.copyWith(
                color: AppColors().primaryText,
              ),
        ),
      ),
      body: EntityStateNotifierBuilder<TrainingInfo>(
        listenableEntityState: wm.workoutData,
        loadingBuilder: (_, __) =>
            const Center(child: AdaptiveActivityIndicator()),
        errorBuilder: (_, __, ___) => const ErrorStateWidget(refresh: null),
        builder: (_, workoutData) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors().primaryText,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Icon(
                            TennisIcons.calendar,
                            color: AppColors().accentGreen,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${workoutData?.date}',
                          style: AppTextStyles().medium_16_21.copyWith(
                                color: AppColors().accentGreen,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                EntityStateNotifierBuilder<int>(
                  listenableEntityState: wm.currentSet,
                  builder: (_, currentSet) => DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().white,
                      boxShadow: AppComponentStyles().boxShadow,
                      border: AppComponentStyles().boxBorder,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Показатели ${currentSet! + 1} сета',
                                style: AppTextStyles()
                                    .medium_18_24
                                    .copyWith(color: AppColors().primaryText),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Row(children: [
                                GestureDetector(
                                  onTap: () => wm.changeSet(currentSet - 1),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: (currentSet + 1) == 1
                                          ? AppColors()
                                              .accentGreen
                                              .withOpacity(0.4)
                                          : AppColors().accentGreen,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 2.0),
                                      child: Icon(
                                        TennisIcons.back,
                                        size: 10,
                                        color: AppColors().white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () => wm.changeSet(currentSet + 1),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: ((currentSet + 1) !=
                                              workoutData?.sets.length)
                                          ? AppColors().accentGreen
                                          : AppColors()
                                              .accentGreen
                                              .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 18,
                                      color: AppColors().white,
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var game in wm.gameListData) ...[
                                  EntityStateNotifierBuilder<int>(
                                    listenableEntityState: wm.currentGame,
                                    builder: (_, currentGame) =>
                                        GestureDetector(
                                      onTap: () => wm
                                          .changeGame(game.gameNumber.toInt()),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: game.gameNumber ==
                                                  (currentGame! + 1)
                                              ? AppColors().accentGreen
                                              : AppColors().primaryText,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 6,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                '${game.gameNumber} гейм',
                                                style: AppTextStyles()
                                                    .medium_14_19
                                                    .copyWith(
                                                      color: AppColors().white,
                                                    ),
                                              ),
                                              Text(
                                                '${game.percent}%',
                                                style: AppTextStyles()
                                                    .medium_14_19
                                                    .copyWith(
                                                      color: AppColors().white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors().white,
                    boxShadow: AppComponentStyles().boxShadow,
                    border: AppComponentStyles().boxBorder,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Отработанные удары',
                          style: AppTextStyles()
                              .bold_16_21
                              .copyWith(color: AppColors().primaryText),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors().white,
                            borderRadius: BorderRadius.circular(200),
                            boxShadow: AppComponentStyles().boxShadowBlur,
                            border: AppComponentStyles().boxBorder,
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 8, 16),
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: AppColors().accentGreen,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Icon(
                                          TennisIcons.check,
                                          size: 12,
                                          color: AppColors().white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Ок: ${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats.where((element) => element.state == 'Ok').length}',
                                      style:
                                          AppTextStyles().medium_16_21.copyWith(
                                                color: AppColors().primaryText,
                                              ),
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Color.fromRGBO(157, 157, 157, 1),
                                  thickness: 1,
                                  endIndent: 8,
                                  indent: 8,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: AppColors().gridRed,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Icon(
                                          TennisIcons.grid,
                                          size: 12,
                                          color: AppColors().white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Сетка: 0',
                                      style: AppTextStyles()
                                          .medium_16_21
                                          .copyWith(
                                            color: AppColors().secondaryText,
                                          ),
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Color.fromRGBO(157, 157, 157, 1),
                                  thickness: 1,
                                  endIndent: 8,
                                  indent: 8,
                                ),
                                Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: AppColors().outYellow,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Icon(
                                        TennisIcons.arrow_diagonal,
                                        size: 10,
                                        color: AppColors().white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Text(
                                      'Аут: ${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats.where((element) => element.state == 'Out').length}',
                                      style:
                                          AppTextStyles().medium_16_21.copyWith(
                                                color: AppColors().primaryText,
                                              ),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Builder(
                          builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    for (var evenValue = 0;
                                        evenValue <
                                            (workoutData
                                                    ?.sets[wm.currentSet.value
                                                            ?.data ??
                                                        0]
                                                    .game[wm.currentGame.value
                                                            ?.data ??
                                                        0]
                                                    .practicedBeats
                                                    .length ??
                                                0);
                                        evenValue++) ...[
                                      if (evenValue.isEven)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                40,
                                            decoration: BoxDecoration(
                                              color: AppColors().white,
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      241, 241, 241, 1),
                                                  offset: Offset(1, 2),
                                                  spreadRadius: 0.1,
                                                  blurRadius: 20,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 9.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats[evenValue].name.substring(0, 1)}'
                                                    '${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats[evenValue].name.toLowerCase().substring(1)}',
                                                    style: AppTextStyles()
                                                        .regular_16_21
                                                        .copyWith(
                                                          color: AppColors()
                                                              .primaryText,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      color: AppColors()
                                                          .accentGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    child: Icon(
                                                      TennisIcons.check,
                                                      color: AppColors().white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  children: [
                                    for (var oddValue = 0;
                                        oddValue <
                                            (workoutData
                                                    ?.sets[wm.currentSet.value
                                                            ?.data ??
                                                        0]
                                                    .game[wm.currentGame.value
                                                            ?.data ??
                                                        0]
                                                    .practicedBeats
                                                    .length ??
                                                0);
                                        oddValue++) ...[
                                      if (oddValue.isOdd)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                40,
                                            decoration: BoxDecoration(
                                              color: AppColors().white,
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      241, 241, 241, 1),
                                                  offset: Offset(1, 2),
                                                  spreadRadius: 0.1,
                                                  blurRadius: 20,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 9.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats[oddValue].name.substring(0, 1)}'
                                                    '${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats[oddValue].name.toLowerCase().substring(1)}',
                                                    style: AppTextStyles()
                                                        .regular_16_21
                                                        .copyWith(
                                                          color: AppColors()
                                                              .primaryText,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      color: AppColors()
                                                          .accentGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    child: Icon(
                                                      TennisIcons.check,
                                                      color: AppColors().white,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ],
                                ),
                              ],
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
                    color: AppColors().primaryText,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Прогресс',
                                  style: AppTextStyles()
                                      .bold_16_21
                                      .copyWith(color: AppColors().white),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Уровень: ${workoutData?.level}',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().white,
                                      ),
                                ),
                                Text(
                                  'Сложность: ${workoutData?.complexity}',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().white,
                                      ),
                                ),
                              ],
                            ),
                            CircularPercentIndicator(
                              radius: 54.0,
                              lineWidth: 18.0,
                              linearGradient: workoutData?.percent == 100
                                  ? null
                                  : AppComponentStyles()
                                      .greenGradientForCircular,
                              progressColor: workoutData?.percent == 100
                                  ? AppColors().accentGreen
                                  : null,
                              rotateLinearGradient: true,
                              percent:
                                  (workoutData?.percent.toDouble() ?? 0) / 100,
                              center: Text(
                                '${workoutData?.percent}%',
                                style: AppTextStyles().bold_14_19.copyWith(
                                      color: AppColors().accentGreen,
                                    ),
                              ),
                              backgroundColor: Colors.transparent,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          width: wm.width,
                          decoration: BoxDecoration(
                            gradient: AppComponentStyles().greenGradient,
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                      .copyWith(color: AppColors().white),
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
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
