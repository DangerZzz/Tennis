import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/component_styles.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/new_game_pages/new_game_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/trainer_page/domain/current_game_data.dart';

///
class GameProgressPage extends StatelessWidget {
  ///
  final INewGamePageWidgetModel wm;

  ///
  const GameProgressPage({required this.wm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().white,
        // appBar:
        // AppBar(
        //   centerTitle: false,
        //   backgroundColor: AppColors().white,
        //   automaticallyImplyLeading: false,
        //   titleSpacing: 0,
        //   shadowColor: Colors.transparent,
        //   leading: GestureDetector(
        //     onTap: wm.onBack,
        //     child: Icon(
        //       TennisIcons.back,
        //       color: AppColors().primaryText,
        //       size: 16,
        //     ),
        //   ),
        //   title: Text(
        //     'Игра',
        //     style: AppTextStyles().bold_24_32.copyWith(
        //           color: AppColors().primaryText,
        //         ),
        //   ),
        // ),
        body: EntityStateNotifierBuilder<CurrentGameData>(
          listenableEntityState: wm.currentGameData,
          loadingBuilder: (_, __) =>
              const Center(child: AdaptiveActivityIndicator()),
          builder: (_, currentGameData) => Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors().accentGreen,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                ),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Text(
                        'Время',
                        style: AppTextStyles().regular_14_19.copyWith(
                              color: AppColors().white,
                            ),
                      ),
                      EntityStateNotifierBuilder<int>(
                        listenableEntityState: wm.countdownTime,
                        builder: (_, countdownTime) => Text(
                          wm.countdown(countdownTime ?? 0),
                          style: AppTextStyles().super_bold_23_27.copyWith(
                                color: AppColors().white,
                                fontSize: 50,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors().white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppComponentStyles().boxShadow,
                            border: AppComponentStyles().boxBorder,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Уровень: ${currentGameData?.level}',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().secondaryText,
                                      ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  'Сложность: ${wm.currentLevel[1].toString().substring(0, 1)}${wm.currentLevel[1].toString().substring(1).toLowerCase()}',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().secondaryText,
                                      ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Center(
                                  child: Builder(
                                    builder: (context) {
                                      return SvgPicture.asset(
                                        'lib/features/pages/game_page/pages/new_game_pages/assets/images/stage.svg',
                                        height: 137,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: AppColors().accentGreen,
                                //     borderRadius: BorderRadius.circular(
                                //       32,
                                //     ),
                                //     boxShadow:
                                //         AppComponentStyles().boxShadowGreen,
                                //     gradient:
                                //         AppComponentStyles().greenGradient,
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //       horizontal: 16,
                                //       vertical: 4,
                                //     ),
                                //     child: Text(
                                //       '2 000 очков',
                                //       style: AppTextStyles()
                                //           .semibold_16_21
                                //           .copyWith(
                                //             color: AppColors().white,
                                //           ),
                                //     ),
                                //   ),
                                // ),
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
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: AppComponentStyles().boxShadow,
                              border: AppComponentStyles().boxBorder,
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
                                      Text(
                                        'Показатели ${currentSet! + 1} сета',
                                        style: AppTextStyles()
                                            .medium_18_24
                                            .copyWith(
                                                color: AppColors().primaryText),
                                      ),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                wm.changeSet(currentSet - 1),
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: (currentSet + 1) == 1
                                                    ? AppColors()
                                                        .accentGreen
                                                        .withOpacity(0.4)
                                                    : AppColors().accentGreen,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 2.0),
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
                                            onTap: () =>
                                                wm.changeSet(currentSet + 1),
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: ((currentSet + 1) !=
                                                        currentGameData
                                                            ?.sections.length)
                                                    ? AppColors().accentGreen
                                                    : AppColors()
                                                        .accentGreen
                                                        .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Icon(
                                                Icons.chevron_right,
                                                size: 18,
                                                color: AppColors().white,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                            listenableEntityState:
                                                wm.currentGame,
                                            builder: (_, currentGame) =>
                                                GestureDetector(
                                              onTap: () => wm.changeGame(
                                                game.position.toInt(),
                                              ),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: game.position ==
                                                          (currentGame! + 1)
                                                      ? AppColors().accentGreen
                                                      : AppColors().primaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 6,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        '${game.position} гейм',
                                                        style: AppTextStyles()
                                                            .medium_14_19
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .white,
                                                            ),
                                                      ),
                                                      Text(
                                                        '0%',
                                                        style: AppTextStyles()
                                                            .medium_14_19
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .white,
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
                                    boxShadow:
                                        AppComponentStyles().boxShadowBlur,
                                    border: AppComponentStyles().boxBorder,
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                16,
                                                16,
                                                8,
                                                16,
                                              ),
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors().accentGreen,
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
                                              'Ок: ${currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions.where((element) => element.status == 'Ok').length}',
                                              style: AppTextStyles()
                                                  .medium_16_21
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const VerticalDivider(
                                          color:
                                              Color.fromRGBO(157, 157, 157, 1),
                                          thickness: 1,
                                          endIndent: 8,
                                          indent: 8,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
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
                                                    color: AppColors()
                                                        .secondaryText,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const VerticalDivider(
                                          color:
                                              Color.fromRGBO(157, 157, 157, 1),
                                          thickness: 1,
                                          endIndent: 8,
                                          indent: 8,
                                        ),
                                        Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: AppColors().outYellow,
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Icon(
                                                TennisIcons.arrow_diagonal,
                                                size: 10,
                                                color: AppColors().white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Text(
                                              'Аут: ${currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions.where((element) => element.status == 'Out').length}',
                                              style: AppTextStyles()
                                                  .medium_16_21
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            for (var evenValue = 0;
                                                evenValue <
                                                    (currentGameData
                                                            ?.sections[wm
                                                                    .currentSet
                                                                    .value
                                                                    ?.data ??
                                                                0]
                                                            .items[wm
                                                                    .currentGame
                                                                    .value
                                                                    ?.data ??
                                                                0]
                                                            .actions
                                                            .length ??
                                                        0);
                                                evenValue++) ...[
                                              if (evenValue.isEven)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            40,
                                                    decoration: BoxDecoration(
                                                      color: AppColors().white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200),
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 15,
                                                        vertical: 9.0,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[evenValue].type.substring(0, 1)}'
                                                            '${currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[evenValue].type.toLowerCase().substring(1)}',
                                                            style:
                                                                AppTextStyles()
                                                                    .regular_16_21
                                                                    .copyWith(
                                                                      color: currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[evenValue].status !=
                                                                              'INITIAL'
                                                                          ? AppColors()
                                                                              .primaryText
                                                                          : AppColors()
                                                                              .secondaryText,
                                                                    ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: currentGameData
                                                                          ?.sections[wm.currentSet.value?.data ??
                                                                              0]
                                                                          .items[wm.currentGame.value?.data ??
                                                                              0]
                                                                          .actions[
                                                                              evenValue]
                                                                          .status ==
                                                                      'WORKED'
                                                                  ? AppColors()
                                                                      .accentGreen
                                                                  : currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  evenValue]
                                                                              .status ==
                                                                          'OUT'
                                                                      ? AppColors()
                                                                          .outYellow
                                                                      : currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[evenValue].status ==
                                                                              'INITIAL'
                                                                          ? AppColors()
                                                                              .secondaryText
                                                                          : AppColors()
                                                                              .gridRed,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                            ),
                                                            child: Icon(
                                                              (currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  evenValue]
                                                                              .status ==
                                                                          'WORKED' ||
                                                                      currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  evenValue]
                                                                              .status ==
                                                                          'INITIAL')
                                                                  ? TennisIcons
                                                                      .check
                                                                  : currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  evenValue]
                                                                              .status ==
                                                                          'OUT'
                                                                      ? TennisIcons
                                                                          .arrow_diagonal
                                                                      : TennisIcons
                                                                          .grid,
                                                              color: AppColors()
                                                                  .white,
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
                                                    (currentGameData
                                                            ?.sections[wm
                                                                    .currentSet
                                                                    .value
                                                                    ?.data ??
                                                                0]
                                                            .items[wm
                                                                    .currentGame
                                                                    .value
                                                                    ?.data ??
                                                                0]
                                                            .actions
                                                            .length ??
                                                        0);
                                                oddValue++) ...[
                                              if (oddValue.isOdd)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            40,
                                                    decoration: BoxDecoration(
                                                      color: AppColors().white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200),
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 9.0,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[oddValue].type.substring(0, 1)}'
                                                            '${currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[oddValue].type.toLowerCase().substring(1)}',
                                                            style:
                                                                AppTextStyles()
                                                                    .regular_16_21
                                                                    .copyWith(
                                                                      color: currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[oddValue].status !=
                                                                              'INITIAL'
                                                                          ? AppColors()
                                                                              .primaryText
                                                                          : AppColors()
                                                                              .secondaryText,
                                                                    ),
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: currentGameData
                                                                          ?.sections[wm.currentSet.value?.data ??
                                                                              0]
                                                                          .items[wm.currentGame.value?.data ??
                                                                              0]
                                                                          .actions[
                                                                              oddValue]
                                                                          .status ==
                                                                      'WORKED'
                                                                  ? AppColors()
                                                                      .accentGreen
                                                                  : currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  oddValue]
                                                                              .status ==
                                                                          'OUT'
                                                                      ? AppColors()
                                                                          .outYellow
                                                                      : currentGameData?.sections[wm.currentSet.value?.data ?? 0].items[wm.currentGame.value?.data ?? 0].actions[oddValue].status ==
                                                                              'INITIAL'
                                                                          ? AppColors()
                                                                              .secondaryText
                                                                          : AppColors()
                                                                              .gridRed,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                            ),
                                                            child: Icon(
                                                              (currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  oddValue]
                                                                              .status ==
                                                                          'WORKED' ||
                                                                      currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  oddValue]
                                                                              .status ==
                                                                          'INITIAL')
                                                                  ? TennisIcons
                                                                      .check
                                                                  : currentGameData
                                                                              ?.sections[wm.currentSet.value?.data ??
                                                                                  0]
                                                                              .items[wm.currentGame.value?.data ??
                                                                                  0]
                                                                              .actions[
                                                                                  oddValue]
                                                                              .status ==
                                                                          'OUT'
                                                                      ? TennisIcons
                                                                          .arrow_diagonal
                                                                      : TennisIcons
                                                                          .grid,
                                                              color: AppColors()
                                                                  .white,
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
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: GestureDetector(
                  onTap: wm.onBackWithIndex,
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
                          TennisIcons.back,
                          color: AppColors().white,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
