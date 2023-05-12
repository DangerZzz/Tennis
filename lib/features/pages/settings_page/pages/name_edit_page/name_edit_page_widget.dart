import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/name_edit_page/name_edit_page_wm.dart';

/// Main widget for NameEditPage module
class NameEditPageWidget extends ElementaryWidget<INameEditPageWidgetModel> {
  ///
  const NameEditPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultNameEditPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(INameEditPageWidgetModel wm) {
    return Scaffold(
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
            size: 12,
          ),
        ),
        title: Text(
          'Настройки',
          style: AppTextStyles().bold_24_32.copyWith(
                color: AppColors().primaryText,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Имя и фамилия',
                      style: AppTextStyles().bold_16_21.copyWith(
                            color: AppColors().primaryText,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: wm.nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: wm.userInfo.name,
                        hintStyle: AppTextStyles().light_14_19.copyWith(
                              color: AppColors().secondaryText,
                            ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors().secondaryText.withOpacity(0.1),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors().secondaryText.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: wm.surnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: wm.userInfo.surname,
                        hintStyle: AppTextStyles().light_14_19.copyWith(
                              color: AppColors().secondaryText,
                            ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors().secondaryText,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 46, vertical: 8),
                    child: Text(
                      'Отмена',
                      style: AppTextStyles()
                          .regular_14_19
                          .copyWith(color: AppColors().white),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors().accentGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    child: Text(
                      'Изменить',
                      style: AppTextStyles()
                          .regular_14_19
                          .copyWith(color: AppColors().white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
