import 'package:flutter/material.dart';

///Кастомный виджет для наслоения страниц
class FadeIndexedStack extends StatefulWidget {
  ///Индекс страницы
  final int index;

  ///Виджет страницы
  final List<Widget> children;

  ///Задержка
  final Duration duration;

  ///Положение
  final AlignmentGeometry alignment;

  ///Конструктор [FadeIndexedStack]
  const FadeIndexedStack({
    required this.index,
    required this.children,
    Key? key,
    this.duration = const Duration(
      milliseconds: 500,
    ),
    this.alignment = AlignmentDirectional.topStart,
  }) : super(key: key);

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller?.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller?.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller!,
      child: IndexedStack(
        alignment: widget.alignment,
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}
