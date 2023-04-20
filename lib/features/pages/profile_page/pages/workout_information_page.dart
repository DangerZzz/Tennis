import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/tennis_icons_icons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
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
    return EntityStateNotifierBuilder<TrainingInfo>(
      listenableEntityState: wm.workoutData,
      loadingBuilder: (_, __) =>
          const Center(child: AdaptiveActivityIndicator()),
      builder: (_, workoutData) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: wm.onStatistics,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColors().primaryText,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Icon(
                        Tennis_icons.back1,
                        color: AppColors().white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Тренировки',
                style: AppTextStyles()
                    .regular_14_19
                    .copyWith(color: AppColors().secondaryText),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Divider(
            color: AppColors().secondaryText.withOpacity(0.1),
            thickness: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors().accentGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Tennis_icons.calendar1,
                        color: AppColors().white,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '20.01.2023',
                        style: AppTextStyles().medium_14_19.copyWith(
                              color: AppColors().white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                height: 29,
                width: 29,
                decoration: BoxDecoration(
                  color: AppColors().primaryText,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Icon(
                      Tennis_icons.refresh1,
                      color: AppColors().accentGreen,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Повторить',
                style: AppTextStyles()
                    .regular_14_19
                    .copyWith(color: AppColors().secondaryText),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 8),
                  child: Text(
                    'Прогресс',
                    style: AppTextStyles()
                        .medium_18_24
                        .copyWith(color: AppColors().primaryText),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Уровень: ${workoutData?.level}',
                    style: AppTextStyles().regular_14_19.copyWith(
                          color: AppColors().secondaryText,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: Text(
                    'Сложность: ${workoutData?.complexity}',
                    style: AppTextStyles().regular_14_19.copyWith(
                          color: AppColors().secondaryText,
                        ),
                  ),
                ),
                Container(
                  width: wm.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors().gradientStart,
                        AppColors().gradientStart.withOpacity(0),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors().white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                '${workoutData?.level}',
                                style: AppTextStyles().regular_14_19.copyWith(
                                      color: AppColors().accentGreen,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${workoutData?.percent}%',
                          style: AppTextStyles()
                              .regular_16_21
                              .copyWith(color: AppColors().white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: AppColors().white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                '${(workoutData?.level.toInt() ?? 0) + 1}',
                                style: AppTextStyles().regular_14_19.copyWith(
                                      color: AppColors().accentGreen,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        GestureDetector(
                          onTap: () => wm.changeSet(currentSet - 1),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: (currentSet + 1) == 1
                                  ? AppColors().accentGreen.withOpacity(0.4)
                                  : AppColors().accentGreen,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Icon(
                                Tennis_icons.back1,
                                size: 12,
                                color: AppColors().white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () => wm.changeSet(currentSet + 1),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: ((currentSet + 1) !=
                                      workoutData?.sets.length)
                                  ? AppColors().accentGreen
                                  : AppColors().accentGreen.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Icon(
                              Icons.chevron_right,
                              size: 22,
                              color: AppColors().white,
                            ),
                          ),
                        ),
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
                              builder: (_, currentGame) => GestureDetector(
                                onTap: () =>
                                    wm.changeGame(game.gameNumber.toInt()),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: game.gameNumber == (currentGame! + 1)
                                        ? AppColors().accentGreen
                                        : AppColors().primaryText,
                                    borderRadius: BorderRadius.circular(8),
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
                                          '77%',
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Отработанные удары',
                    style: AppTextStyles()
                        .medium_18_24
                        .copyWith(color: AppColors().primaryText),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(241, 241, 241, 1),
                          offset: Offset(1, 2),
                          spreadRadius: 0.1,
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors().accentGreen,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Tennis_icons.check,
                                size: 16,
                                color: AppColors().white,
                              ),
                            ),
                          ),
                          Text(
                            'Ок: ${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats.where((element) => element.state == 'Ok').length}',
                            style: AppTextStyles().regular_18_24.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const VerticalDivider(
                            color: Color.fromRGBO(157, 157, 157, 1),
                            thickness: 1,
                            endIndent: 8,
                            indent: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors().gridRed,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Tennis_icons.grid,
                                size: 16,
                                color: AppColors().white,
                              ),
                            ),
                          ),
                          Text(
                            'Сетка: 0',
                            style: AppTextStyles().regular_18_24.copyWith(
                                  color: AppColors().secondaryText,
                                ),
                          ),
                          const VerticalDivider(
                            color: Color.fromRGBO(157, 157, 157, 1),
                            thickness: 1,
                            endIndent: 8,
                            indent: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors().outYellow,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Tennis_icons.out1,
                                size: 14,
                                color: AppColors().white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Аут: ${workoutData?.sets[wm.currentSet.value?.data ?? 0].game[wm.currentGame.value?.data ?? 0].practicedBeats.where((element) => element.state == 'Out').length}',
                              style: AppTextStyles().regular_18_24.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          children: [
                            for (var i = 0; i < 3; i++) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors().white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(241, 241, 241, 1),
                                        offset: Offset(1, 2),
                                        spreadRadius: 0.1,
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '1. Forehand',
                                          style: AppTextStyles()
                                              .semibold_16_21
                                              .copyWith(
                                                color: AppColors().primaryText,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: AppColors().accentGreen,
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Icon(
                                            Tennis_icons.check,
                                            color: AppColors().white,
                                            size: 22,
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
                      ),
                      Column(
                        children: [
                          for (var i = 0; i < 3; i++) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppColors().white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(241, 241, 241, 1),
                                      offset: Offset(1, 2),
                                      spreadRadius: 0.1,
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '1. Forehand',
                                        style: AppTextStyles()
                                            .semibold_16_21
                                            .copyWith(
                                              color: AppColors().primaryText,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: AppColors().accentGreen,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Icon(
                                          Tennis_icons.check,
                                          color: AppColors().white,
                                          size: 22,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
