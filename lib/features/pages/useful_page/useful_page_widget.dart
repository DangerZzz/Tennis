import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/adaptive_refresh_custom_scroll_view.dart';
import 'package:soft_weather_tennis/components/state_widgets/empty_state_widget.dart';
import 'package:soft_weather_tennis/components/state_widgets/error_state_widget.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/useful_page_wm.dart';

/// Main widget for UsefulPage module
class UsefulPageWidget extends ElementaryWidget<IUsefulPageWidgetModel> {
  ///
  const UsefulPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultUsefulPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IUsefulPageWidgetModel wm) {
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
            ),
            child: Text(
              'Советы',
              style: AppTextStyles().bold_24_32.copyWith(
                    color: AppColors().primaryText,
                  ),
            ),
          ),
        ),
        body: AdaptiveRefreshCustomScrollView(
          onRefresh: () => wm.onRefresh(),
          controller: wm.scrollController,
          slivers: [
            EntityStateNotifierBuilder<List<Advice>>(
              listenableEntityState: wm.usefulData,
              loadingBuilder: (_, usefulData) {
                final data = usefulData ?? [];
                return data.isEmpty
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const Center(
                              child: AdaptiveActivityIndicator(),
                            ),
                          ],
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Улучши свою игру, изучая советы от тренеров\nи профессионалов.',
                                      style: AppTextStyles()
                                          .light_12_16
                                          .copyWith(
                                            color: AppColors().secondaryText,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors().accentGreen,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Отличный перекус для настоящих '
                                                'спортсменов - питательные '
                                                'батончики. Не забывай '
                                                'делать перерыв.',
                                                style: AppTextStyles()
                                                    .medium_14_19
                                                    .copyWith(
                                                      color: AppColors().white,
                                                    ),
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/images/arkasha_logo.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (usefulData?.isNotEmpty ?? false)
                                      for (var advice in usefulData!) ...[
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: AppColors().white,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
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
                                                              Radius.circular(
                                                                  12),
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                        ),
                                                        child: OctoImage(
                                                          width: wm.width,
                                                          height: 300,
                                                          fit: BoxFit.cover,
                                                          placeholderBuilder:
                                                              (context) =>
                                                                  const SizedBox(
                                                            child: Center(
                                                              child:
                                                                  AdaptiveActivityIndicator(
                                                                radius: 40,
                                                              ),
                                                            ),
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
                                                                height: 60,
                                                                width: 60,
                                                              ),
                                                            ),
                                                          ),
                                                          image: Image.network(
                                                            advice.imageUrl,
                                                          ).image,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      child: Container(
                                                        height: 73,
                                                        decoration:
                                                            const BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Color.fromRGBO(
                                                                17,
                                                                17,
                                                                17,
                                                                0,
                                                              ),
                                                              Color.fromRGBO(
                                                                17,
                                                                17,
                                                                17,
                                                                0.74,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 12,
                                                      left: 16,
                                                      right: 16,
                                                      child: Builder(
                                                        builder: (context) {
                                                          return SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                48,
                                                            child: Text(
                                                              advice.theme.length >
                                                                      150
                                                                  ? '${advice.theme.substring(
                                                                      0,
                                                                      150,
                                                                    )}...'
                                                                  : advice
                                                                      .theme,
                                                              style:
                                                                  AppTextStyles()
                                                                      .bold_16_21
                                                                      .copyWith(
                                                                        color: AppColors()
                                                                            .white,
                                                                      ),
                                                            ),
                                                          );
                                                        },
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
                                                  24,
                                                ),
                                                child: Text(
                                                  advice.text.length > 5000
                                                      ? '${advice.text.substring(
                                                          0,
                                                          5000,
                                                        )}...'
                                                      : advice.text,
                                                  style: AppTextStyles()
                                                      .regular_14_19
                                                      .copyWith(
                                                        color: AppColors()
                                                            .primaryText,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      wm.toInfoPage(advice.id),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                      color: AppColors()
                                                          .accentGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 16,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Читать далее',
                                                          style: AppTextStyles()
                                                              .semibold_14_21
                                                              .copyWith(
                                                                color:
                                                                    AppColors()
                                                                        .white,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                  ],
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
                        ),
                      );
              },
              errorBuilder: (_, __, ___) => SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ErrorStateWidget(
                      refresh: wm.onRefresh,
                    ),
                  ],
                ),
              ),
              builder: (_, usefulData) => (usefulData?.isNotEmpty ?? false)
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
                                    'Улучши свою игру, изучая советы от тренеров\nи профессионалов.',
                                    style: AppTextStyles().light_12_16.copyWith(
                                          color: AppColors().secondaryText,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: AppColors().accentGreen,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Отличный перекус для настоящих '
                                              'спортсменов - питательные '
                                              'батончики. Не забывай '
                                              'делать перерыв.',
                                              style: AppTextStyles()
                                                  .medium_14_19
                                                  .copyWith(
                                                    color: AppColors().white,
                                                  ),
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/arkasha_logo.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (usefulData?.isNotEmpty ?? false)
                                    for (var advice in usefulData!) ...[
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: AppColors().white,
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
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
                                                            Radius.circular(12),
                                                        topLeft:
                                                            Radius.circular(12),
                                                      ),
                                                      child: OctoImage(
                                                        width: wm.width,
                                                        height: 300,
                                                        fit: BoxFit.cover,
                                                        placeholderBuilder:
                                                            (context) =>
                                                                const SizedBox(
                                                          child: Center(
                                                            child:
                                                                AdaptiveActivityIndicator(
                                                              radius: 40,
                                                            ),
                                                          ),
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
                                                              height: 60,
                                                              width: 60,
                                                            ),
                                                          ),
                                                        ),
                                                        image: Image.network(
                                                          advice.imageUrl,
                                                        ).image,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      height: 73,
                                                      decoration:
                                                          const BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromRGBO(
                                                              17,
                                                              17,
                                                              17,
                                                              0,
                                                            ),
                                                            Color.fromRGBO(
                                                              17,
                                                              17,
                                                              17,
                                                              0.74,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 12,
                                                    left: 16,
                                                    right: 16,
                                                    child: Builder(
                                                      builder: (context) {
                                                        return SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              48,
                                                          child: Text(
                                                            advice.theme.length >
                                                                    150
                                                                ? '${advice.theme.substring(
                                                                    0,
                                                                    150,
                                                                  )}...'
                                                                : advice.theme,
                                                            style:
                                                                AppTextStyles()
                                                                    .bold_16_21
                                                                    .copyWith(
                                                                      color: AppColors()
                                                                          .white,
                                                                    ),
                                                          ),
                                                        );
                                                      },
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
                                                24,
                                              ),
                                              child: Text(
                                                advice.text.length > 5000
                                                    ? '${advice.text.substring(
                                                        0,
                                                        5000,
                                                      )}...'
                                                    : advice.text,
                                                style: AppTextStyles()
                                                    .regular_14_19
                                                    .copyWith(
                                                      color: AppColors()
                                                          .primaryText,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                              ),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    wm.toInfoPage(advice.id),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors().accentGreen,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 16,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Читать далее',
                                                        style: AppTextStyles()
                                                            .semibold_14_21
                                                            .copyWith(
                                                              color: AppColors()
                                                                  .white,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
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
