import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:soft_weather_tennis/assets/themes/constants/colors.dart';
import 'package:soft_weather_tennis/components/adaptive_activity_indicator.dart';

/// Расширяет возможности [CustomScrollView]. Добавляет возможность
/// swipeToRefresh, если передан [onRefresh]. Можно задать позицию
/// refreshIndicator через [refreshIndicatorIndex]
class AdaptiveRefreshCustomScrollView extends StatefulWidget {
  /// Коллбэк, срабатывает на swipeToRefresh
  final RefreshCallback? onRefresh;

  /// Key для [CustomScrollView]
  final Key? scrollKey;

  /// Inherited from [CustomScrollView]
  final Axis scrollDirection;

  /// Inherited from [CustomScrollView]
  final bool reverse;

  /// Inherited from [CustomScrollView]
  final ScrollController? controller;

  /// Inherited from [CustomScrollView]
  final bool? primary;

  /// Inherited from [CustomScrollView]
  final ScrollPhysics? physics;

  /// Inherited from [CustomScrollView]
  final bool shrinkWrap;

  /// Inherited from [CustomScrollView]
  final Key? center;

  /// Inherited from [CustomScrollView]
  final double anchor;

  /// Inherited from [CustomScrollView]
  final double? cacheExtent;

  /// Inherited from [CustomScrollView]
  final List<Widget> slivers;

  /// Inherited from [CustomScrollView]
  final int? semanticChildCount;

  /// Inherited from [CustomScrollView]
  final DragStartBehavior dragStartBehavior;

  /// Inherited from [CustomScrollView]
  final String? restorationId;

  /// Inherited from [CustomScrollView]
  final Clip clipBehavior;

  /// Индекс позиции для индикатора обновления
  final int refreshIndicatorIndex;

  /// Виджет который появляется при скролле вверх
  final Widget? toTopWidget;

  /// Изначальная позиция [toTopWidget]. По умолчанию -100.
  /// Виджет скрывается за границами экрана, поэтому это значение
  /// должно быть больше высоты виджета
  final double toTopInitialOffset;

  /// Позиция скролла после которой будет срабатывать отображение [toTopWidget].
  /// По умолчанию 100
  final double toTopShowingOffset;

  final Function(ScrollNotification)? notificationListener;

  /// Конструктор
  const AdaptiveRefreshCustomScrollView({
    Key? key,
    this.onRefresh,
    this.refreshIndicatorIndex = 0,
    this.scrollKey,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.center,
    this.anchor = 0.0,
    this.cacheExtent,
    this.slivers = const <Widget>[],
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.toTopWidget,
    this.toTopInitialOffset = -100,
    this.toTopShowingOffset = 100,
    this.notificationListener,
  }) : super(key: key);

  @override
  State<AdaptiveRefreshCustomScrollView> createState() =>
      _AdaptiveRefreshCustomScrollViewState();
}

class _AdaptiveRefreshCustomScrollViewState
    extends State<AdaptiveRefreshCustomScrollView> {
  late double _top;

  @override
  void initState() {
    super.initState();
    _top = widget.toTopInitialOffset;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRefresh != null) {
      widget.slivers.insert(
        widget.refreshIndicatorIndex,
        CupertinoSliverRefreshControl(
          onRefresh: widget.onRefresh,
          builder: (
            context,
            refreshState,
            pulledExtent,
            refreshTriggerPullDistance,
            refreshIndicatorExtent,
          ) {
            return ColoredBox(
              color: AppColors().white,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      top: 16.0,
                      left: 0.0,
                      right: 0.0,
                      child: Transform.scale(
                        scale: min(pulledExtent / refreshIndicatorExtent, 1),
                        child: const AdaptiveActivityIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    final scrollView = NotificationListener<ScrollNotification>(
      onNotification: _scrollListener,
      child: CustomScrollView(
        slivers: widget.slivers,
        key: widget.scrollKey,
        shrinkWrap: widget.shrinkWrap,
        controller: widget.controller,
        reverse: widget.reverse,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        anchor: widget.anchor,
        cacheExtent: widget.cacheExtent,
        center: widget.center,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        primary: widget.primary,
        restorationId: widget.restorationId,
        scrollDirection: widget.scrollDirection,
        semanticChildCount: widget.semanticChildCount,
      ),
    );
    if (widget.toTopWidget != null) {
      final view = Stack(
        children: [
          Positioned.fill(
            child: scrollView,
          ),
          AnimatedPositioned(
            top: _top,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 500),
            child: Center(
              child: widget.toTopWidget,
            ),
          ),
        ],
      );
      return view;
    }
    return scrollView;
  }

  bool _scrollListener(ScrollNotification notification) {
    widget.notificationListener?.call(notification);
    if (notification.metrics.pixels < widget.toTopShowingOffset) {
      _hideToTopWidget();
      return false;
    }
    if (notification is ScrollUpdateNotification) {
      if ((notification.scrollDelta ?? 0) < -5) {
        _showToTopWidget();
      } else if ((notification.scrollDelta ?? 0) > 0) {
        _hideToTopWidget();
      }
    }
    return false;
  }

  void _showToTopWidget() {
    if (_top != 0) {
      setState(() {
        _top = 0;
      });
    }
  }

  void _hideToTopWidget() {
    if (_top != widget.toTopInitialOffset) {
      setState(() {
        _top = widget.toTopInitialOffset;
      });
    }
  }
}
