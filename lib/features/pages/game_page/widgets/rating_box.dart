import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/icons/TennisIcons.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';

///
class RatingBox extends StatelessWidget {
  ///
  final num rating;

  ///
  final String name;

  ///
  const RatingBox({
    required this.rating,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors().primaryText,
        borderRadius: BorderRadius.circular(200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: AppTextStyles().medium_14_19.copyWith(
                    color: AppColors().white,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var i = 0; i < rating; i++) ...[
                  Icon(
                    TennisIcons.star_filled,
                    size: 22,
                    color: AppColors().outYellow,
                  ),
                ],
                for (var i = 0; i < 5 - rating; i++) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      TennisIcons.star_empty,
                      size: 18,
                      color: AppColors().outYellow,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
