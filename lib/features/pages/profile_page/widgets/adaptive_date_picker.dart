import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';

///
Future<DateTime?> showAdaptiveDatePicker(
  BuildContext context, {
  required DateTime minimumDate,
  required DateTime maximumDate,
  required DateTime fromDate,
  required String title,
}) async {
  final picked = (kIsWeb || Platform.isIOS)
      ? await showCupertinoModalPopup<DateTime>(
          context: context,
          builder: (context) {
            return _CupertinoDatePicker(
              fromDate: fromDate,
              title: title,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
            );
          },
        )
      : await showDatePicker(
          context: context,
          initialDate: fromDate,
          firstDate: minimumDate,
          lastDate: maximumDate,
          helpText: title,
        );
  return picked;
}

class _CupertinoDatePicker extends StatefulWidget {
  final DateTime fromDate;
  final String title;
  final DateTime minimumDate;
  final DateTime maximumDate;

  const _CupertinoDatePicker({
    required this.fromDate,
    required this.title,
    required this.minimumDate,
    required this.maximumDate,
    Key? key,
  }) : super(key: key);

  @override
  _CupertinoDatePickerState createState() => _CupertinoDatePickerState();
}

class _CupertinoDatePickerState extends State<_CupertinoDatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.fromDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          padding: const EdgeInsets.all(16),
          // height: 70,
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: <Widget>[
              Expanded(
                child: Material(
                  color: AppColors().white,
                  child: Text(
                    widget.title,
                    style: AppTextStyles().bold_18_24.copyWith(
                          color: AppColors().primaryText,
                        ),
                  ),
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                onPressed: () {
                  Navigator.pop(context,
                      _selectedDate); // TODO(daniil): coordinator.pop();
                },
                child: Text(
                  'Выбрать',
                  style: AppTextStyles().bold_16_21.copyWith(
                        color: AppColors().secondaryText,
                      ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: DefaultTextStyle(
            style: TextStyle(
              color: CupertinoColors.label.resolveFrom(context),
              fontSize: 22,
            ),
            child: GestureDetector(
              onTap: () {},
              child: SafeArea(
                top: false,
                child: CupertinoDatePicker(
                  backgroundColor:
                      CupertinoColors.systemBackground.resolveFrom(context),
                  minimumDate: widget.minimumDate,
                  maximumDate: widget.maximumDate,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: widget.fromDate,
                  onDateTimeChanged: (picked) {
                    _selectedDate = picked;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
