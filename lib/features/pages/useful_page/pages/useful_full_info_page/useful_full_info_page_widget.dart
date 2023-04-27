import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_info.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/pages/useful_full_info_page/useful_full_info_page_wm.dart';

/// Main widget for UsefulFullInfoPage module
class UsefulFullInfoPageWidget
    extends ElementaryWidget<IUsefulFullInfoPageWidgetModel> {
  ///
  const UsefulFullInfoPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultUsefulFullInfoPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IUsefulFullInfoPageWidgetModel wm) {
    return SafeArea(
      child: EntityStateNotifierBuilder<UsefulInfoData>(
        listenableEntityState: wm.usefulDataByIndex,
        loadingBuilder: (_, __) =>
            const Center(child: AdaptiveActivityIndicator()),
        builder: (_, usefulDataByIndex) => Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: OctoImage(
                height: 288,
                width: wm.width,
                fit: BoxFit.cover,
                placeholderBuilder: (context) => const Center(
                  child: AdaptiveActivityIndicator(
                    radius: 40,
                  ),
                ),
                errorBuilder: (c, e, s) => Center(
                  child: SvgPicture.asset(
                    'assets/images/error_placeholder.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors().accentGreen,
                      BlendMode.srcIn,
                    ),
                    height: 60,
                    width: 60,
                  ),
                ),
                image: Image.network(
                  usefulDataByIndex?.imageUrl ?? '',
                  fit: BoxFit.fitWidth,
                ).image,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: GestureDetector(
                onTap: wm.onBack,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColors().primaryText,
                    borderRadius: BorderRadius.circular(40),
                  ),
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
            Positioned(
              top: 254,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(34),
                    topLeft: Radius.circular(34),
                  ),
                  color: AppColors().white,
                ),
                width: wm.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24,
                  ),
                  child: SizedBox(
                    height: wm.height - 314,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            usefulDataByIndex?.theme ?? '',
                            style: AppTextStyles().bold_20_27.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            usefulDataByIndex?.text ?? '',
                            style: AppTextStyles().regular_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Divider(
                            color: AppColors().secondaryText.withOpacity(0.1),
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          if (usefulDataByIndex?.advices.isNotEmpty ??
                              false) ...[
                            Text(
                              'Смотри так-же',
                              style: AppTextStyles().bold_20_27.copyWith(
                                    color: AppColors().primaryText,
                                  ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            for (var advice in usefulDataByIndex!.advices) ...[
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
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              advice.theme,
                                              style: AppTextStyles()
                                                  .bold_16_21
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              advice.text,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles()
                                                  .regular_14_19
                                                  .copyWith(
                                                    color:
                                                        AppColors().primaryText,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      OctoImage(
                                        width: 105,
                                        height: 82,
                                        fit: BoxFit.cover,
                                        placeholderBuilder: (context) =>
                                            const Center(
                                          child: AdaptiveActivityIndicator(),
                                        ),
                                        errorBuilder: (c, e, s) => Center(
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
                                        image: Image.network(
                                          advice.imageUrl,
                                        ).image,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
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
