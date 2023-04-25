import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/domain/achievement.dart';
import 'package:soft_weather_tennis/features/pages/profile_page/widgets/achievements_dialog.dart';

/// Вкладка игра
class AchievementsPage extends StatefulWidget {
  ///
  const AchievementsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  bool? showGetting;
  bool? showNotGetting;

  @override
  void initState() {
    super.initState();
    showGetting = true;
    showNotGetting = true;
  }

  @override
  Widget build(BuildContext context) {
    final achievementsAll =
        ModalRoute.of(context)?.settings.arguments as List<Achievement>;

    final gettingAchievements = <Achievement>[
      ...achievementsAll.where((element) => element.isGetting == true),
    ];

    final notGettingAchievements = <Achievement>[
      ...achievementsAll.where((element) => element.isGetting == false),
    ];

    return Scaffold(
      backgroundColor: AppColors().white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors().white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () =>
              Navigator.pop(context), // TODO(daniil): coordinator.pop();
          child: Icon(
            TennisIcons.back,
            color: AppColors().primaryText,
            size: 12,
          ),
        ),
        title: Text(
          'Достижения',
          style: AppTextStyles().bold_24_32.copyWith(
                color: AppColors().primaryText,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropDown(
              items: const ['Все достижения', 'Полученные', 'Еще не открыты'],
              showUnderline: false,
              hint: Text(
                'Все достижения',
                style: AppTextStyles().bold_16_21,
              ),
              icon: Icon(
                Icons.expand_more,
                color: AppColors().secondaryText,
              ),
              onChanged: (state) {
                setState(
                  () {
                    if (state == 'Все достижения') {
                      showGetting = true;
                      showNotGetting = true;
                    }
                    if (state == 'Полученные') {
                      showGetting = true;
                      showNotGetting = false;
                    }
                    if (state == 'Еще не открыты') {
                      showGetting = false;
                      showNotGetting = true;
                    }
                  },
                );
              },
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  if (achievementsAll
                          .where((element) => element.isGetting == true)
                          .isNotEmpty &&
                      showGetting!)
                    for (int i = 0;
                        i <
                            achievementsAll
                                .where((element) => element.isGetting == true)
                                .length;
                        i++)
                      GestureDetector(
                        onTap: () {
                          showDialog<void>(
                            barrierDismissible: false,
                            builder: (context) {
                              return AchievementsDialog(
                                width: MediaQuery.of(context).size.width,
                                back: () => Navigator.maybePop(context),
                                isInfo: true,
                                achievements: [
                                  gettingAchievements[i],
                                ],
                              );
                            },
                            context: context,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    gettingAchievements[i].url,
                                    fit: BoxFit.contain,
                                  ),
                                  // OctoImage(
                                  //   fit: BoxFit.contain,
                                  //   placeholderBuilder: (context) => const Icon(
                                  //     Icons.refresh,
                                  //   ),
                                  //   errorBuilder: (c, e, s) => const Icon(
                                  //     Icons.error,
                                  //   ),
                                  //   image: Image.network(
                                  //     'https://picsum.photos/200',
                                  //     fit: BoxFit.contain,
                                  //   ).image,
                                  // ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  gettingAchievements[i].name,
                                  style: AppTextStyles().bold_16_21.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Text(
                                  gettingAchievements[i].date ?? '',
                                  style: AppTextStyles().regular_12_16.copyWith(
                                        color: AppColors().secondaryText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  if (achievementsAll
                          .where((element) => element.isGetting == false)
                          .isNotEmpty &&
                      showNotGetting!)
                    for (int i = 0;
                        i <
                            achievementsAll
                                .where((element) => element.isGetting == false)
                                .length;
                        i++)
                      GestureDetector(
                        onTap: () {
                          showDialog<void>(
                            barrierDismissible: false,
                            builder: (context) {
                              return AchievementsDialog(
                                width: MediaQuery.of(context).size.width,
                                back: () => Navigator.maybePop(context),
                                isInfo: true,
                                achievements: [
                                  notGettingAchievements[i],
                                ],
                              );
                            },
                            context: context,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    notGettingAchievements[i].url,
                                    fit: BoxFit.contain,
                                  ),
                                  // OctoImage(
                                  //   fit: BoxFit.contain,
                                  //   placeholderBuilder: (context) => const Icon(
                                  //     Icons.refresh,
                                  //   ),
                                  //   errorBuilder: (c, e, s) => const Icon(
                                  //     Icons.error,
                                  //   ),
                                  //   image: Image.network(
                                  //     'https://picsum.photos/200',
                                  //     fit: BoxFit.contain,
                                  //   ).image,
                                  // ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  notGettingAchievements[i].name,
                                  style: AppTextStyles().bold_16_21.copyWith(
                                        color: AppColors().primaryText,
                                      ),
                                ),
                                Text(
                                  notGettingAchievements[i].date ?? '',
                                  style: AppTextStyles().regular_12_16.copyWith(
                                        color: AppColors().secondaryText,
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
          ],
        ),
      ),
    );
  }
}
