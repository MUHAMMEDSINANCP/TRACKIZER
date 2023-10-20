// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:math' as Math;

import 'package:flutter/material.dart';

import '../card_swiper.dart';
import 'transformer_page_view/transformer_page_view.dart';

part 'custom_layout.dart';

typedef SwiperOnTap = void Function(int index);

typedef SwiperDataBuilder<T> = Widget Function(
  BuildContext context,
  T data,
  int index,
);

/// default auto play delay
const int kDefaultAutoplayDelayMs = 3000;

///  Default auto play transition duration (in millisecond)
const int kDefaultAutoplayTransactionDuration = 300;

const int kMaxValue = 2000000000;
const int kMiddleValue = 1000000000;

enum SwiperLayout {
  DEFAULT,
  STACK,
  TINDER,
  CUSTOM,
}

class Swiper extends StatefulWidget {
  const Swiper({
    this.itemBuilder,
    this.indicatorLayout = PageIndicatorLayout.NONE,

    ///
    this.transformer,
    required this.itemCount,
    this.autoplay = false,
    this.layout = SwiperLayout.DEFAULT,
    this.autoplayDelay = kDefaultAutoplayDelayMs,
    this.autoplayDisableOnInteraction = true,
    this.duration = kDefaultAutoplayTransactionDuration,
    this.onIndexChanged,
    this.index,
    this.onTap,
    this.control,
    this.loop = true,
    this.curve = Curves.ease,
    this.scrollDirection = Axis.horizontal,
    this.axisDirection = AxisDirection.left,
    this.pagination,
    this.plugins,
    this.physics,
    Key? key,
    this.controller,
    this.customLayoutOption,

    /// since v1.0.0
    this.containerHeight,
    this.containerWidth,
    this.viewportFraction = 1.0,
    this.itemHeight,
    this.itemWidth,
    this.outer = false,
    this.scale,
    this.fade,
    this.allowImplicitScrolling = false,
  })  : assert(
          itemBuilder != null || transformer != null,
          'itemBuilder and transformItemBuilder must not be both null',
        ),
        assert(
            !loop ||
                ((loop &&
                        layout == SwiperLayout.DEFAULT &&
                        (indicatorLayout == PageIndicatorLayout.SCALE ||
                            indicatorLayout == PageIndicatorLayout.COLOR ||
                            indicatorLayout == PageIndicatorLayout.NONE)) ||
                    (loop && layout != SwiperLayout.DEFAULT)),
            'Only support `PageIndicatorLayout.SCALE` and `PageIndicatorLayout.COLOR`when layout==SwiperLayout.DEFAULT in loop mode'),
        super(key: key);

  factory Swiper.children({
    required List<Widget> children,
    bool autoplay = false,
    PageTransformer? transformer,
    int autoplayDelay = kDefaultAutoplayDelayMs,
    bool autoplayDisableOnInteraction = true,
    int duration = kDefaultAutoplayTransactionDuration,
    ValueChanged<int>? onIndexChanged,
    int? index,
    SwiperOnTap? onTap,
    bool loop = true,
    Curve curve = Curves.ease,
    Axis scrollDirection = Axis.horizontal,
    AxisDirection axisDirection = AxisDirection.left,
    SwiperPlugin? pagination,
    SwiperPlugin? control,
    List<SwiperPlugin>? plugins,
    SwiperController? controller,
    Key? key,
    CustomLayoutOption? customLayoutOption,
    ScrollPhysics? physics,
    double? containerHeight,
    double? containerWidth,
    double viewportFraction = 1.0,
    double? itemHeight,
    double? itemWidth,
    bool outer = false,
    double scale = 1.0,
    double? fade,
    PageIndicatorLayout indicatorLayout = PageIndicatorLayout.NONE,
    SwiperLayout layout = SwiperLayout.DEFAULT,
  }) =>
      Swiper(
        fade: fade,
        indicatorLayout: indicatorLayout,
        layout: layout,
        transformer: transformer,
        customLayoutOption: customLayoutOption,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        scrollDirection: scrollDirection,
        axisDirection: axisDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        key: key,
        itemBuilder: (context, index) {
          return children[index];
        },
        itemCount: children.length,
      );

  /// If set true , the pagination will display 'outer' of the 'content' container.
  final bool outer;

  /// Inner item height, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  final double? itemHeight;

  /// Inner item width, this property is valid if layout=STACK or layout=TINDER or LAYOUT=CUSTOM,
  final double? itemWidth;

  // height of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double? containerHeight;

  // width of the inside container,this property is valid when outer=true,otherwise the inside container size is controlled by parent widget
  final double? containerWidth;

  /// Build item on index
  final IndexedWidgetBuilder? itemBuilder;

  /// Support transform like Android PageView did
  /// `itemBuilder` and `transformItemBuilder` must have one not null
  final PageTransformer? transformer;

  /// count of the display items
  final int itemCount;

  final ValueChanged<int>? onIndexChanged;

  ///auto play config
  final bool autoplay;

  ///Duration of the animation between transactions (in millisecond).
  final int autoplayDelay;

  ///disable auto play when interaction
  final bool autoplayDisableOnInteraction;

  ///auto play transition duration (in millisecond)
  final int duration;

  ///horizontal/vertical
  final Axis scrollDirection;

  ///left/right for Stack Layout
  final AxisDirection axisDirection;

  ///transition curve
  final Curve curve;

  /// Set to false to disable continuous loop mode.
  final bool loop;

  ///Index number of initial slide.
  ///If not set , the `Swiper` is 'uncontrolled', which means manage index by itself
  ///If set , the `Swiper` is 'controlled', which means the index is fully managed by parent widget.
  final int? index;

  ///Called when tap
  final SwiperOnTap? onTap;

  ///The swiper pagination plugin
  final SwiperPlugin? pagination;

  ///the swiper control button plugin
  final SwiperPlugin? control;

  ///other plugins, you can custom your own plugin
  final List<SwiperPlugin>? plugins;

  ///
  final SwiperController? controller;

  final ScrollPhysics? physics;

  ///
  final double viewportFraction;

  /// Build in layouts
  final SwiperLayout layout;

  /// this value is valid when layout == SwiperLayout.CUSTOM
  final CustomLayoutOption? customLayoutOption;

  // This value is valid when viewportFraction is set and < 1.0
  final double? scale;

  // This value is valid when viewportFraction is set and < 1.0
  final double? fade;

  final PageIndicatorLayout indicatorLayout;

  final bool allowImplicitScrolling;

  static Swiper list<T>({
    PageTransformer? transformer,
    required List<T> list,
    CustomLayoutOption? customLayoutOption,
    required SwiperDataBuilder<T> builder,
    bool autoplay = false,
    int autoplayDelay = kDefaultAutoplayDelayMs,
    bool reverse = false,
    bool autoplayDisableOnInteraction = true,
    int duration = kDefaultAutoplayTransactionDuration,
    ValueChanged<int>? onIndexChanged,
    int? index,
    SwiperOnTap? onTap,
    bool loop = true,
    Curve curve = Curves.ease,
    Axis scrollDirection = Axis.horizontal,
    AxisDirection axisDirection = AxisDirection.left,
    SwiperPlugin? pagination,
    SwiperPlugin? control,
    List<SwiperPlugin>? plugins,
    SwiperController? controller,
    Key? key,
    ScrollPhysics? physics,
    double? containerHeight,
    double? containerWidth,
    double viewportFraction = 1.0,
    double? itemHeight,
    double? itemWidth,
    bool outer = false,
    double scale = 1.0,
    double? fade,
    PageIndicatorLayout indicatorLayout = PageIndicatorLayout.NONE,
    SwiperLayout layout = SwiperLayout.DEFAULT,
  }) =>
      Swiper(
        fade: fade,
        indicatorLayout: indicatorLayout,
        layout: layout,
        transformer: transformer,
        customLayoutOption: customLayoutOption,
        containerHeight: containerHeight,
        containerWidth: containerWidth,
        viewportFraction: viewportFraction,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        outer: outer,
        scale: scale,
        autoplay: autoplay,
        autoplayDelay: autoplayDelay,
        autoplayDisableOnInteraction: autoplayDisableOnInteraction,
        duration: duration,
        onIndexChanged: onIndexChanged,
        index: index,
        onTap: onTap,
        curve: curve,
        key: key,
        scrollDirection: scrollDirection,
        axisDirection: axisDirection,
        pagination: pagination,
        control: control,
        controller: controller,
        loop: loop,
        plugins: plugins,
        physics: physics,
        itemBuilder: (context, index) {
          return builder(context, list[index], index);
        },
        itemCount: list.length,
      );

  @override
  State<StatefulWidget> createState() => _SwiperState();
}

abstract class _SwiperTimerMixin extends State<Swiper> {
  Timer? _timer;
  late SwiperController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SwiperController();
    _controller.addListener(_onController);
    if (widget.autoplay) {
      _controller.startAutoplay();
    } else {
      _controller.stopAutoplay();
    }
  }

  void _onController() {
    final event = _controller.event;
    if (event is AutoPlaySwiperControllerEvent) {
      if (event.autoplay) {
        if (_timer == null) {
          _startAutoplay();
        }
      } else {
        _stopAutoplay();
      }
    }
  }

  @override
  void didUpdateWidget(Swiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller != oldWidget.controller) {
      final oldController = oldWidget.controller;
      if (oldController != null) {
        oldController.removeListener(_onController);
        _controller = oldController;
        _controller.addListener(_onController);
      }
    }
    if (widget.autoplay != oldWidget.autoplay) {
      if (widget.autoplay) {
        _controller.startAutoplay();
      } else {
        _controller.stopAutoplay();
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onController);
    _stopAutoplay();
    super.dispose();
  }

  void _startAutoplay() {
    _stopAutoplay();
    _timer = Timer.periodic(
      Duration(
        milliseconds: widget.autoplayDelay,
      ),
      _onTimer,
    );
  }

  Future<void> _onTimer(Timer timer) async {
    return _controller.next(animation: true);
  }

  void _stopAutoplay() {
    _timer?.cancel();
    _timer = null;
  }
}

class _SwiperState extends _SwiperTimerMixin {
  late int _activeIndex;

  TransformerPageController? _pageController;

  Widget _wrapTap(BuildContext context, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onTap!(index),
      child: widget.itemBuilder!(context, index),
    );
  }

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.index ?? widget.controller?.index ?? 0;
    if (_isPageViewLayout()) {
      _pageController = TransformerPageController(
        initialPage: widget.index ?? widget.controller?.index ?? 0,
        loop: widget.loop,
        itemCount: widget.itemCount,
        reverse: widget.transformer?.reverse ?? false,
        viewportFraction: widget.viewportFraction,
      );
    }
  }

  bool _isPageViewLayout() {
    return widget.layout == SwiperLayout.DEFAULT;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _getReverse(Swiper widget) => widget.transformer?.reverse ?? false;

  @override
  void didUpdateWidget(Swiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isPageViewLayout()) {
      if (_pageController == null ||
          (widget.index != oldWidget.index ||
              widget.loop != oldWidget.loop ||
              widget.itemCount != oldWidget.itemCount ||
              widget.viewportFraction != oldWidget.viewportFraction ||
              _getReverse(widget) != _getReverse(oldWidget))) {
        _pageController = TransformerPageController(
          initialPage: widget.index ?? widget.controller?.index ?? 0,
          loop: widget.loop,
          itemCount: widget.itemCount,
          reverse: _getReverse(widget),
          viewportFraction: widget.viewportFraction,
        );
      }
    } else {
      scheduleMicrotask(() {
        // So that we have a chance to do `removeListener` in child widgets.
        if (_pageController != null) {
          _pageController!.dispose();
          _pageController = null;
        }
      });
    }
    if (widget.index != null && widget.index != _activeIndex) {
      _activeIndex = widget.index!;
    }
  }

  void _onIndexChanged(int index) {
    setState(() {
      _activeIndex = index;
    });
    widget.onIndexChanged?.call(index);
  }

  Widget _buildSwiper() {
    IndexedWidgetBuilder? itemBuilder;
    if (widget.onTap != null) {
      itemBuilder = _wrapTap;
    } else {
      itemBuilder = widget.itemBuilder;
    }

    if (widget.layout == SwiperLayout.STACK) {
      return _StackSwiper(
        loop: widget.loop,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
        axisDirection: widget.axisDirection,
      );
    } else if (_isPageViewLayout()) {
      //default
      var transformer = widget.transformer;
      if (widget.scale != null || widget.fade != null) {
        transformer =
            ScaleAndFadeTransformer(scale: widget.scale, fade: widget.fade);
      }

      final child = TransformerPageView(
        pageController: _pageController,
        loop: widget.loop,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        transformer: transformer,
        viewportFraction: widget.viewportFraction,
        index: _activeIndex,
        duration: Duration(milliseconds: widget.duration),
        scrollDirection: widget.scrollDirection,
        onPageChanged: _onIndexChanged,
        curve: widget.curve,
        physics: widget.physics,
        controller: _controller,
        allowImplicitScrolling: widget.allowImplicitScrolling,
      );
      if (widget.autoplayDisableOnInteraction && widget.autoplay) {
        return NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              if (notification.dragDetails != null) {
                //by human
                if (_timer != null) _stopAutoplay();
              }
            } else if (notification is ScrollEndNotification) {
              if (_timer == null) _startAutoplay();
            }

            return false;
          },
          child: child,
        );
      }

      return child;
    } else if (widget.layout == SwiperLayout.TINDER) {
      return _TinderSwiper(
        loop: widget.loop,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else if (widget.layout == SwiperLayout.CUSTOM) {
      return _CustomLayoutSwiper(
        loop: widget.loop,
        option: widget.customLayoutOption!,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        itemCount: widget.itemCount,
        itemBuilder: itemBuilder,
        index: _activeIndex,
        curve: widget.curve,
        duration: widget.duration,
        onIndexChanged: _onIndexChanged,
        controller: _controller,
        scrollDirection: widget.scrollDirection,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  SwiperPluginConfig _ensureConfig(SwiperPluginConfig? config) {
    final con = config ??
        SwiperPluginConfig(
          outer: widget.outer,
          itemCount: widget.itemCount,
          layout: widget.layout,
          indicatorLayout: widget.indicatorLayout,
          pageController: _pageController,
          activeIndex: _activeIndex,
          scrollDirection: widget.scrollDirection,
          axisDirection: widget.axisDirection,
          controller: _controller,
          loop: widget.loop,
        );

    return con;
  }

  List<Widget>? _ensureListForStack({
    required Widget swiper,
    required List<Widget>? listForStack,
    required Widget widget,
  }) {
    final resList = <Widget>[];
    if (listForStack == null) {
      resList.addAll([swiper, widget]);
    } else {
      resList.addAll([...listForStack, widget]);
    }
    return resList;
  }

  @override
  Widget build(BuildContext context) {
    final swiper = _buildSwiper();
    List<Widget>? listForStack;
    SwiperPluginConfig? config;
    if (widget.control != null) {
      //Stack
      config = _ensureConfig(config);
      listForStack = _ensureListForStack(
        swiper: swiper,
        listForStack: listForStack,
        widget: widget.control!.build(context, config),
      );
    }

    if (widget.plugins != null) {
      config = _ensureConfig(config);
      for (final plugin in widget.plugins!) {
        listForStack = _ensureListForStack(
          swiper: swiper,
          listForStack: listForStack,
          widget: plugin.build(context, config),
        );
      }
    }
    if (widget.pagination != null) {
      config = _ensureConfig(config);
      if (widget.outer) {
        return _buildOuterPagination(
            widget.pagination! as SwiperPagination,
            listForStack == null ? swiper : Stack(children: listForStack),
            config);
      } else {
        listForStack = _ensureListForStack(
          swiper: swiper,
          listForStack: listForStack,
          widget: widget.pagination!.build(context, config),
        );
      }
    }

    if (listForStack != null) {
      return Stack(
        children: listForStack,
      );
    }

    return swiper;
  }

  Widget _buildOuterPagination(
    SwiperPagination pagination,
    Widget swiper,
    SwiperPluginConfig config,
  ) {
    final list = <Widget>[];
    //Only support bottom yet!
    if (widget.containerHeight != null || widget.containerWidth != null) {
      list.add(swiper);
    } else {
      list.add(Expanded(child: swiper));
    }

    list.add(Align(
      alignment: Alignment.center,
      child: pagination.build(context, config),
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}

abstract class _SubSwiper extends StatefulWidget {
  const _SubSwiper({
    Key? key,
    required this.loop,
    this.itemHeight,
    this.itemWidth,
    this.duration,
    required this.curve,
    this.itemBuilder,
    required this.controller,
    this.index,
    required this.itemCount,
    this.scrollDirection = Axis.horizontal,
    this.axisDirection = AxisDirection.left,
    this.onIndexChanged,
  }) : super(key: key);

  final IndexedWidgetBuilder? itemBuilder;
  final int itemCount;
  final int? index;
  final ValueChanged<int>? onIndexChanged;
  final SwiperController controller;
  final int? duration;
  final Curve curve;
  final double? itemWidth;
  final double? itemHeight;
  final bool loop;
  final Axis? scrollDirection;
  final AxisDirection? axisDirection;

  @override
  State<StatefulWidget> createState();

  int getCorrectIndex(int indexNeedsFix) {
    if (itemCount == 0) return 0;
    var value = indexNeedsFix % itemCount;
    if (value < 0) {
      value += itemCount;
    }
    return value;
  }
}

class _TinderSwiper extends _SubSwiper {
  const _TinderSwiper({
    Key? key,
    required Curve curve,
    int? duration,
    required SwiperController controller,
    ValueChanged<int>? onIndexChanged,
    double? itemHeight,
    double? itemWidth,
    IndexedWidgetBuilder? itemBuilder,
    int? index,
    required bool loop,
    required int itemCount,
    Axis? scrollDirection,
  })  : assert(itemWidth != null && itemHeight != null),
        super(
            loop: loop,
            key: key,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            itemBuilder: itemBuilder,
            curve: curve,
            duration: duration,
            controller: controller,
            index: index,
            onIndexChanged: onIndexChanged,
            itemCount: itemCount,
            scrollDirection: scrollDirection);

  @override
  State<StatefulWidget> createState() {
    return _TinderState();
  }
}

class _StackSwiper extends _SubSwiper {
  const _StackSwiper({
    Key? key,
    required Curve curve,
    int? duration,
    required SwiperController controller,
    ValueChanged<int>? onIndexChanged,
    double? itemHeight,
    double? itemWidth,
    IndexedWidgetBuilder? itemBuilder,
    int? index,
    required bool loop,
    required int itemCount,
    Axis? scrollDirection,
    AxisDirection? axisDirection,
  }) : super(
          loop: loop,
          key: key,
          itemWidth: itemWidth,
          itemHeight: itemHeight,
          itemBuilder: itemBuilder,
          curve: curve,
          duration: duration,
          controller: controller,
          index: index,
          onIndexChanged: onIndexChanged,
          itemCount: itemCount,
          scrollDirection: scrollDirection,
          axisDirection: axisDirection,
        );

  @override
  State<StatefulWidget> createState() => _StackViewState();
}

class _TinderState extends _CustomLayoutStateBase<_TinderSwiper> {
  late List<double> scales;
  late List<double> offsetsX;
  late List<double> offsetsY;
  late List<double> opacity;
  late List<double> rotates;

  double getOffsetY(double scale) {
    return widget.itemHeight! - widget.itemHeight! * scale;
  }

  @override
  void didUpdateWidget(_TinderSwiper oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {
    super.afterRender();

    _startIndex = -3;
    _animationCount = 5;
    opacity = [0.0, 0.9, 0.9, 1.0, 0.0, 0.0];
    scales = [0.80, 0.80, 0.85, 0.90, 1.0, 1.0, 1.0];
    rotates = [0.0, 0.0, 0.0, 0.0, 20.0, 25.0];
    _updateValues();
  }

  void _updateValues() {
    if (widget.scrollDirection == Axis.horizontal) {
      offsetsX = [0.0, 0.0, 0.0, 0.0, _swiperWidth, _swiperWidth];
      offsetsY = [
        0.0,
        0.0,
        -5.0,
        -10.0,
        -15.0,
        -20.0,
      ];
    } else {
      offsetsX = [
        0.0,
        0.0,
        5.0,
        10.0,
        15.0,
        20.0,
      ];

      offsetsY = [0.0, 0.0, 0.0, 0.0, _swiperHeight, _swiperHeight];
    }
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    final s = _getValue(scales, animationValue, i);
    final f = _getValue(offsetsX, animationValue, i);
    final fy = _getValue(offsetsY, animationValue, i);
    final o = _getValue(opacity, animationValue, i);
    final a = _getValue(rotates, animationValue, i);

    final alignment = widget.scrollDirection == Axis.horizontal
        ? Alignment.bottomCenter
        : Alignment.centerLeft;

    return Opacity(
      opacity: o,
      child: Transform.rotate(
        angle: a / 180.0,
        child: Transform.translate(
          key: ValueKey<int>(_currentIndex + i),
          offset: Offset(f, fy),
          child: Transform.scale(
            scale: s,
            alignment: alignment,
            child: SizedBox(
              width: widget.itemWidth ?? double.infinity,
              height: widget.itemHeight ?? double.infinity,
              child: widget.itemBuilder!(context, realIndex),
            ),
          ),
        ),
      ),
    );
  }
}

class _StackViewState extends _CustomLayoutStateBase<_StackSwiper> {
  late List<double> scales;
  late List<double> offsets;
  late List<double> opacity;
  late List<double> rotates;

  void _updateValues() {
    final spaceWidth = MediaQuery.sizeOf(context).width * 0.07;
    if (widget.scrollDirection == Axis.horizontal) {
      final space = (_swiperWidth - widget.itemWidth!) / 2 - 25;
      offsets = widget.axisDirection == AxisDirection.left
          ? [-space, -space / 3 * 2, -space / 3, 0.0, _swiperWidth]
          : [_swiperWidth, 0.0, -space / 3, -space / 3 * 2, -space];
    } else {
      final space = (_swiperHeight - widget.itemHeight!) / 2;
      offsets = [-space, -space / 3 * 2, -space / 3, 0.0, _swiperHeight];
    }
  }

  @override
  void didUpdateWidget(_StackSwiper oldWidget) {
    _updateValues();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void afterRender() {
    super.afterRender();
    final isRightSide = widget.axisDirection == AxisDirection.right;

    //length of the values array below
    _animationCount = 5;

    //Array below this line, '0' index is 1.0, which is the first item show in swiper.
    _startIndex = isRightSide ? -1 : -3;
    //  scales =
    //     isRightSide ? [1.0, 1.0, 0.9, 0.8, 0.7] : [0.7, 0.8, 0.9, 1.0, 1.0];
    scales =
        isRightSide ? [0.85, 1.0, 0.95, 0.9, 0.85] : [0.7, 0.8, 0.9, 1.0, 1.0];
    opacity =
        isRightSide ? [1.0, 1.0, 1.0, 0.5, 0.0] : [0.0, 0.5, 1.0, 1.0, 1.0];
    rotates = [-40.0, 0.0, 10.0, 20.0, 30.0, 40.0];

    _updateValues();
  }

  @override
  Widget _buildItem(int i, int realIndex, double animationValue) {
    final s = _getValue(scales, animationValue, i);
    final f = _getValue(offsets, animationValue, i);
    final o = _getValue(opacity, animationValue, i);
    final a = _getValue(rotates, animationValue, i);

    final offset = widget.scrollDirection == Axis.horizontal
        ? widget.axisDirection == AxisDirection.left
            ? Offset(f, f / 2)
            : Offset(-f, -f / 2)
        : Offset(f / 2, f);

    final alignment = widget.scrollDirection == Axis.horizontal
        ? widget.axisDirection == AxisDirection.left
            ? Alignment.centerLeft
            : Alignment.centerRight
        : Alignment.topCenter;

    return Opacity(
      opacity: o,
      child: Transform.rotate(
        angle: a / 180.0,
        child: Transform.translate(
          key: ValueKey<int>(_currentIndex + i),
          offset: offset,
          child: Transform.scale(
            scale: s,
            alignment: alignment,
            child: SizedBox(
              width: widget.itemWidth ?? double.infinity,
              height: widget.itemHeight ?? double.infinity,
              child: widget.itemBuilder!(context, realIndex),
            ),
          ),
        ),
      ),
    );
  }
}

class ScaleAndFadeTransformer extends PageTransformer {
  ScaleAndFadeTransformer({double? fade = 0.3, double? scale = 0.8})
      : _fade = fade,
        _scale = scale;

  final double? _scale;
  final double? _fade;

  @override
  Widget transform(Widget child, TransformInfo info) {
    final position = info.position;
    var c = child;
    if (_scale != null) {
      final scaleFactor = (1 - position!.abs()) * (1 - _scale!);
      final scale = _scale! + scaleFactor;

      c = Transform.scale(
        scale: scale,
        child: c,
      );
    }

    if (_fade != null) {
      final fadeFactor = (1 - position!.abs()) * (1 - _fade!);
      final opacity = _fade! + fadeFactor;
      c = Opacity(
        opacity: opacity,
        child: c,
      );
    }

    return c;
  }
}
