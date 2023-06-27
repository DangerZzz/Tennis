import 'package:elementary/elementary.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/statistics_in_game/statistics_in_game_wm.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/statistics_list.dart';

/// Страница статистика
class StatisticsPageInGame extends StatelessWidget {
  ///
  final IStatisticsInGameWidgetModel wm;

  ///
  const StatisticsPageInGame({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: EntityStateNotifierBuilder<StatisticsList>(
        listenableEntityState: wm.statisticsData,
        loadingBuilder: (_, __) =>
            const Center(child: AdaptiveActivityIndicator()),
        builder: (_, statisticsData) => statisticsData
                    ?.efficiencyList.isNotEmpty ??
                false
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Последние тренировки',
                          style: AppTextStyles().bold_18_24.copyWith(
                                color: AppColors().primaryText,
                              ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: wm.onCalendar,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: AppColors().primaryText,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Icon(
                              TennisIcons.calendar,
                              color: AppColors().accentGreen,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    for (var training in statisticsData!.efficiencyList) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 11,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors().primaryText,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10,
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        training.type,
                                        style: AppTextStyles()
                                            .medium_14_19
                                            .copyWith(
                                              color: AppColors().white,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      VerticalDivider(
                                        color: AppColors().white,
                                        thickness: 1,
                                        // endIndent: 8,
                                        // indent: 8,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        '${training.efficiency}%',
                                        style: AppTextStyles()
                                            .regular_14_19
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
                            width: 16,
                          ),
                          Flexible(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () => wm.onWorkoutInformation(
                                training.date.toInt(),
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppColors().accentGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 11,
                                  ),
                                  child: Text(
                                    'Открыть',
                                    style: AppTextStyles().bold_14_19.copyWith(
                                          color: AppColors().white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                    const SizedBox(
                      height: 8,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors().white,
                        borderRadius: BorderRadius.circular(8),
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
                                  'Средняя эффективность',
                                  style: AppTextStyles().bold_16_21.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors().primaryText,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      '${statisticsData.averageEfficiency}%',
                                      style:
                                          AppTextStyles().bold_14_19.copyWith(
                                                color: AppColors().accentGreen,
                                              ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 200,
                              child: LineChart(
                                LineChartData(
                                  lineTouchData: LineTouchData(enabled: false),
                                  lineBarsData: [
                                    LineChartBarData(
                                      color: AppColors().accentGreen,
                                      spots: wm.spots,
                                      isCurved: true,
                                      isStrokeCapRound: true,
                                      barWidth: 2,
                                      belowBarData: BarAreaData(
                                        show: false,
                                      ),
                                      dotData: FlDotData(
                                        show: true,
                                        getDotPainter: (
                                          spot,
                                          percent,
                                          barData,
                                          index,
                                        ) =>
                                            FlDotCirclePainter(
                                          radius: 4,
                                          color: AppColors().accentGreen,
                                          strokeColor: AppColors().gradientEnd,
                                        ),
                                      ),
                                    ),
                                  ],
                                  minY: 0,
                                  maxY: 100,
                                  minX: 0,
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 38,
                                        interval: 25,
                                        getTitlesWidget: (value, meta) {
                                          return SideTitleWidget(
                                            axisSide: meta.axisSide,
                                            fitInside:
                                                const SideTitleFitInsideData(
                                              enabled: true,
                                              distanceFromEdge: -10,
                                              parentAxisSize: 0,
                                              axisPosition: 0,
                                            ),
                                            space: 4.0,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text(
                                                '${value.toInt()}',
                                                style: AppTextStyles()
                                                    .regular_12_16
                                                    .copyWith(
                                                      color: AppColors()
                                                          .secondaryText,
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        reservedSize: 30,
                                        getTitlesWidget: (value, meta) {
                                          final text =
                                              wm.yAxisClean(value.toInt());
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16.0,
                                            ),
                                            child: Text(
                                              text,
                                              style: AppTextStyles()
                                                  .regular_12_16
                                                  .copyWith(
                                                    color: AppColors()
                                                        .secondaryText,
                                                  ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                      ),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                      ),
                                    ),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: false,
                                    horizontalInterval: 25,
                                    getDrawingHorizontalLine: (_) => FlLine(
                                      strokeWidth: 1,
                                      color: const Color.fromRGBO(
                                        208,
                                        208,
                                        208,
                                        1,
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
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
              )
            : Column(
                children: [
                  Text(
                    'Вы не сыграли\nеще ни одной игры',
                    textAlign: TextAlign.center,
                    style: AppTextStyles().bold_20_27.copyWith(
                          color: AppColors().primaryText.withOpacity(0.3),
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors().accentGreen,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              TennisIcons.ball,
                              color: AppColors().white,
                              size: 26,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Играть',
                              style: AppTextStyles().semibold_16_21.copyWith(
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
    );
  }
}
