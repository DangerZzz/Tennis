import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/state_widgets/empty_state_widget.dart';
import 'package:soft_weather_tennis/components/state_widgets/error_state_widget.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/domain/search_rating_list.dart';
import 'package:soft_weather_tennis/features/pages/rating_page/rating_page_wm.dart';

/// Main widget for RatingPage module
class RatingPageWidget extends ElementaryWidget<IRatingPageWidgetModel> {
  ///
  const RatingPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultRatingPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IRatingPageWidgetModel wm) {
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
              bottom: 12,
            ),
            child: Text(
              'Рейтинг',
              style: AppTextStyles().bold_24_32.copyWith(
                    color: AppColors().primaryText,
                  ),
            ),
          ),
        ),
        body: EntityStateNotifierBuilder<RatingList>(
          listenableEntityState: wm.ratingList,
          loadingBuilder: (_, ratingList) {
            final data = ratingList?.ratingData ?? [];
            return data.isEmpty
                ? const Center(child: AdaptiveActivityIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 60.0),
                              child: Text(
                                'Устраивай соревнования, выигрывай '
                                'достижения и становись лучше!',
                                style: AppTextStyles().light_12_16.copyWith(
                                      color: AppColors().secondaryText,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Галерея славы',
                              style: AppTextStyles().bold_16_21.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment:
                                  ((ratingList?.ratingData.length ?? 0) > 2)
                                      ? MainAxisAlignment.spaceBetween
                                      : ((ratingList?.ratingData.length ?? 0) >
                                              1)
                                          ? MainAxisAlignment.spaceAround
                                          : MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 92,
                                            height: 92,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                250,
                                                190,
                                                23,
                                                1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                width: 90,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  color: AppColors().white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    50,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    3.0,
                                                  ),
                                                  child: SizedBox(
                                                    width: 72,
                                                    height: 72,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        50,
                                                      ),
                                                      child: OctoImage(
                                                        width: 72,
                                                        height: 72,
                                                        fit: BoxFit.cover,
                                                        placeholderBuilder:
                                                            (context) =>
                                                                const Center(
                                                          child:
                                                              AdaptiveActivityIndicator(),
                                                        ),
                                                        errorBuilder:
                                                            (c, e, s) =>
                                                                SizedBox(
                                                          child: Center(
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/error_placeholder.svg',
                                                              colorFilter:
                                                                  ColorFilter
                                                                      .mode(
                                                                AppColors()
                                                                    .accentGreen,
                                                                BlendMode.srcIn,
                                                              ),
                                                              height: 40,
                                                              width: 40,
                                                            ),
                                                          ),
                                                        ),
                                                        image: Image.network(
                                                          ratingList
                                                                  ?.ratingData[
                                                                      0]
                                                                  .avatarUrl ??
                                                              '',
                                                        ).image,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: Container(
                                              height: 23,
                                              width: 23,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                  250,
                                                  190,
                                                  23,
                                                  1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '1',
                                                  style: AppTextStyles()
                                                      .regular_14_19
                                                      .copyWith(
                                                        color:
                                                            AppColors().white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      wm.substringName(
                                        ratingList?.ratingData[0].name ?? '',
                                      ),
                                      style: (ratingList
                                                  ?.ratingData[0].isUser ??
                                              false)
                                          ? AppTextStyles().bold_14_19.copyWith(
                                                color: AppColors().accentGreen,
                                              )
                                          : AppTextStyles().bold_14_19.copyWith(
                                                color: AppColors().primaryText,
                                              ),
                                    ),
                                    Text(
                                      '${ratingList?.ratingData[0].points ?? ''} Очков',
                                      style: (ratingList
                                                  ?.ratingData[0].isUser ??
                                              false)
                                          ? AppTextStyles()
                                              .regular_12_16
                                              .copyWith(
                                                color: AppColors().accentGreen,
                                              )
                                          : AppTextStyles()
                                              .regular_12_16
                                              .copyWith(
                                                color: AppColors().primaryText,
                                              ),
                                    ),
                                  ],
                                ),
                                if ((ratingList?.ratingData.length ?? 0) > 1)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 92,
                                              height: 92,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                  215,
                                                  217,
                                                  216,
                                                  1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  width: 90,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: AppColors().white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      3.0,
                                                    ),
                                                    child: SizedBox(
                                                      width: 72,
                                                      height: 72,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          50,
                                                        ),
                                                        child: OctoImage(
                                                          width: 72,
                                                          height: 72,
                                                          fit: BoxFit.cover,
                                                          placeholderBuilder:
                                                              (context) =>
                                                                  const Center(
                                                            child:
                                                                AdaptiveActivityIndicator(),
                                                          ),
                                                          errorBuilder:
                                                              (c, e, s) =>
                                                                  SizedBox(
                                                            child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/error_placeholder.svg',
                                                                colorFilter:
                                                                    ColorFilter
                                                                        .mode(
                                                                  AppColors()
                                                                      .accentGreen,
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                                height: 40,
                                                                width: 40,
                                                              ),
                                                            ),
                                                          ),
                                                          image: Image.network(
                                                            ratingList
                                                                    ?.ratingData[
                                                                        1]
                                                                    .avatarUrl ??
                                                                '',
                                                          ).image,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: Container(
                                                height: 23,
                                                width: 23,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                    215,
                                                    217,
                                                    216,
                                                    1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    50,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '2',
                                                    style: AppTextStyles()
                                                        .regular_14_19
                                                        .copyWith(
                                                          color:
                                                              AppColors().white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        wm.substringName(
                                          ratingList?.ratingData[1].name ?? '',
                                        ),
                                        style: (ratingList
                                                    ?.ratingData[1].isUser ??
                                                false)
                                            ? AppTextStyles()
                                                .bold_14_19
                                                .copyWith(
                                                  color:
                                                      AppColors().accentGreen,
                                                )
                                            : AppTextStyles()
                                                .bold_14_19
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                ),
                                      ),
                                      Text(
                                        '${ratingList?.ratingData[1].points ?? ''} Очков',
                                        style: (ratingList
                                                    ?.ratingData[1].isUser ??
                                                false)
                                            ? AppTextStyles()
                                                .regular_12_16
                                                .copyWith(
                                                  color:
                                                      AppColors().accentGreen,
                                                )
                                            : AppTextStyles()
                                                .regular_12_16
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                ),
                                      ),
                                    ],
                                  ),
                                if ((ratingList?.ratingData.length ?? 0) > 2)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 92,
                                              height: 92,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                  209,
                                                  121,
                                                  64,
                                                  1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  width: 90,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: AppColors().white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      3.0,
                                                    ),
                                                    child: SizedBox(
                                                      width: 72,
                                                      height: 72,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          50,
                                                        ),
                                                        child: OctoImage(
                                                          width: 72,
                                                          height: 72,
                                                          fit: BoxFit.cover,
                                                          placeholderBuilder:
                                                              (context) =>
                                                                  const Center(
                                                            child:
                                                                AdaptiveActivityIndicator(),
                                                          ),
                                                          errorBuilder:
                                                              (c, e, s) =>
                                                                  SizedBox(
                                                            child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/error_placeholder.svg',
                                                                colorFilter:
                                                                    ColorFilter
                                                                        .mode(
                                                                  AppColors()
                                                                      .accentGreen,
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                                height: 40,
                                                                width: 40,
                                                              ),
                                                            ),
                                                          ),
                                                          image: Image.network(
                                                            ratingList
                                                                    ?.ratingData[
                                                                        2]
                                                                    .avatarUrl ??
                                                                '',
                                                          ).image,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: Container(
                                                height: 23,
                                                width: 23,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                    209,
                                                    121,
                                                    64,
                                                    1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    50,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '3',
                                                    style: AppTextStyles()
                                                        .regular_14_19
                                                        .copyWith(
                                                          color:
                                                              AppColors().white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        wm.substringName(
                                          ratingList?.ratingData[2].name ?? '',
                                        ),
                                        style: (ratingList
                                                    ?.ratingData[2].isUser ??
                                                false)
                                            ? AppTextStyles()
                                                .bold_14_19
                                                .copyWith(
                                                  color:
                                                      AppColors().accentGreen,
                                                )
                                            : AppTextStyles()
                                                .bold_14_19
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                ),
                                      ),
                                      Text(
                                        '${ratingList?.ratingData[2].points ?? ''} Очков',
                                        style: (ratingList
                                                    ?.ratingData[2].isUser ??
                                                false)
                                            ? AppTextStyles()
                                                .regular_12_16
                                                .copyWith(
                                                  color:
                                                      AppColors().accentGreen,
                                                )
                                            : AppTextStyles()
                                                .regular_12_16
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            if ((ratingList?.ratingData.length ?? 0) > 3)
                              EntityStateNotifierBuilder<bool>(
                                listenableEntityState: wm.isSearching,
                                builder: (_, isSearching) => isSearching!
                                    ? DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: AppColors().primaryText,
                                          borderRadius:
                                              BorderRadius.circular(200),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 30,
                                                  child: TextField(
                                                    cursorHeight: 10,
                                                    controller:
                                                        wm.searchController,
                                                    focusNode:
                                                        wm.searchFocusNode,
                                                    autofocus: true,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onChanged: (s) {
                                                      if (s.length >= 3) {
                                                        wm.searching();
                                                      }
                                                    },
                                                    style: AppTextStyles()
                                                        .regular_14_19
                                                        .copyWith(
                                                          color:
                                                              AppColors().white,
                                                          height: 1,
                                                        ),
                                                    decoration: InputDecoration(
                                                      hintText: 'Поиск',
                                                      hintStyle: AppTextStyles()
                                                          .regular_14_19
                                                          .copyWith(
                                                            color: AppColors()
                                                                .secondaryText,
                                                          ),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                onTap: wm.onSearchTap,
                                                child: Icon(
                                                  TennisIcons.search,
                                                  size: 16,
                                                  color:
                                                      AppColors().accentGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Общий рейтинг',
                                            style: AppTextStyles()
                                                .bold_16_21
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                ),
                                          ),
                                          GestureDetector(
                                            onTap: wm.onSearchTap,
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: AppColors().primaryText,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Icon(
                                                TennisIcons.search,
                                                size: 16,
                                                color: AppColors().accentGreen,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      EntityStateNotifierBuilder<bool>(
                        listenableEntityState: wm.isSearching,
                        builder: (_, isSearching) =>
                            EntityStateNotifierBuilder<SearchRatingList>(
                          listenableEntityState: wm.searchedList,
                          loadingBuilder: (_, searchedList) {
                            final data = searchedList?.ratingData ?? [];
                            return data.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 60.0),
                                    child: Center(
                                      child: AdaptiveActivityIndicator(),
                                    ),
                                  )
                                : (wm.searchController.text.length > 2 &&
                                        (isSearching!))
                                    ? Expanded(
                                        child: SingleChildScrollView(
                                          controller: wm.searchScrollController,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (searchedList
                                                      ?.ratingData.isEmpty ??
                                                  true)
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            24),
                                                    child: Text(
                                                      'Ничего не найдено',
                                                      style: AppTextStyles()
                                                          .bold_18_24
                                                          .copyWith(
                                                            color: AppColors()
                                                                .primaryText,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              for (var searchedData
                                                  in searchedList?.ratingData ??
                                                      <Rating>[])
                                                ColoredBox(
                                                  color: searchedData.isUser
                                                      ? AppColors().accentGreen
                                                      : AppColors().white,
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                              20,
                                                              6,
                                                              0,
                                                              6,
                                                            ),
                                                            child: Container(
                                                              width: 54,
                                                              height: 54,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    AppColors()
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  50,
                                                                ),
                                                              ),
                                                              child: Container(
                                                                width: 52,
                                                                height: 52,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    50,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                    3.0,
                                                                  ),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 52,
                                                                    height: 52,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                      child:
                                                                          OctoImage(
                                                                        width:
                                                                            52,
                                                                        height:
                                                                            52,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholderBuilder:
                                                                            (context) =>
                                                                                const Center(
                                                                          child:
                                                                              AdaptiveActivityIndicator(),
                                                                        ),
                                                                        errorBuilder: (
                                                                          c,
                                                                          e,
                                                                          s,
                                                                        ) =>
                                                                            SizedBox(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                SvgPicture.asset(
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
                                                                        image: Image
                                                                            .network(
                                                                          searchedData
                                                                              .avatarUrl,
                                                                        ).image,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 14,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${searchedData.position}. ${searchedData.name}',
                                                                style: searchedData
                                                                        .isUser
                                                                    ? AppTextStyles()
                                                                        .bold_14_19
                                                                        .copyWith(
                                                                          color:
                                                                              AppColors().white,
                                                                        )
                                                                    : AppTextStyles()
                                                                        .regular_14_19
                                                                        .copyWith(
                                                                          color:
                                                                              AppColors().primaryText,
                                                                        ),
                                                              ),
                                                              Text(
                                                                '${searchedData.points} Очков',
                                                                style: searchedData
                                                                        .isUser
                                                                    ? AppTextStyles()
                                                                        .regular_12_16
                                                                        .copyWith(
                                                                          color:
                                                                              AppColors().white,
                                                                        )
                                                                    : AppTextStyles()
                                                                        .regular_12_16
                                                                        .copyWith(
                                                                          color:
                                                                              const Color.fromRGBO(
                                                                            217,
                                                                            217,
                                                                            217,
                                                                            1,
                                                                          ),
                                                                        ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (searchedList
                                                      ?.probablyRatingData
                                                      .isNotEmpty ??
                                                  false) ...[
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 24,
                                                  ),
                                                  child: Divider(
                                                    color: AppColors()
                                                        .secondaryText
                                                        .withOpacity(0.1),
                                                    thickness: 1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16.0,
                                                  ),
                                                  child: Text(
                                                    'Возможно вы искали',
                                                    style: AppTextStyles()
                                                        .bold_12_14
                                                        .copyWith(
                                                          color: AppColors()
                                                              .primaryText,
                                                        ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 22,
                                                ),
                                                for (var searchedData
                                                    in searchedList
                                                            ?.probablyRatingData ??
                                                        <Rating>[])
                                                  ColoredBox(
                                                    color: searchedData.isUser
                                                        ? AppColors()
                                                            .accentGreen
                                                        : AppColors().white,
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                20,
                                                                6,
                                                                0,
                                                                6,
                                                              ),
                                                              child: Container(
                                                                width: 54,
                                                                height: 54,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors()
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    50,
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 52,
                                                                  height: 52,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      3.0,
                                                                    ),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 52,
                                                                      height:
                                                                          52,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                        child:
                                                                            OctoImage(
                                                                          width:
                                                                              52,
                                                                          height:
                                                                              52,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          placeholderBuilder: (context) =>
                                                                              const Center(
                                                                            child:
                                                                                AdaptiveActivityIndicator(),
                                                                          ),
                                                                          errorBuilder: (
                                                                            c,
                                                                            e,
                                                                            s,
                                                                          ) =>
                                                                              SizedBox(
                                                                            child:
                                                                                Center(
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
                                                                          image:
                                                                              Image.network(
                                                                            searchedData.avatarUrl,
                                                                          ).image,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${searchedData.position}. ${searchedData.name}',
                                                                  style: searchedData
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .bold_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().primaryText,
                                                                          ),
                                                                ),
                                                                Text(
                                                                  '${searchedData.points} Очков',
                                                                  style: searchedData
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                const Color.fromRGBO(
                                                                              217,
                                                                              217,
                                                                              217,
                                                                              1,
                                                                            ),
                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const AdaptiveActivityIndicator(),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: SingleChildScrollView(
                                          controller: wm.dataScrollController,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              for (var rating
                                                  in ratingList?.ratingData ??
                                                      <Rating>[]) ...[
                                                if (rating.position > 3)
                                                  if (rating.isUser)
                                                    ColoredBox(
                                                      color: AppColors()
                                                          .accentGreen,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                              28,
                                                              6,
                                                              0,
                                                              6,
                                                            ),
                                                            child: Container(
                                                              width: 64,
                                                              height: 64,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    AppColors()
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  50,
                                                                ),
                                                              ),
                                                              child: Container(
                                                                width: 62,
                                                                height: 62,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    50,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                    3.0,
                                                                  ),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 62,
                                                                    height: 62,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                      child:
                                                                          OctoImage(
                                                                        width:
                                                                            62,
                                                                        height:
                                                                            62,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholderBuilder:
                                                                            (context) =>
                                                                                const Center(
                                                                          child:
                                                                              AdaptiveActivityIndicator(),
                                                                        ),
                                                                        errorBuilder: (
                                                                          c,
                                                                          e,
                                                                          s,
                                                                        ) =>
                                                                            SizedBox(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                SvgPicture.asset(
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
                                                                        image: Image
                                                                            .network(
                                                                          rating
                                                                              .avatarUrl,
                                                                        ).image,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 14,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${rating.position}. ${rating.name}',
                                                                style: rating
                                                                        .isUser
                                                                    ? AppTextStyles()
                                                                        .bold_14_19
                                                                        .copyWith(
                                                                          color:
                                                                              AppColors().white,
                                                                        )
                                                                    : AppTextStyles()
                                                                        .regular_14_19
                                                                        .copyWith(
                                                                          color:
                                                                              AppColors().primaryText,
                                                                        ),
                                                              ),
                                                              Text(
                                                                '${rating.points} Очков',
                                                                style: rating
                                                                        .isUser
                                                                    ? AppTextStyles()
                                                                        .regular_12_16
                                                                        .copyWith(
                                                                          color:
                                                                              AppColors().white,
                                                                        )
                                                                    : AppTextStyles()
                                                                        .regular_12_16
                                                                        .copyWith(
                                                                          color:
                                                                              const Color.fromRGBO(
                                                                            217,
                                                                            217,
                                                                            217,
                                                                            1,
                                                                          ),
                                                                        ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  else
                                                    ColoredBox(
                                                      color: rating.isUser
                                                          ? AppColors()
                                                              .accentGreen
                                                          : AppColors().white,
                                                      child: Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  20,
                                                                  6,
                                                                  0,
                                                                  6,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 54,
                                                                  height: 54,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors()
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 52,
                                                                    height: 52,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                        3.0,
                                                                      ),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            52,
                                                                        height:
                                                                            52,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50,
                                                                          ),
                                                                          child:
                                                                              OctoImage(
                                                                            width:
                                                                                52,
                                                                            height:
                                                                                52,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholderBuilder: (context) =>
                                                                                const Center(
                                                                              child: AdaptiveActivityIndicator(),
                                                                            ),
                                                                            errorBuilder: (
                                                                              c,
                                                                              e,
                                                                              s,
                                                                            ) =>
                                                                                SizedBox(
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
                                                                            image:
                                                                                Image.network(
                                                                              rating.avatarUrl,
                                                                            ).image,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 14,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${rating.position}. ${rating.name}',
                                                                    style: rating
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .bold_14_19
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_14_19
                                                                            .copyWith(
                                                                              color: AppColors().primaryText,
                                                                            ),
                                                                  ),
                                                                  Text(
                                                                    '${rating.points} Очков',
                                                                    style: rating
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: const Color.fromRGBO(
                                                                                217,
                                                                                217,
                                                                                217,
                                                                                1,
                                                                              ),
                                                                            ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              ],
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Center(
                                                child:
                                                    AdaptiveActivityIndicator(),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                          },
                          builder:
                              (_, searchedList) =>
                                  (wm.searchController.text.length > 2 &&
                                          (isSearching!))
                                      ? Expanded(
                                          child: SingleChildScrollView(
                                            controller:
                                                wm.searchScrollController,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (searchedList
                                                        ?.ratingData.isEmpty ??
                                                    true)
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              24),
                                                      child: Text(
                                                        'Ничего не найдено',
                                                        style: AppTextStyles()
                                                            .bold_18_24
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .primaryText,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                for (var searchedData
                                                    in searchedList
                                                            ?.ratingData ??
                                                        <Rating>[])
                                                  ColoredBox(
                                                    color: searchedData.isUser
                                                        ? AppColors()
                                                            .accentGreen
                                                        : AppColors().white,
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                20,
                                                                6,
                                                                0,
                                                                6,
                                                              ),
                                                              child: Container(
                                                                width: 54,
                                                                height: 54,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors()
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    50,
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 52,
                                                                  height: 52,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      3.0,
                                                                    ),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 52,
                                                                      height:
                                                                          52,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                        child:
                                                                            OctoImage(
                                                                          width:
                                                                              52,
                                                                          height:
                                                                              52,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          placeholderBuilder: (context) =>
                                                                              const Center(
                                                                            child:
                                                                                AdaptiveActivityIndicator(),
                                                                          ),
                                                                          errorBuilder: (
                                                                            c,
                                                                            e,
                                                                            s,
                                                                          ) =>
                                                                              SizedBox(
                                                                            child:
                                                                                Center(
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
                                                                          image:
                                                                              Image.network(
                                                                            searchedData.avatarUrl,
                                                                          ).image,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${searchedData.position}. ${searchedData.name}',
                                                                  style: searchedData
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .bold_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().primaryText,
                                                                          ),
                                                                ),
                                                                Text(
                                                                  '${searchedData.points} Очков',
                                                                  style: searchedData
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                const Color.fromRGBO(
                                                                              217,
                                                                              217,
                                                                              217,
                                                                              1,
                                                                            ),
                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (searchedList
                                                        ?.probablyRatingData
                                                        .isNotEmpty ??
                                                    false) ...[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 24,
                                                    ),
                                                    child: Divider(
                                                      color: AppColors()
                                                          .secondaryText
                                                          .withOpacity(0.1),
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16.0,
                                                    ),
                                                    child: Text(
                                                      'Возможно вы искали',
                                                      style: AppTextStyles()
                                                          .bold_12_14
                                                          .copyWith(
                                                            color: AppColors()
                                                                .primaryText,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 22,
                                                  ),
                                                  for (var searchedData
                                                      in searchedList
                                                              ?.probablyRatingData ??
                                                          <Rating>[])
                                                    ColoredBox(
                                                      color: searchedData.isUser
                                                          ? AppColors()
                                                              .accentGreen
                                                          : AppColors().white,
                                                      child: Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  20,
                                                                  6,
                                                                  0,
                                                                  6,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 54,
                                                                  height: 54,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors()
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 52,
                                                                    height: 52,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                        3.0,
                                                                      ),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            52,
                                                                        height:
                                                                            52,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50,
                                                                          ),
                                                                          child:
                                                                              OctoImage(
                                                                            width:
                                                                                52,
                                                                            height:
                                                                                52,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholderBuilder: (context) =>
                                                                                const Center(
                                                                              child: AdaptiveActivityIndicator(),
                                                                            ),
                                                                            errorBuilder: (
                                                                              c,
                                                                              e,
                                                                              s,
                                                                            ) =>
                                                                                SizedBox(
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
                                                                            image:
                                                                                Image.network(
                                                                              searchedData.avatarUrl,
                                                                            ).image,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 14,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${searchedData.position}. ${searchedData.name}',
                                                                    style: searchedData
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .bold_14_19
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_14_19
                                                                            .copyWith(
                                                                              color: AppColors().primaryText,
                                                                            ),
                                                                  ),
                                                                  Text(
                                                                    '${searchedData.points} Очков',
                                                                    style: searchedData
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: const Color.fromRGBO(
                                                                                217,
                                                                                217,
                                                                                217,
                                                                                1,
                                                                              ),
                                                                            ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: SingleChildScrollView(
                                            controller: wm.dataScrollController,
                                            child: Column(
                                              children: [
                                                for (var rating
                                                    in ratingList?.ratingData ??
                                                        <Rating>[]) ...[
                                                  if (rating.position > 3)
                                                    if (rating.isUser)
                                                      ColoredBox(
                                                        color: AppColors()
                                                            .accentGreen,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                28,
                                                                6,
                                                                0,
                                                                6,
                                                              ),
                                                              child: Container(
                                                                width: 64,
                                                                height: 64,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors()
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    50,
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 62,
                                                                  height: 62,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      3.0,
                                                                    ),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 62,
                                                                      height:
                                                                          62,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                        child:
                                                                            OctoImage(
                                                                          width:
                                                                              62,
                                                                          height:
                                                                              62,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          placeholderBuilder: (context) =>
                                                                              const Center(
                                                                            child:
                                                                                AdaptiveActivityIndicator(),
                                                                          ),
                                                                          errorBuilder: (
                                                                            c,
                                                                            e,
                                                                            s,
                                                                          ) =>
                                                                              SizedBox(
                                                                            child:
                                                                                Center(
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
                                                                          image:
                                                                              Image.network(
                                                                            rating.avatarUrl,
                                                                          ).image,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${rating.position}. ${rating.name}',
                                                                  style: rating
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .bold_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().primaryText,
                                                                          ),
                                                                ),
                                                                Text(
                                                                  '${rating.points} Очков',
                                                                  style: rating
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                const Color.fromRGBO(
                                                                              217,
                                                                              217,
                                                                              217,
                                                                              1,
                                                                            ),
                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    else
                                                      ColoredBox(
                                                        color: rating.isUser
                                                            ? AppColors()
                                                                .accentGreen
                                                            : AppColors().white,
                                                        child: Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                    20,
                                                                    6,
                                                                    0,
                                                                    6,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 54,
                                                                    height: 54,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors()
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: 52,
                                                                      height:
                                                                          52,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                          3.0,
                                                                        ),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              52,
                                                                          height:
                                                                              52,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              50,
                                                                            ),
                                                                            child:
                                                                                OctoImage(
                                                                              width: 52,
                                                                              height: 52,
                                                                              fit: BoxFit.cover,
                                                                              placeholderBuilder: (context) => const Center(
                                                                                child: AdaptiveActivityIndicator(),
                                                                              ),
                                                                              errorBuilder: (
                                                                                c,
                                                                                e,
                                                                                s,
                                                                              ) =>
                                                                                  SizedBox(
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
                                                                                rating.avatarUrl,
                                                                              ).image,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 14,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${rating.position}. ${rating.name}',
                                                                      style: rating
                                                                              .isUser
                                                                          ? AppTextStyles()
                                                                              .bold_14_19
                                                                              .copyWith(
                                                                                color: AppColors().white,
                                                                              )
                                                                          : AppTextStyles()
                                                                              .regular_14_19
                                                                              .copyWith(
                                                                                color: AppColors().primaryText,
                                                                              ),
                                                                    ),
                                                                    Text(
                                                                      '${rating.points} Очков',
                                                                      style: rating
                                                                              .isUser
                                                                          ? AppTextStyles()
                                                                              .regular_12_16
                                                                              .copyWith(
                                                                                color: AppColors().white,
                                                                              )
                                                                          : AppTextStyles()
                                                                              .regular_12_16
                                                                              .copyWith(
                                                                                color: const Color.fromRGBO(
                                                                                  217,
                                                                                  217,
                                                                                  217,
                                                                                  1,
                                                                                ),
                                                                              ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const AdaptiveActivityIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
          },
          errorBuilder: (_, __, ___) => ErrorStateWidget(
            refresh: wm.onRefresh,
          ),
          builder: (_, ratingList) =>
              (ratingList?.ratingData.isNotEmpty ?? false)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 60.0),
                                child: Text(
                                  'Устраивай соревнования, выигрывай '
                                  'достижения и становись лучше!',
                                  style: AppTextStyles().light_12_16.copyWith(
                                        color: AppColors().secondaryText,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                'Галерея славы',
                                style: AppTextStyles().bold_16_21.copyWith(
                                      color: AppColors().primaryText,
                                    ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: ((ratingList
                                                ?.ratingData.length ??
                                            0) >
                                        2)
                                    ? MainAxisAlignment.spaceBetween
                                    : ((ratingList?.ratingData.length ?? 0) > 1)
                                        ? MainAxisAlignment.spaceAround
                                        : MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 92,
                                              height: 92,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                  250,
                                                  190,
                                                  23,
                                                  1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  width: 90,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: AppColors().white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      3.0,
                                                    ),
                                                    child: SizedBox(
                                                      width: 72,
                                                      height: 72,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          50,
                                                        ),
                                                        child: OctoImage(
                                                          width: 72,
                                                          height: 72,
                                                          fit: BoxFit.cover,
                                                          placeholderBuilder:
                                                              (context) =>
                                                                  const Center(
                                                            child:
                                                                AdaptiveActivityIndicator(),
                                                          ),
                                                          errorBuilder:
                                                              (c, e, s) =>
                                                                  SizedBox(
                                                            child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/error_placeholder.svg',
                                                                colorFilter:
                                                                    ColorFilter
                                                                        .mode(
                                                                  AppColors()
                                                                      .accentGreen,
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                                height: 40,
                                                                width: 40,
                                                              ),
                                                            ),
                                                          ),
                                                          image: Image.network(
                                                            ratingList
                                                                    ?.ratingData[
                                                                        0]
                                                                    .avatarUrl ??
                                                                '',
                                                          ).image,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: Container(
                                                height: 23,
                                                width: 23,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                    250,
                                                    190,
                                                    23,
                                                    1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    50,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '1',
                                                    style: AppTextStyles()
                                                        .regular_14_19
                                                        .copyWith(
                                                          color:
                                                              AppColors().white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        wm.substringName(
                                          ratingList?.ratingData[0].name ?? '',
                                        ),
                                        style: (ratingList
                                                    ?.ratingData[0].isUser ??
                                                false)
                                            ? AppTextStyles()
                                                .bold_14_19
                                                .copyWith(
                                                  color:
                                                      AppColors().accentGreen,
                                                )
                                            : AppTextStyles()
                                                .bold_14_19
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                ),
                                      ),
                                      Text(
                                        '${ratingList?.ratingData[0].points ?? ''} Очков',
                                        style: (ratingList
                                                    ?.ratingData[0].isUser ??
                                                false)
                                            ? AppTextStyles()
                                                .regular_12_16
                                                .copyWith(
                                                  color:
                                                      AppColors().accentGreen,
                                                )
                                            : AppTextStyles()
                                                .regular_12_16
                                                .copyWith(
                                                  color:
                                                      AppColors().primaryText,
                                                ),
                                      ),
                                    ],
                                  ),
                                  if ((ratingList?.ratingData.length ?? 0) > 1)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 92,
                                                height: 92,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                    215,
                                                    217,
                                                    216,
                                                    1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Container(
                                                    width: 90,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                      color: AppColors().white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        50,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        3.0,
                                                      ),
                                                      child: SizedBox(
                                                        width: 72,
                                                        height: 72,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            50,
                                                          ),
                                                          child: OctoImage(
                                                            width: 72,
                                                            height: 72,
                                                            fit: BoxFit.cover,
                                                            placeholderBuilder:
                                                                (context) =>
                                                                    const Center(
                                                              child:
                                                                  AdaptiveActivityIndicator(),
                                                            ),
                                                            errorBuilder:
                                                                (c, e, s) =>
                                                                    SizedBox(
                                                              child: Center(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/error_placeholder.svg',
                                                                  colorFilter:
                                                                      ColorFilter
                                                                          .mode(
                                                                    AppColors()
                                                                        .accentGreen,
                                                                    BlendMode
                                                                        .srcIn,
                                                                  ),
                                                                  height: 40,
                                                                  width: 40,
                                                                ),
                                                              ),
                                                            ),
                                                            image:
                                                                Image.network(
                                                              ratingList
                                                                      ?.ratingData[
                                                                          1]
                                                                      .avatarUrl ??
                                                                  '',
                                                            ).image,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: Container(
                                                  height: 23,
                                                  width: 23,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                      215,
                                                      217,
                                                      216,
                                                      1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '2',
                                                      style: AppTextStyles()
                                                          .regular_14_19
                                                          .copyWith(
                                                            color: AppColors()
                                                                .white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          wm.substringName(
                                            ratingList?.ratingData[1].name ??
                                                '',
                                          ),
                                          style: (ratingList
                                                      ?.ratingData[1].isUser ??
                                                  false)
                                              ? AppTextStyles()
                                                  .bold_14_19
                                                  .copyWith(
                                                    color:
                                                        AppColors().accentGreen,
                                                  )
                                              : AppTextStyles()
                                                  .bold_14_19
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                        ),
                                        Text(
                                          '${ratingList?.ratingData[1].points ?? ''} Очков',
                                          style: (ratingList
                                                      ?.ratingData[1].isUser ??
                                                  false)
                                              ? AppTextStyles()
                                                  .regular_12_16
                                                  .copyWith(
                                                    color:
                                                        AppColors().accentGreen,
                                                  )
                                              : AppTextStyles()
                                                  .regular_12_16
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                        ),
                                      ],
                                    ),
                                  if ((ratingList?.ratingData.length ?? 0) > 2)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 92,
                                                height: 92,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                    209,
                                                    121,
                                                    64,
                                                    1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Container(
                                                    width: 90,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                      color: AppColors().white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        50,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        3.0,
                                                      ),
                                                      child: SizedBox(
                                                        width: 72,
                                                        height: 72,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            50,
                                                          ),
                                                          child: OctoImage(
                                                            width: 72,
                                                            height: 72,
                                                            fit: BoxFit.cover,
                                                            placeholderBuilder:
                                                                (context) =>
                                                                    const Center(
                                                              child:
                                                                  AdaptiveActivityIndicator(),
                                                            ),
                                                            errorBuilder:
                                                                (c, e, s) =>
                                                                    SizedBox(
                                                              child: Center(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/error_placeholder.svg',
                                                                  colorFilter:
                                                                      ColorFilter
                                                                          .mode(
                                                                    AppColors()
                                                                        .accentGreen,
                                                                    BlendMode
                                                                        .srcIn,
                                                                  ),
                                                                  height: 40,
                                                                  width: 40,
                                                                ),
                                                              ),
                                                            ),
                                                            image:
                                                                Image.network(
                                                              ratingList
                                                                      ?.ratingData[
                                                                          2]
                                                                      .avatarUrl ??
                                                                  '',
                                                            ).image,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 5,
                                                right: 5,
                                                child: Container(
                                                  height: 23,
                                                  width: 23,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                      209,
                                                      121,
                                                      64,
                                                      1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '3',
                                                      style: AppTextStyles()
                                                          .regular_14_19
                                                          .copyWith(
                                                            color: AppColors()
                                                                .white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          wm.substringName(
                                            ratingList?.ratingData[2].name ??
                                                '',
                                          ),
                                          style: (ratingList
                                                      ?.ratingData[2].isUser ??
                                                  false)
                                              ? AppTextStyles()
                                                  .bold_14_19
                                                  .copyWith(
                                                    color:
                                                        AppColors().accentGreen,
                                                  )
                                              : AppTextStyles()
                                                  .bold_14_19
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                        ),
                                        Text(
                                          '${ratingList?.ratingData[2].points ?? ''} Очков',
                                          style: (ratingList
                                                      ?.ratingData[2].isUser ??
                                                  false)
                                              ? AppTextStyles()
                                                  .regular_12_16
                                                  .copyWith(
                                                    color:
                                                        AppColors().accentGreen,
                                                  )
                                              : AppTextStyles()
                                                  .regular_12_16
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              if ((ratingList?.ratingData.length ?? 0) > 3)
                                EntityStateNotifierBuilder<bool>(
                                  listenableEntityState: wm.isSearching,
                                  builder: (_, isSearching) => isSearching!
                                      ? DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: AppColors().primaryText,
                                            borderRadius:
                                                BorderRadius.circular(200),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 30,
                                                    child: TextField(
                                                      cursorHeight: 10,
                                                      controller:
                                                          wm.searchController,
                                                      focusNode:
                                                          wm.searchFocusNode,
                                                      autofocus: true,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      onChanged: (s) {
                                                        if (s.length >= 3) {
                                                          wm.searching();
                                                        }
                                                      },
                                                      style: AppTextStyles()
                                                          .regular_14_19
                                                          .copyWith(
                                                            color: AppColors()
                                                                .white,
                                                            height: 1,
                                                          ),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Поиск',
                                                        hintStyle:
                                                            AppTextStyles()
                                                                .regular_14_19
                                                                .copyWith(
                                                                  color: AppColors()
                                                                      .secondaryText,
                                                                ),
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                GestureDetector(
                                                  onTap: wm.onSearchTap,
                                                  child: Icon(
                                                    TennisIcons.search,
                                                    size: 16,
                                                    color:
                                                        AppColors().accentGreen,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Общий рейтинг',
                                              style: AppTextStyles()
                                                  .bold_16_21
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                            ),
                                            GestureDetector(
                                              onTap: wm.onSearchTap,
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors().primaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  TennisIcons.search,
                                                  size: 16,
                                                  color:
                                                      AppColors().accentGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        EntityStateNotifierBuilder<bool>(
                          listenableEntityState: wm.isSearching,
                          builder: (_, isSearching) =>
                              EntityStateNotifierBuilder<SearchRatingList>(
                            listenableEntityState: wm.searchedList,
                            loadingBuilder: (_, searchedList) {
                              final data = searchedList?.ratingData ?? [];
                              return data.isEmpty
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 60.0),
                                      child: Center(
                                        child: AdaptiveActivityIndicator(),
                                      ),
                                    )
                                  : (wm.searchController.text.length > 2 &&
                                          (isSearching!))
                                      ? Expanded(
                                          child: SingleChildScrollView(
                                            controller:
                                                wm.searchScrollController,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (searchedList
                                                        ?.ratingData.isEmpty ??
                                                    true)
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              24),
                                                      child: Text(
                                                        'Ничего не найдено',
                                                        style: AppTextStyles()
                                                            .bold_18_24
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .primaryText,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                for (var searchedData
                                                    in searchedList
                                                            ?.ratingData ??
                                                        <Rating>[])
                                                  ColoredBox(
                                                    color: searchedData.isUser
                                                        ? AppColors()
                                                            .accentGreen
                                                        : AppColors().white,
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                20,
                                                                6,
                                                                0,
                                                                6,
                                                              ),
                                                              child: Container(
                                                                width: 54,
                                                                height: 54,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors()
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    50,
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 52,
                                                                  height: 52,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      3.0,
                                                                    ),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 52,
                                                                      height:
                                                                          52,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                        child:
                                                                            OctoImage(
                                                                          width:
                                                                              52,
                                                                          height:
                                                                              52,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          placeholderBuilder: (context) =>
                                                                              const Center(
                                                                            child:
                                                                                AdaptiveActivityIndicator(),
                                                                          ),
                                                                          errorBuilder: (
                                                                            c,
                                                                            e,
                                                                            s,
                                                                          ) =>
                                                                              SizedBox(
                                                                            child:
                                                                                Center(
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
                                                                          image:
                                                                              Image.network(
                                                                            searchedData.avatarUrl,
                                                                          ).image,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${searchedData.position}. ${searchedData.name}',
                                                                  style: searchedData
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .bold_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().primaryText,
                                                                          ),
                                                                ),
                                                                Text(
                                                                  '${searchedData.points} Очков',
                                                                  style: searchedData
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                const Color.fromRGBO(
                                                                              217,
                                                                              217,
                                                                              217,
                                                                              1,
                                                                            ),
                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (searchedList
                                                        ?.probablyRatingData
                                                        .isNotEmpty ??
                                                    false) ...[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 24,
                                                    ),
                                                    child: Divider(
                                                      color: AppColors()
                                                          .secondaryText
                                                          .withOpacity(0.1),
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16.0,
                                                    ),
                                                    child: Text(
                                                      'Возможно вы искали',
                                                      style: AppTextStyles()
                                                          .bold_12_14
                                                          .copyWith(
                                                            color: AppColors()
                                                                .primaryText,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 22,
                                                  ),
                                                  for (var searchedData
                                                      in searchedList
                                                              ?.probablyRatingData ??
                                                          <Rating>[])
                                                    ColoredBox(
                                                      color: searchedData.isUser
                                                          ? AppColors()
                                                              .accentGreen
                                                          : AppColors().white,
                                                      child: Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  20,
                                                                  6,
                                                                  0,
                                                                  6,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 54,
                                                                  height: 54,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors()
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 52,
                                                                    height: 52,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                        3.0,
                                                                      ),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            52,
                                                                        height:
                                                                            52,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50,
                                                                          ),
                                                                          child:
                                                                              OctoImage(
                                                                            width:
                                                                                52,
                                                                            height:
                                                                                52,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholderBuilder: (context) =>
                                                                                const Center(
                                                                              child: AdaptiveActivityIndicator(),
                                                                            ),
                                                                            errorBuilder: (
                                                                              c,
                                                                              e,
                                                                              s,
                                                                            ) =>
                                                                                SizedBox(
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
                                                                            image:
                                                                                Image.network(
                                                                              searchedData.avatarUrl,
                                                                            ).image,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 14,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${searchedData.position}. ${searchedData.name}',
                                                                    style: searchedData
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .bold_14_19
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_14_19
                                                                            .copyWith(
                                                                              color: AppColors().primaryText,
                                                                            ),
                                                                  ),
                                                                  Text(
                                                                    '${searchedData.points} Очков',
                                                                    style: searchedData
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: const Color.fromRGBO(
                                                                                217,
                                                                                217,
                                                                                217,
                                                                                1,
                                                                              ),
                                                                            ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Center(
                                                  child:
                                                      AdaptiveActivityIndicator(),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: SingleChildScrollView(
                                            controller: wm.dataScrollController,
                                            child: Column(
                                              children: [
                                                for (var rating
                                                    in ratingList?.ratingData ??
                                                        <Rating>[]) ...[
                                                  if (rating.position > 3)
                                                    if (rating.isUser)
                                                      ColoredBox(
                                                        color: AppColors()
                                                            .accentGreen,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                28,
                                                                6,
                                                                0,
                                                                6,
                                                              ),
                                                              child: Container(
                                                                width: 64,
                                                                height: 64,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors()
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    50,
                                                                  ),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 62,
                                                                  height: 62,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                      3.0,
                                                                    ),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 62,
                                                                      height:
                                                                          62,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                        child:
                                                                            OctoImage(
                                                                          width:
                                                                              62,
                                                                          height:
                                                                              62,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          placeholderBuilder: (context) =>
                                                                              const Center(
                                                                            child:
                                                                                AdaptiveActivityIndicator(),
                                                                          ),
                                                                          errorBuilder: (
                                                                            c,
                                                                            e,
                                                                            s,
                                                                          ) =>
                                                                              SizedBox(
                                                                            child:
                                                                                Center(
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
                                                                          image:
                                                                              Image.network(
                                                                            rating.avatarUrl,
                                                                          ).image,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${rating.position}. ${rating.name}',
                                                                  style: rating
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .bold_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_14_19
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().primaryText,
                                                                          ),
                                                                ),
                                                                Text(
                                                                  '${rating.points} Очков',
                                                                  style: rating
                                                                          .isUser
                                                                      ? AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                AppColors().white,
                                                                          )
                                                                      : AppTextStyles()
                                                                          .regular_12_16
                                                                          .copyWith(
                                                                            color:
                                                                                const Color.fromRGBO(
                                                                              217,
                                                                              217,
                                                                              217,
                                                                              1,
                                                                            ),
                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    else
                                                      ColoredBox(
                                                        color: rating.isUser
                                                            ? AppColors()
                                                                .accentGreen
                                                            : AppColors().white,
                                                        child: Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                    20,
                                                                    6,
                                                                    0,
                                                                    6,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 54,
                                                                    height: 54,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors()
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: 52,
                                                                      height:
                                                                          52,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                          3.0,
                                                                        ),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              52,
                                                                          height:
                                                                              52,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              50,
                                                                            ),
                                                                            child:
                                                                                OctoImage(
                                                                              width: 52,
                                                                              height: 52,
                                                                              fit: BoxFit.cover,
                                                                              placeholderBuilder: (context) => const Center(
                                                                                child: AdaptiveActivityIndicator(),
                                                                              ),
                                                                              errorBuilder: (
                                                                                c,
                                                                                e,
                                                                                s,
                                                                              ) =>
                                                                                  SizedBox(
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
                                                                                rating.avatarUrl,
                                                                              ).image,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 14,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${rating.position}. ${rating.name}',
                                                                      style: rating
                                                                              .isUser
                                                                          ? AppTextStyles()
                                                                              .bold_14_19
                                                                              .copyWith(
                                                                                color: AppColors().white,
                                                                              )
                                                                          : AppTextStyles()
                                                                              .regular_14_19
                                                                              .copyWith(
                                                                                color: AppColors().primaryText,
                                                                              ),
                                                                    ),
                                                                    Text(
                                                                      '${rating.points} Очков',
                                                                      style: rating
                                                                              .isUser
                                                                          ? AppTextStyles()
                                                                              .regular_12_16
                                                                              .copyWith(
                                                                                color: AppColors().white,
                                                                              )
                                                                          : AppTextStyles()
                                                                              .regular_12_16
                                                                              .copyWith(
                                                                                color: const Color.fromRGBO(
                                                                                  217,
                                                                                  217,
                                                                                  217,
                                                                                  1,
                                                                                ),
                                                                              ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  const AdaptiveActivityIndicator(),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        );
                            },
                            builder:
                                (_, searchedList) =>
                                    (wm.searchController.text.length > 2 &&
                                            (isSearching!))
                                        ? Expanded(
                                            child: SingleChildScrollView(
                                              controller:
                                                  wm.searchScrollController,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (searchedList?.ratingData
                                                          .isEmpty ??
                                                      true)
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(24),
                                                        child: Text(
                                                          'Ничего не найдено',
                                                          style: AppTextStyles()
                                                              .bold_18_24
                                                              .copyWith(
                                                                color: AppColors()
                                                                    .primaryText,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  for (var searchedData
                                                      in searchedList
                                                              ?.ratingData ??
                                                          <Rating>[])
                                                    ColoredBox(
                                                      color: searchedData.isUser
                                                          ? AppColors()
                                                              .accentGreen
                                                          : AppColors().white,
                                                      child: Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  20,
                                                                  6,
                                                                  0,
                                                                  6,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 54,
                                                                  height: 54,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors()
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 52,
                                                                    height: 52,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                        3.0,
                                                                      ),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            52,
                                                                        height:
                                                                            52,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50,
                                                                          ),
                                                                          child:
                                                                              OctoImage(
                                                                            width:
                                                                                52,
                                                                            height:
                                                                                52,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholderBuilder: (context) =>
                                                                                const Center(
                                                                              child: AdaptiveActivityIndicator(),
                                                                            ),
                                                                            errorBuilder: (
                                                                              c,
                                                                              e,
                                                                              s,
                                                                            ) =>
                                                                                SizedBox(
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
                                                                            image:
                                                                                Image.network(
                                                                              searchedData.avatarUrl,
                                                                            ).image,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 14,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${searchedData.position}. ${searchedData.name}',
                                                                    style: searchedData
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .bold_14_19
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_14_19
                                                                            .copyWith(
                                                                              color: AppColors().primaryText,
                                                                            ),
                                                                  ),
                                                                  Text(
                                                                    '${searchedData.points} Очков',
                                                                    style: searchedData
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: const Color.fromRGBO(
                                                                                217,
                                                                                217,
                                                                                217,
                                                                                1,
                                                                              ),
                                                                            ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  if (searchedList
                                                          ?.probablyRatingData
                                                          .isNotEmpty ??
                                                      false) ...[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 24,
                                                      ),
                                                      child: Divider(
                                                        color: AppColors()
                                                            .secondaryText
                                                            .withOpacity(0.1),
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 16.0,
                                                      ),
                                                      child: Text(
                                                        'Возможно вы искали',
                                                        style: AppTextStyles()
                                                            .bold_12_14
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .primaryText,
                                                            ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 22,
                                                    ),
                                                    for (var searchedData
                                                        in searchedList
                                                                ?.probablyRatingData ??
                                                            <Rating>[])
                                                      ColoredBox(
                                                        color: searchedData
                                                                .isUser
                                                            ? AppColors()
                                                                .accentGreen
                                                            : AppColors().white,
                                                        child: Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                    20,
                                                                    6,
                                                                    0,
                                                                    6,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 54,
                                                                    height: 54,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors()
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: 52,
                                                                      height:
                                                                          52,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                          3.0,
                                                                        ),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              52,
                                                                          height:
                                                                              52,
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              50,
                                                                            ),
                                                                            child:
                                                                                OctoImage(
                                                                              width: 52,
                                                                              height: 52,
                                                                              fit: BoxFit.cover,
                                                                              placeholderBuilder: (context) => const Center(
                                                                                child: AdaptiveActivityIndicator(),
                                                                              ),
                                                                              errorBuilder: (
                                                                                c,
                                                                                e,
                                                                                s,
                                                                              ) =>
                                                                                  SizedBox(
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
                                                                                searchedData.avatarUrl,
                                                                              ).image,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 14,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${searchedData.position}. ${searchedData.name}',
                                                                      style: searchedData
                                                                              .isUser
                                                                          ? AppTextStyles()
                                                                              .bold_14_19
                                                                              .copyWith(
                                                                                color: AppColors().white,
                                                                              )
                                                                          : AppTextStyles()
                                                                              .regular_14_19
                                                                              .copyWith(
                                                                                color: AppColors().primaryText,
                                                                              ),
                                                                    ),
                                                                    Text(
                                                                      '${searchedData.points} Очков',
                                                                      style: searchedData
                                                                              .isUser
                                                                          ? AppTextStyles()
                                                                              .regular_12_16
                                                                              .copyWith(
                                                                                color: AppColors().white,
                                                                              )
                                                                          : AppTextStyles()
                                                                              .regular_12_16
                                                                              .copyWith(
                                                                                color: const Color.fromRGBO(
                                                                                  217,
                                                                                  217,
                                                                                  217,
                                                                                  1,
                                                                                ),
                                                                              ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            child: SingleChildScrollView(
                                              controller:
                                                  wm.dataScrollController,
                                              child: Column(
                                                children: [
                                                  for (var rating in ratingList
                                                          ?.ratingData ??
                                                      <Rating>[]) ...[
                                                    if (rating.position > 3)
                                                      if (rating.isUser)
                                                        ColoredBox(
                                                          color: AppColors()
                                                              .accentGreen,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .fromLTRB(
                                                                  28,
                                                                  6,
                                                                  0,
                                                                  6,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 64,
                                                                  height: 64,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors()
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      50,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 62,
                                                                    height: 62,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                        3.0,
                                                                      ),
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            62,
                                                                        height:
                                                                            62,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50,
                                                                          ),
                                                                          child:
                                                                              OctoImage(
                                                                            width:
                                                                                62,
                                                                            height:
                                                                                62,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            placeholderBuilder: (context) =>
                                                                                const Center(
                                                                              child: AdaptiveActivityIndicator(),
                                                                            ),
                                                                            errorBuilder: (
                                                                              c,
                                                                              e,
                                                                              s,
                                                                            ) =>
                                                                                SizedBox(
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
                                                                            image:
                                                                                Image.network(
                                                                              rating.avatarUrl,
                                                                            ).image,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 14,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${rating.position}. ${rating.name}',
                                                                    style: rating
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .bold_14_19
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_14_19
                                                                            .copyWith(
                                                                              color: AppColors().primaryText,
                                                                            ),
                                                                  ),
                                                                  Text(
                                                                    '${rating.points} Очков',
                                                                    style: rating
                                                                            .isUser
                                                                        ? AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: AppColors().white,
                                                                            )
                                                                        : AppTextStyles()
                                                                            .regular_12_16
                                                                            .copyWith(
                                                                              color: const Color.fromRGBO(
                                                                                217,
                                                                                217,
                                                                                217,
                                                                                1,
                                                                              ),
                                                                            ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      else
                                                        ColoredBox(
                                                          color: rating.isUser
                                                              ? AppColors()
                                                                  .accentGreen
                                                              : AppColors()
                                                                  .white,
                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                      20,
                                                                      6,
                                                                      0,
                                                                      6,
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: 54,
                                                                      height:
                                                                          54,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors()
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          50,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            52,
                                                                        height:
                                                                            52,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            50,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                            3.0,
                                                                          ),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                52,
                                                                            height:
                                                                                52,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(
                                                                                50,
                                                                              ),
                                                                              child: OctoImage(
                                                                                width: 52,
                                                                                height: 52,
                                                                                fit: BoxFit.cover,
                                                                                placeholderBuilder: (context) => const Center(
                                                                                  child: AdaptiveActivityIndicator(),
                                                                                ),
                                                                                errorBuilder: (
                                                                                  c,
                                                                                  e,
                                                                                  s,
                                                                                ) =>
                                                                                    SizedBox(
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
                                                                                  rating.avatarUrl,
                                                                                ).image,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 14,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        '${rating.position}. ${rating.name}',
                                                                        style: rating.isUser
                                                                            ? AppTextStyles().bold_14_19.copyWith(
                                                                                  color: AppColors().white,
                                                                                )
                                                                            : AppTextStyles().regular_14_19.copyWith(
                                                                                  color: AppColors().primaryText,
                                                                                ),
                                                                      ),
                                                                      Text(
                                                                        '${rating.points} Очков',
                                                                        style: rating.isUser
                                                                            ? AppTextStyles().regular_12_16.copyWith(
                                                                                  color: AppColors().white,
                                                                                )
                                                                            : AppTextStyles().regular_12_16.copyWith(
                                                                                  color: const Color.fromRGBO(
                                                                                    217,
                                                                                    217,
                                                                                    217,
                                                                                    1,
                                                                                  ),
                                                                                ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                          ),
                        ),
                      ],
                    )
                  : EmptyStateWidget(refresh: wm.onRefresh),
        ),
      ),
    );
  }
}
