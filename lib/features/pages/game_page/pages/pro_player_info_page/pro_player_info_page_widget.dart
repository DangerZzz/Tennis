import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';
import 'package:soft_weather_tennis/features/pages/game_page/domain/game_data.dart';
import 'package:soft_weather_tennis/features/pages/game_page/pages/pro_player_info_page/pro_player_info_page_wm.dart';
import 'package:soft_weather_tennis/features/pages/game_page/widgets/prof_player_card.dart';

/// Main widget for ProPlayerInfoPage module
class ProPlayerInfoPageWidget
    extends ElementaryWidget<IProPlayerInfoPageWidgetModel> {
  ///
  const ProPlayerInfoPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultProPlayerInfoPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IProPlayerInfoPageWidgetModel wm) {
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
              bottom: 32,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: wm.back,
                  child: Icon(
                    TennisIcons.back,
                    color: AppColors().primaryText,
                    size: 16,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Профи',
                  style: AppTextStyles().bold_24_32.copyWith(
                        color: AppColors().primaryText,
                      ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(wm.width, 78),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  EntityStateNotifierBuilder<bool>(
                    listenableEntityState: wm.isSearching,
                    builder: (_, isSearching) => isSearching!
                        ? DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors().primaryText,
                              borderRadius: BorderRadius.circular(200),
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
                                        controller: wm.searchController,
                                        focusNode: wm.searchFocusNode,
                                        autofocus: true,
                                        keyboardType: TextInputType.text,
                                        onChanged: (s) {
                                          if (s.length >= 3) {
                                            wm.searching();
                                          }
                                        },
                                        style: AppTextStyles()
                                            .regular_14_19
                                            .copyWith(
                                              color: AppColors().white,
                                              height: 1,
                                            ),
                                        decoration: InputDecoration(
                                          hintText: 'Поиск',
                                          hintStyle: AppTextStyles()
                                              .regular_14_19
                                              .copyWith(
                                                color:
                                                    AppColors().secondaryText,
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
                                      color: AppColors().accentGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Профессиональные игроки',
                                style: AppTextStyles().bold_16_21.copyWith(
                                      color: AppColors().primaryText,
                                    ),
                              ),
                              GestureDetector(
                                onTap: wm.onSearchTap,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors().primaryText,
                                    borderRadius: BorderRadius.circular(50),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 60.0,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      'Хочешь тренироваться как PRO? Выбери '
                      'одного из известных игроков и сделай '
                      'себе вызов!',
                      style: AppTextStyles().light_12_16.copyWith(
                            color: AppColors().secondaryText,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                EntityStateNotifierBuilder<List<ProPlayer>>(
                  listenableEntityState: wm.proPlayerInfoData,
                  loadingBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: AdaptiveActivityIndicator(),
                    ),
                  ),
                  builder: (_, proPlayerInfoData) =>
                      EntityStateNotifierBuilder<bool>(
                    listenableEntityState: wm.isSearching,
                    builder: (_, isSearching) => (isSearching ?? false)
                        ? EntityStateNotifierBuilder<List<ProPlayer>>(
                            listenableEntityState: wm.searchedList,
                            loadingBuilder: (_, __) => const Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: Center(
                                child: AdaptiveActivityIndicator(),
                              ),
                            ),
                            builder: (_, searchedList) => (wm
                                            .searchController.text.length >
                                        2 &&
                                    (isSearching!))
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var searchedData
                                          in searchedList ?? <ProPlayer>[])
                                        PlayerCard(
                                          rating: searchedData.rating,
                                          description: searchedData.title,
                                          name: searchedData.name,
                                          imageUrl: searchedData.imageUrl,
                                          call: () => wm.onInfo(searchedData),
                                        ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      for (var player
                                          in wm.proPlayerInfoData.value?.data ??
                                              <ProPlayer>[]) ...[
                                        PlayerCard(
                                          rating: player.rating,
                                          description: player.title,
                                          name: player.name,
                                          imageUrl: player.imageUrl,
                                          call: () => wm.onInfo(player),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ],
                                  ),
                          )
                        : Column(
                            children: [
                              for (var player
                                  in proPlayerInfoData ?? <ProPlayer>[]) ...[
                                PlayerCard(
                                  rating: player.rating,
                                  description: player.title,
                                  name: player.name,
                                  imageUrl: player.imageUrl,
                                  call: () => wm.onInfo(player),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ],
                          ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
