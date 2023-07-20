import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/adaptive_refresh_custom_scroll_view.dart';
import 'package:soft_weather_tennis/components/custom_expansion_tile_card.dart';
import 'package:soft_weather_tennis/components/state_widgets/empty_state_widget.dart';
import 'package:soft_weather_tennis/components/state_widgets/error_state_widget.dart';
import 'package:soft_weather_tennis/features/pages/best_page/best_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list.dart';

/// Main widget for BestPage module
class BestPageWidget extends ElementaryWidget<IBestPageWidgetModel> {
  ///
  const BestPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultBestPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IBestPageWidgetModel wm) {
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
              'Галерея славы',
              style: AppTextStyles().bold_24_32.copyWith(
                    color: AppColors().primaryText,
                  ),
            ),
          ),
        ),
        body: AdaptiveRefreshCustomScrollView(
          onRefresh: () => wm.onRefresh(),
          slivers: [
            EntityStateNotifierBuilder<List<BestData>>(
              listenableEntityState: wm.bestDataList,
              loadingBuilder: (_, __) => SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Center(
                      child: AdaptiveActivityIndicator(),
                    ),
                  ],
                ),
              ),
              errorBuilder: (_, __, ___) => SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ErrorStateWidget(
                      refresh: wm.onRefresh,
                    ),
                  ],
                ),
              ),
              builder: (_, bestDataList) => (bestDataList?.isNotEmpty ?? false)
                  ? SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Следите за лучшими игроками приложения.',
                                    style: AppTextStyles().light_12_16.copyWith(
                                          color: AppColors().secondaryText,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  if (bestDataList?.isNotEmpty ?? false)
                                    for (var bestData in bestDataList!) ...[
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: AppColors().white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                241,
                                                241,
                                                241,
                                                1,
                                              ),
                                              offset: Offset(1, 2),
                                              spreadRadius: 0.1,
                                              blurRadius: 20,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 300,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10),
                                                      ),
                                                      child: OctoImage(
                                                        fit: BoxFit.cover,
                                                        width: wm.width,
                                                        height: 300,
                                                        placeholderBuilder:
                                                            (context) =>
                                                                const Center(
                                                          child:
                                                              AdaptiveActivityIndicator(
                                                            radius: 40,
                                                          ),
                                                        ),
                                                        errorBuilder:
                                                            (c, e, s) => Center(
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/error_placeholder.svg',
                                                            colorFilter:
                                                                ColorFilter
                                                                    .mode(
                                                              AppColors()
                                                                  .accentGreen,
                                                              BlendMode.srcIn,
                                                            ),
                                                            height: 60,
                                                            width: 60,
                                                          ),
                                                        ),
                                                        image: Image.network(
                                                          bestData.imageUrl,
                                                        ).image,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                16,
                                                16,
                                                16,
                                                16,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${bestData.name}, '
                                                          '${bestData.age}',
                                                          style: AppTextStyles()
                                                              .bold_16_21
                                                              .copyWith(
                                                                color: AppColors()
                                                                    .primaryText,
                                                              ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          bestData.rank,
                                                          style: AppTextStyles()
                                                              .regular_14_19
                                                              .copyWith(
                                                                color: AppColors()
                                                                    .secondaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color: AppColors()
                                                          .primaryText,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 5,
                                                      ),
                                                      child: Text(
                                                        'TOP ${bestData.topCount}',
                                                        style: AppTextStyles()
                                                            .medium_14_19
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .accentGreen,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors()
                                                  .secondaryText
                                                  .withOpacity(0.1),
                                              thickness: 1,
                                            ),
                                            // const SizedBox(
                                            //   height: 16,
                                            // ),
                                            if (bestData.description.length <
                                                150)
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  16.0,
                                                ),
                                                child: Text(
                                                  bestData.description,
                                                  style: AppTextStyles()
                                                      .regular_16_21
                                                      .copyWith(
                                                        color: AppColors()
                                                            .primaryText,
                                                      ),
                                                ),
                                              ),
                                            if (bestData.description.length >
                                                150)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  left: 4,
                                                ),
                                                child: ExpansionTileCardCustom(
                                                  title: Text(
                                                    'Подробнее',
                                                    style: AppTextStyles()
                                                        .bold_16_21
                                                        .copyWith(
                                                          color: AppColors()
                                                              .primaryText,
                                                        ),
                                                  ),
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16.0,
                                                      ),
                                                      child: Text(
                                                        bestData.description,
                                                        style: AppTextStyles()
                                                            .regular_16_21
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .primaryText,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                  baseColor: Colors.transparent,
                                                  expandedColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  animateTrailing: true,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          EmptyStateWidget(refresh: wm.onRefresh),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
