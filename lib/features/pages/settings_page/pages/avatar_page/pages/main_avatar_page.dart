import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/components/animation_part.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/domain/avatar_images.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_wm.dart';

///
class MainAvatarPage extends StatefulWidget {
  /// wm
  final IAvatarPageWidgetModel widgetModel;

  ///
  const MainAvatarPage({required this.widgetModel, Key? key}) : super(key: key);

  @override
  State<MainAvatarPage> createState() => _MainAvatarPageState();
}

class _MainAvatarPageState extends State<MainAvatarPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            EntityStateNotifierBuilder<AvatarImages>(
              listenableEntityState: widget.widgetModel.avatarImagesData,
              loadingBuilder: (_, __) => Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: AnimationPart(
                          width: widget.widgetModel.width - 32,
                          height: 112,
                          color: AppColors().secondaryText.withOpacity(0.5),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: widget.widgetModel.width / 2 - 45 - 16,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColors().white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Center(
                            child: AnimationPart(
                              width: 80,
                              height: 80,
                              radius: 50,
                              color: AppColors().secondaryText.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: AnimationPart(
                      width: widget.widgetModel.width - 32,
                      height: 112 * 4,
                      color: AppColors().secondaryText.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
              builder: (_, avatarImagesData) => Column(
                children: [
                  Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: SizedBox(
                          width: widget.widgetModel.width - 32,
                          height: 112,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: OctoImage(
                              width: widget.widgetModel.width - 32,
                              height: 112,
                              fit: BoxFit.cover,
                              placeholderBuilder: (context) => const Center(
                                child: AdaptiveActivityIndicator(),
                              ),
                              errorBuilder: (c, e, s) => SizedBox(
                                width: widget.widgetModel.width - 32,
                                height: 112,
                                child: Image.asset(
                                  'lib/features/pages/profile_page/assets/images/profile_background.png',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              image: Image.network(
                                avatarImagesData?.backImageClippedUrl ?? '',
                              ).image,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: widget.widgetModel.width / 2 - 45 - 16,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColors().white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: 72,
                              height: 72,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: OctoImage(
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                  placeholderBuilder: (context) => const Center(
                                    child: AdaptiveActivityIndicator(),
                                  ),
                                  errorBuilder: (c, e, s) => SizedBox(
                                    child: Image.asset(
                                      'assets/images/arkasha_logo.png',
                                      fit: BoxFit.contain,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  image: Image.network(
                                    avatarImagesData?.avatarClippedUrl ?? '',
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Аватар профиля',
                            style: AppTextStyles().bold_16_21.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Аватар',
                            style: AppTextStyles().bold_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () => widget.widgetModel
                                .toChooseImage(isAvatar: true),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Загрузить',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Icon(
                                  TennisIcons.forward,
                                  size: 14,
                                  color: AppColors().secondaryText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: AppColors().secondaryText.withOpacity(0.1),
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: widget.widgetModel.editAvatar,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Редактировать',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Icon(
                                  TennisIcons.forward,
                                  size: 14,
                                  color: AppColors().secondaryText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: AppColors().secondaryText.withOpacity(0.1),
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: () {
                              widget.widgetModel.deleteImageData(
                                type: 'avatar',
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Удалить',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Icon(
                                  TennisIcons.forward,
                                  size: 14,
                                  color: AppColors().secondaryText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: AppColors().secondaryText.withOpacity(0.1),
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Обложка',
                            style: AppTextStyles().bold_14_19.copyWith(
                                  color: AppColors().primaryText,
                                ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () => widget.widgetModel
                                .toChooseImage(isAvatar: false),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Загрузить',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Icon(
                                  TennisIcons.forward,
                                  size: 14,
                                  color: AppColors().secondaryText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: AppColors().secondaryText.withOpacity(0.1),
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: widget.widgetModel.editBackground,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Редактировать',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Icon(
                                  TennisIcons.forward,
                                  size: 14,
                                  color: AppColors().secondaryText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: AppColors().secondaryText.withOpacity(0.1),
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: () {
                              widget.widgetModel.deleteImageData(
                                type: 'wallpaper',
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Удалить',
                                  style: AppTextStyles().regular_14_19.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Icon(
                                  TennisIcons.forward,
                                  size: 14,
                                  color: AppColors().secondaryText,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Divider(
                            color: AppColors().secondaryText.withOpacity(0.1),
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     DecoratedBox(
                  //       decoration: BoxDecoration(
                  //         color: AppColors().secondaryText,
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 46,
                  //           vertical: 8,
                  //         ),
                  //         child: Text(
                  //           'Отмена',
                  //           style: AppTextStyles()
                  //               .regular_14_19
                  //               .copyWith(color: AppColors().white),
                  //         ),
                  //       ),
                  //     ),
                  //     DecoratedBox(
                  //       decoration: BoxDecoration(
                  //         color: AppColors().accentGreen,
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 60,
                  //           vertical: 8,
                  //         ),
                  //         child: Text(
                  //           'Сохранить',
                  //           style: AppTextStyles()
                  //               .regular_14_19
                  //               .copyWith(color: AppColors().white),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
