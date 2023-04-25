import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';

///анимация смены прозрачности
class AnimationPart extends StatefulWidget {
  ///ширина
  final double width;

  ///высота
  final double height;

  ///высота
  final double radius;

  ///высота
  final Color? color;

  ///длительность анимации в миллисекундах - полный цикл = 2 duration
  final int duration;

  /// конструктор [AnimationPart]
  const AnimationPart({
    required this.width,
    this.height = 20,
    this.duration = 500,
    this.radius = 4,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimationPart> createState() => _AnimationPartState();
}

class _AnimationPartState extends State<AnimationPart> {
  late Timer _timer;

  double _opacity = 1.0;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        setState(() {
          if (_opacity == 1) {
            _opacity = 0.5;
          } else {
            _opacity = 1;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: widget.duration),
      opacity: _opacity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          color: widget.color ?? AppColors().secondaryText,
        ),
        height: widget.height,
        width: widget.width,
      ),
    );
  }
}
