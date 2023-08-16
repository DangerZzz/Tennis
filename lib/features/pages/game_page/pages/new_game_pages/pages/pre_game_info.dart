import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/component_styles.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/state_widgets/error_state_widget.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/preparing_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_wm.dart';

///
class PreGameInfoPage extends StatelessWidget {
  ///
  final INewGamePageWidgetModel wm;

  ///
  const PreGameInfoPage({required this.wm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors().white,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: wm.onBack,
            child: Icon(
              TennisIcons.back,
              color: AppColors().primaryText,
              size: 16,
            ),
          ),
          title: Text(
            'Подготовка к тренировке',
            style: AppTextStyles().bold_24_32.copyWith(
                  color: AppColors().primaryText,
                ),
          ),
        ),
        body: EntityStateNotifierBuilder<PreparingData>(
          listenableEntityState: wm.preparingData,
          loadingBuilder: (_, __) => const Center(
            child: AdaptiveActivityIndicator(),
          ),
          errorBuilder: (_, __, ___) => const ErrorStateWidget(refresh: null),
          builder: (_, preparingData) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors().white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppComponentStyles().boxShadow,
                      border: AppComponentStyles().boxBorder,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Информация',
                            style: AppTextStyles().bold_16_21.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors().primaryText,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        preparingData?.time ?? '00:00',
                                        style: AppTextStyles()
                                            .bold_20_27
                                            .copyWith(
                                              color: AppColors().accentGreen,
                                            ),
                                      ),
                                      Text(
                                        'Время',
                                        style: AppTextStyles()
                                            .regular_14_19
                                            .copyWith(
                                              color: AppColors().accentGreen,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppColors().primaryText,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${preparingData?.sets ?? 0}',
                                        style: AppTextStyles()
                                            .bold_20_27
                                            .copyWith(
                                              color: AppColors().accentGreen,
                                            ),
                                      ),
                                      Text(
                                        'Сеты',
                                        style: AppTextStyles()
                                            .regular_14_19
                                            .copyWith(
                                              color: AppColors().accentGreen,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: AppColors().primaryText,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${preparingData?.games ?? 0}',
                                        style: AppTextStyles()
                                            .bold_20_27
                                            .copyWith(
                                              color: AppColors().accentGreen,
                                            ),
                                      ),
                                      Text(
                                        'Геймы',
                                        style: AppTextStyles()
                                            .regular_14_19
                                            .copyWith(
                                              color: AppColors().accentGreen,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppComponentStyles().boxShadow,
                      border: AppComponentStyles().boxBorder,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Отрабатываемые удары',
                            style: AppTextStyles().bold_16_21.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          Text(
                            'Последовательность ударов и тип.',
                            style: AppTextStyles().regular_14_19.copyWith(
                                  color: AppColors().secondaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Builder(
                            builder: (context) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      for (var evenValue = 0;
                                          evenValue <
                                              (preparingData?.hits.length ?? 0);
                                          evenValue++) ...[
                                        if (evenValue.isEven)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 16.0,
                                            ),
                                            child: Container(
                                              width: 156,
                                              decoration: BoxDecoration(
                                                color: AppColors().white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: AppComponentStyles()
                                                    .boxShadow,
                                                border: AppComponentStyles()
                                                    .boxBorder,
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                                  child: Text(
                                                    ' ${preparingData?.hits[evenValue].substring(0, 1)}${preparingData?.hits[evenValue].substring(1).toLowerCase()}' ??
                                                        '',
                                                    style: AppTextStyles()
                                                        .regular_16_21
                                                        .copyWith(
                                                          color: AppColors()
                                                              .primaryText,
                                                        ),
                                                  ),
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
                                              (preparingData?.hits.length ?? 0);
                                          oddValue++) ...[
                                        if (oddValue.isOdd)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 16.0,
                                            ),
                                            child: Container(
                                              width: 156,
                                              decoration: BoxDecoration(
                                                color: AppColors().white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: AppComponentStyles()
                                                    .boxShadow,
                                                border: AppComponentStyles()
                                                    .boxBorder,
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                                  child: Text(
                                                    ' ${preparingData?.hits[oddValue].substring(0, 1)}${preparingData?.hits[oddValue].substring(1).replaceAll('_', ' ').toLowerCase()}' ??
                                                        '',
                                                    style: AppTextStyles()
                                                        .regular_16_21
                                                        .copyWith(
                                                          color: AppColors()
                                                              .primaryText,
                                                        ),
                                                  ),
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
                  GestureDetector(
                    onTap: wm.onQrPage,
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors().accentGreen,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(213, 255, 95, 1),
                            blurRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Начать',
                          style: AppTextStyles().bold_20_27.copyWith(
                                color: AppColors().white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
