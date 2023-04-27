import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/adaptive_refresh_custom_scroll_view.dart';
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
      child: EntityStateNotifierBuilder<UsefulData>(
        listenableEntityState: wm.usefulData,
        loadingBuilder: (_, __) =>
            const Center(child: AdaptiveActivityIndicator()),
        builder: (_, usefulData) => Scaffold(
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
            slivers: [
              SliverList(
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
                            if (usefulData?.fastAdvice.isNotEmpty ?? false)
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
                                          usefulData?.fastAdvice ?? '',
                                          style: AppTextStyles()
                                              .medium_14_19
                                              .copyWith(
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: OctoImage(
                                            fit: BoxFit.cover,
                                            width: 90,
                                            height: 90,
                                            placeholderBuilder: (context) =>
                                                const SizedBox(
                                              child: Center(
                                                child:
                                                    AdaptiveActivityIndicator(),
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
                                              usefulData?.fastAdviceImageUrl ??
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
                            if (usefulData?.advice.isNotEmpty ?? false)
                              for (var advice in usefulData!.advice) ...[
                                const SizedBox(
                                  height: 16,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors().white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(241, 241, 241, 1),
                                        offset: Offset(1, 2),
                                        spreadRadius: 0.1,
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                  child: Column(
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
                                                    const BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
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
                                                  errorBuilder: (c, e, s) =>
                                                      SizedBox(
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        'assets/images/error_placeholder.svg',
                                                        colorFilter:
                                                            ColorFilter.mode(
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
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            48,
                                                    child: Text(
                                                      advice.theme.length > 150
                                                          ? '${advice.theme.substring(
                                                              0,
                                                              150,
                                                            )}...'
                                                          : advice.theme,
                                                      style: AppTextStyles()
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
                                        padding: const EdgeInsets.fromLTRB(
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
                                                color: AppColors().primaryText,
                                              ),
                                        ),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () => wm.toInfoPage(1),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: AppColors().accentGreen,
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 16,
                                              ),
                                              child: Text(
                                                'Читать далее',
                                                style: AppTextStyles()
                                                    .semibold_14_21
                                                    .copyWith(
                                                      color: AppColors().white,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
