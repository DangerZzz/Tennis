import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/assets/themes/constants/text_styles.dart';

/// Виджет, описывающий блок из которых состоит видже CodeField
class CodeBlock extends StatefulWidget {
  /// Цифра
  final String number;

  /// в фокусе ли данные поле
  final bool focus;

  /// Конструктор
  const CodeBlock({
    required this.number,
    required this.focus,
    Key? key,
  }) : super(key: key);

  @override
  _CodeBlockState createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  Timer? _timer;

  bool _timerStart = false;

  bool _state = false;

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.focus && !_timerStart) {
      _initTimer();
    } else if (!widget.focus && _timer != null) {
      _timer!.cancel();
      _timerStart = false;
    }
    return SizedBox(
      child: SizedBox(
        height: 58,
        child: Column(
          children: [
            if (widget.focus)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '|',
                  style: AppTextStyles().bold_32_37.copyWith(
                        height: 1,
                        color: _state
                            ? Colors.transparent
                            : AppColors().primaryText,
                      ),
                ),
              ),
            if (!widget.focus)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  widget.number,
                  style: AppTextStyles().bold_32_37.copyWith(
                        height: 1,
                        color: _state
                            ? Colors.transparent
                            : AppColors().primaryText,
                      ),
                ),
              ),
            Container(
              height: 3,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors().primaryText,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initTimer() {
    _timerStart = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _state = !_state;
      });
    });
  }
}
