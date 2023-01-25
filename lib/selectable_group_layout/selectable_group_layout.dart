// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class SelectableGroupParentData extends ContainerBoxParentData<RenderBox> {
  double spacing = 0.0;
  int _runIndex = 0;
}

class GroupSpacing extends ParentDataWidget<SelectableGroupParentData> {
  const GroupSpacing({
    super.key,
    this.space = 0.0,
    required super.child,
  });

  final double space;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is SelectableGroupParentData);
    final SelectableGroupParentData parentData =
        renderObject.parentData! as SelectableGroupParentData;
    bool needsLayout = false;

    if (parentData.spacing != space) {
      parentData.spacing = space;
      needsLayout = true;
    }

    if (needsLayout) {
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => SelectableGroupLayout;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('space', space));
  }
}

class SelectableGroupLayout extends MultiChildRenderObjectWidget {
  SelectableGroupLayout({
    super.key,
    required this.direction,
    required this.alignment,
    required this.crossAxisAlignment,
    this.stretch = false,
    this.directionMaxWidgets = -1,
    this.runSpacing = 0.0,
    this.textDirection,
    super.children,
    this.wrap = false,
    this.clipBehavior = Clip.none,
  });

  final Axis direction;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final bool stretch;
  final double runSpacing;
  final int directionMaxWidgets;
  final TextDirection? textDirection;
  final bool wrap;
  final Clip clipBehavior;

  @override
  RenderSelectableGroupLayout createRenderObject(BuildContext context) {
    return RenderSelectableGroupLayout(
        direction: direction,
        alignment: alignment,
        runSpacing: runSpacing,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection ?? Directionality.maybeOf(context),
        clipBehavior: clipBehavior);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSelectableGroupLayout renderObject) {
    renderObject
      ..direction = direction
      ..alignment = alignment
      ..crossAxisAlignment = crossAxisAlignment
      ..runSpacing = runSpacing
      ..textDirection = textDirection ?? Directionality.maybeOf(context)
      ..directionMaxChildCount = directionMaxWidgets
      ..clipBehavior = clipBehavior;
  }
}

class RenderSelectableGroupLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, SelectableGroupParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, SelectableGroupParentData> {
  /// Creates a wrap render object.
  ///
  /// By default, the wrap layout is horizontal and both the children and the
  /// runs are aligned to the start.
  RenderSelectableGroupLayout({
    List<RenderBox>? children,
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    WrapAlignment runAlignment = WrapAlignment.start,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    double spacing = 0.0,
    double runSpacing = 0.0,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
    int directionMaxChildCount = -1,
    bool wrap = true,
  })  : _direction = direction,
        _alignment = alignment,
        _spacing = spacing,
        _runAlignment = runAlignment,
        _runSpacing = runSpacing,
        _crossAxisAlignment = crossAxisAlignment,
        _textDirection = textDirection,
        _verticalDirection = verticalDirection,
        _clipBehavior = clipBehavior,
        _directionMaxChildCount = directionMaxChildCount,
        _wrap = wrap {
    addAll(children);
  }

  bool get wrap => _wrap;

  bool _wrap;
  set wrap(bool value) {
    if (_wrap == value) {
      return;
    }
    _wrap = wrap;
    markNeedsLayout();
  }

  Axis get direction => _direction;
  Axis _direction;
  set direction(Axis value) {
    if (_direction == value) {
      return;
    }
    _direction = value;
    markNeedsLayout();
  }

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  WrapAlignment get alignment => _alignment;
  WrapAlignment _alignment;
  set alignment(WrapAlignment value) {
    if (_alignment == value) {
      return;
    }
    _alignment = value;
    markNeedsLayout();
  }

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [alignment].
  ///
  /// Defaults to 0.0.
  double get spacing => _spacing;
  double _spacing;
  set spacing(double value) {
    if (_spacing == value) {
      return;
    }
    _spacing = value;
    markNeedsLayout();
  }

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [RenderSelectableGroupLayout] in the cross
  /// axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  WrapAlignment get runAlignment => _runAlignment;
  WrapAlignment _runAlignment;

  set runAlignment(WrapAlignment value) {
    if (_runAlignment == value) {
      return;
    }
    _runAlignment = value;
    markNeedsLayout();
  }

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// For example, if [runSpacing] is 10.0, the runs will be spaced at least
  /// 10.0 logical pixels apart in the cross axis.
  ///
  /// If there is additional free space in the overall [RenderSelectableGroupLayout] (e.g.,
  /// because the wrap has a minimum size that is not filled), the additional
  /// free space will be allocated according to the [runAlignment].
  ///
  /// Defaults to 0.0.
  double get runSpacing => _runSpacing;
  double _runSpacing;
  set runSpacing(double value) {
    if (_runSpacing == value) {
      return;
    }
    _runSpacing = value;
    markNeedsLayout();
  }

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// For example, if this is set to [WrapCrossAlignment.end], and the
  /// [direction] is [Axis.horizontal], then the children within each
  /// run will have their bottom edges aligned to the bottom edge of the run.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  WrapCrossAlignment get crossAxisAlignment => _crossAxisAlignment;
  WrapCrossAlignment _crossAxisAlignment;
  set crossAxisAlignment(WrapCrossAlignment value) {
    if (_crossAxisAlignment == value) {
      return;
    }
    _crossAxisAlignment = value;
    markNeedsLayout();
  }

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// children are positioned (left-to-right or right-to-left), and the meaning
  /// of the [alignment] property's [WrapAlignment.start] and
  /// [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [alignment] is either [WrapAlignment.start] or [WrapAlignment.end], or
  /// there's more than one child, then the [textDirection] must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the order in
  /// which runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [textDirection] must not be null.
  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;
  set textDirection(TextDirection? value) {
    if (_textDirection != value) {
      _textDirection = value;
      markNeedsLayout();
    }
  }

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [alignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [alignment]
  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [verticalDirection] must not be null.
  VerticalDirection get verticalDirection => _verticalDirection;
  VerticalDirection _verticalDirection;
  set verticalDirection(VerticalDirection value) {
    if (_verticalDirection != value) {
      _verticalDirection = value;
      markNeedsLayout();
    }
  }

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  Clip get clipBehavior => _clipBehavior;
  Clip _clipBehavior = Clip.none;
  set clipBehavior(Clip value) {
    if (value != _clipBehavior) {
      _clipBehavior = value;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  ///
  ///
  ///
  int get directionMaxChildCount => _directionMaxChildCount;

  int _directionMaxChildCount;

  set directionMaxChildCount(int value) {
    if (_directionMaxChildCount == value) {
      return;
    }
    _directionMaxChildCount = value;
    markNeedsLayout();
  }

  bool get _debugHasNecessaryDirections {
    if (firstChild != null && lastChild != firstChild) {
      // i.e. there's more than one child
      switch (direction) {
        case Axis.horizontal:
          assert(textDirection != null,
              'Horizontal $runtimeType with multiple children has a null textDirection, so the layout order is undefined.');
          break;
        case Axis.vertical:
          assert(verticalDirection != null,
              'Vertical $runtimeType with multiple children has a null verticalDirection, so the layout order is undefined.');
          break;
      }
    }
    if (alignment == WrapAlignment.start || alignment == WrapAlignment.end) {
      switch (direction) {
        case Axis.horizontal:
          assert(textDirection != null,
              'Horizontal $runtimeType with alignment $alignment has a null textDirection, so the alignment cannot be resolved.');
          break;
        case Axis.vertical:
          assert(verticalDirection != null,
              'Vertical $runtimeType with alignment $alignment has a null verticalDirection, so the alignment cannot be resolved.');
          break;
      }
    }
    if (runAlignment == WrapAlignment.start ||
        runAlignment == WrapAlignment.end) {
      switch (direction) {
        case Axis.horizontal:
          assert(verticalDirection != null,
              'Horizontal $runtimeType with runAlignment $runAlignment has a null verticalDirection, so the alignment cannot be resolved.');
          break;
        case Axis.vertical:
          assert(textDirection != null,
              'Vertical $runtimeType with runAlignment $runAlignment has a null textDirection, so the alignment cannot be resolved.');
          break;
      }
    }
    if (crossAxisAlignment == WrapCrossAlignment.start ||
        crossAxisAlignment == WrapCrossAlignment.end) {
      switch (direction) {
        case Axis.horizontal:
          assert(verticalDirection != null,
              'Horizontal $runtimeType with crossAxisAlignment $crossAxisAlignment has a null verticalDirection, so the alignment cannot be resolved.');
          break;
        case Axis.vertical:
          assert(textDirection != null,
              'Vertical $runtimeType with crossAxisAlignment $crossAxisAlignment has a null textDirection, so the alignment cannot be resolved.');
          break;
      }
    }
    return true;
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! SelectableGroupParentData) {
      child.parentData = SelectableGroupParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    switch (direction) {
      case Axis.horizontal:
        double width = 0.0;
        RenderBox? child = firstChild;
        while (child != null) {
          width = math.max(width, child.getMinIntrinsicWidth(double.infinity));
          child = childAfter(child);
        }
        return width;
      case Axis.vertical:
        return computeDryLayout(BoxConstraints(maxHeight: height)).width;
    }
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    switch (direction) {
      case Axis.horizontal:
        double width = 0.0;
        RenderBox? child = firstChild;
        while (child != null) {
          width += child.getMaxIntrinsicWidth(double.infinity);
          child = childAfter(child);
        }
        return width;
      case Axis.vertical:
        return computeDryLayout(BoxConstraints(maxHeight: height)).width;
    }
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    switch (direction) {
      case Axis.horizontal:
        return computeDryLayout(BoxConstraints(maxWidth: width)).height;
      case Axis.vertical:
        double height = 0.0;
        RenderBox? child = firstChild;
        while (child != null) {
          height =
              math.max(height, child.getMinIntrinsicHeight(double.infinity));
          child = childAfter(child);
        }
        return height;
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    switch (direction) {
      case Axis.horizontal:
        return computeDryLayout(BoxConstraints(maxWidth: width)).height;
      case Axis.vertical:
        double height = 0.0;
        RenderBox? child = firstChild;
        while (child != null) {
          height += child.getMaxIntrinsicHeight(double.infinity);
          child = childAfter(child);
        }
        return height;
    }
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  double _getMainAxisExtent(Size childSize) {
    switch (direction) {
      case Axis.horizontal:
        return childSize.width;
      case Axis.vertical:
        return childSize.height;
    }
  }

  double _getCrossAxisExtent(Size childSize) {
    switch (direction) {
      case Axis.horizontal:
        return childSize.height;
      case Axis.vertical:
        return childSize.width;
    }
  }

  Offset _getOffset(double mainAxisOffset, double crossAxisOffset) {
    switch (direction) {
      case Axis.horizontal:
        return Offset(mainAxisOffset, crossAxisOffset);
      case Axis.vertical:
        return Offset(crossAxisOffset, mainAxisOffset);
    }
  }

  double _getChildCrossAxisOffset(bool flipCrossAxis, double runCrossAxisExtent,
      double childCrossAxisExtent) {
    final double freeSpace = runCrossAxisExtent - childCrossAxisExtent;
    switch (crossAxisAlignment) {
      case WrapCrossAlignment.start:
        return flipCrossAxis ? freeSpace : 0.0;
      case WrapCrossAlignment.end:
        return flipCrossAxis ? 0.0 : freeSpace;
      case WrapCrossAlignment.center:
        return freeSpace / 2.0;
    }
  }

  bool _hasVisualOverflow = false;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeDryLayout(constraints);
  }

  Size _computeDryLayout(BoxConstraints constraints,
      [ChildLayouter layoutChild = ChildLayoutHelper.dryLayoutChild]) {
    if (wrap) {
      return _computeDryWrapLayout(constraints, layoutChild);
    } else {
      return _computeDryFlexLayout(constraints, layoutChild);
    }
  }

  Size _computeDryWrapLayout(BoxConstraints constraints,
      [ChildLayouter layoutChild = ChildLayoutHelper.dryLayoutChild]) {
    final BoxConstraints childConstraints;
    double mainAxisLimit = 0.0;
    switch (direction) {
      case Axis.horizontal:
        childConstraints = BoxConstraints(maxWidth: constraints.maxWidth);
        mainAxisLimit = constraints.maxWidth;
        break;
      case Axis.vertical:
        childConstraints = BoxConstraints(maxHeight: constraints.maxHeight);
        mainAxisLimit = constraints.maxHeight;
        break;
    }

    double mainAxisExtent = 0.0;
    double crossAxisExtent = 0.0;
    double runMainAxisExtent = 0.0;
    double runCrossAxisExtent = 0.0;
    int childCount = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as SelectableGroupParentData;
      final spacing = childParentData.spacing;
      final Size childSize = layoutChild(child, childConstraints);
      final double childMainAxisExtent = _getMainAxisExtent(childSize);
      final double childCrossAxisExtent = _getCrossAxisExtent(childSize);
      // There must be at least one child before we move on to the next run.
      if (childCount > 0 &&
          (runMainAxisExtent + childMainAxisExtent + spacing > mainAxisLimit ||
              childCount == directionMaxChildCount)) {
        mainAxisExtent = math.max(mainAxisExtent, runMainAxisExtent);
        crossAxisExtent += runCrossAxisExtent + runSpacing;
        runMainAxisExtent = 0.0;
        runCrossAxisExtent = 0.0;
        childCount = 0;
      }
      runMainAxisExtent += childMainAxisExtent;
      runCrossAxisExtent = math.max(runCrossAxisExtent, childCrossAxisExtent);

      // if (childCount > 0) {
      runMainAxisExtent += spacing;
      // }
      childCount += 1;
      child = childAfter(child);
    }
    crossAxisExtent += runCrossAxisExtent + runSpacing;
    mainAxisExtent = math.max(mainAxisExtent, runMainAxisExtent);

    switch (direction) {
      case Axis.horizontal:
        return constraints.constrain(Size(mainAxisExtent, crossAxisExtent));
      case Axis.vertical:
        return constraints.constrain(Size(crossAxisExtent, mainAxisExtent));
    }
  }

  Size _computeDryFlexLayout(constraints, layoutChild) {
    RenderBox? child = firstChild;
    if (child == null) {
      size = constraints.smallest;
      return size;
    }

    double mainAxisExtent = 0.0;
    // double crossAxisExtent = 0.0;
    // double runMainAxisExtent = 0.0;
    // double runCrossAxisExtent = 0.0;
    int childCount = 0;

    BoxConstraints childConstraints;

    while (child != null) {
      final SelectableGroupParentData parentData =
          child.parentData as SelectableGroupParentData;

      childConstraints = direction == Axis.vertical
          ? BoxConstraints(maxWidth: constraints.maxWidth)
          : BoxConstraints(maxHeight: constraints.maxHeight);

      final Size childSize = layoutChild(child, childConstraints);
      final double childMainAxisExtent = _getMainAxisExtent(childSize);

      mainAxisExtent += childMainAxisExtent + runSpacing;
      child = parentData.nextSibling;
    }

    double containerCrossAxisExtent;

    switch (direction) {
      case Axis.horizontal:
        {
          containerCrossAxisExtent = size.height;
          return constraints
              .constrain(Size(mainAxisExtent, containerCrossAxisExtent));
        }

      case Axis.vertical:
        {
          containerCrossAxisExtent = size.width;
          return constraints
              .constrain(Size(containerCrossAxisExtent, mainAxisExtent));
        }
    }
  }

  @override
  void performLayout() {
    if (wrap) {
      performWrapLayout();
    } else {
      performFlexLayout();
    }
  }

  void performWrapLayout() {
    final BoxConstraints constraints = this.constraints;
    assert(_debugHasNecessaryDirections);
    _hasVisualOverflow = false;
    RenderBox? child = firstChild;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    final BoxConstraints childConstraints;
    double mainAxisLimit = 0.0;
    bool flipMainAxis = false;
    bool flipCrossAxis = false;
    switch (direction) {
      case Axis.horizontal:
        childConstraints = BoxConstraints(maxWidth: constraints.maxWidth);
        mainAxisLimit = constraints.maxWidth;
        if (textDirection == TextDirection.rtl) {
          flipMainAxis = true;
        }
        if (verticalDirection == VerticalDirection.up) {
          flipCrossAxis = true;
        }
        break;
      case Axis.vertical:
        childConstraints = BoxConstraints(maxHeight: constraints.maxHeight);
        mainAxisLimit = constraints.maxHeight;
        if (verticalDirection == VerticalDirection.up) {
          flipMainAxis = true;
        }
        if (textDirection == TextDirection.rtl) {
          flipCrossAxis = true;
        }
        break;
    }

    // final double spacing = this.spacing;
    // final double runSpacing = this.runSpacing;
    final List<_RunMetrics> runMetrics = <_RunMetrics>[];
    double mainAxisExtent = 0.0;
    double crossAxisExtent = 0.0;
    double runMainAxisExtent = 0.0;
    double runCrossAxisExtent = 0.0;
    int childCount = 0;

    while (child != null) {
      final SelectableGroupParentData parentData =
          child.parentData as SelectableGroupParentData;

      final spacing = parentData.spacing;

      child.layout(childConstraints, parentUsesSize: true);
      final double childMainAxisExtent = _getMainAxisExtent(child.size);
      final double childCrossAxisExtent = _getCrossAxisExtent(child.size);
      if (childCount > 0 &&
          (runMainAxisExtent + spacing + childMainAxisExtent > mainAxisLimit ||
              childCount == directionMaxChildCount)) {
        mainAxisExtent = math.max(mainAxisExtent, runMainAxisExtent);
        crossAxisExtent += runCrossAxisExtent;

        // if (runMetrics.isNotEmpty) {
        crossAxisExtent += runSpacing;
        // }
        runMetrics.add(
            _RunMetrics(runMainAxisExtent, runCrossAxisExtent, childCount));
        runMainAxisExtent = 0.0;
        runCrossAxisExtent = 0.0;
        childCount = 0;
      }
      runMainAxisExtent += childMainAxisExtent;

      //  (childCount > 0) verwijderd wil spacing splitsen in left and right
      //if (childCount > 0) {
      runMainAxisExtent += spacing;
      //}
      runCrossAxisExtent = math.max(runCrossAxisExtent, childCrossAxisExtent);
      childCount += 1;
      final SelectableGroupParentData childParentData =
          child.parentData! as SelectableGroupParentData;
      childParentData._runIndex = runMetrics.length;
      child = childParentData.nextSibling;
    }
    if (childCount > 0) {
      mainAxisExtent = math.max(mainAxisExtent, runMainAxisExtent);
      crossAxisExtent += runCrossAxisExtent;
      // if (runMetrics.isNotEmpty) {
      crossAxisExtent += runSpacing;
      // }
      runMetrics
          .add(_RunMetrics(runMainAxisExtent, runCrossAxisExtent, childCount));
    }

    final int runCount = runMetrics.length;
    assert(runCount > 0);

    double containerMainAxisExtent = 0.0;
    double containerCrossAxisExtent = 0.0;

    switch (direction) {
      case Axis.horizontal:
        size = constraints.constrain(Size(mainAxisExtent, crossAxisExtent));
        containerMainAxisExtent = size.width;
        containerCrossAxisExtent = size.height;
        break;
      case Axis.vertical:
        size = constraints.constrain(Size(crossAxisExtent, mainAxisExtent));
        containerMainAxisExtent = size.height;
        containerCrossAxisExtent = size.width;
        break;
    }

    _hasVisualOverflow = containerMainAxisExtent < mainAxisExtent ||
        containerCrossAxisExtent < crossAxisExtent;

    final double crossAxisFreeSpace =
        math.max(0.0, containerCrossAxisExtent - crossAxisExtent);
    double runLeadingSpace = 0.0;
    double runBetweenSpace = 0.0;
    switch (runAlignment) {
      case WrapAlignment.start:
        break;
      case WrapAlignment.end:
        runLeadingSpace = crossAxisFreeSpace;
        break;
      case WrapAlignment.center:
        runLeadingSpace = crossAxisFreeSpace / 2.0;
        break;
      case WrapAlignment.spaceBetween:
        runBetweenSpace =
            runCount > 1 ? crossAxisFreeSpace / (runCount - 1) : 0.0;
        break;
      case WrapAlignment.spaceAround:
        runBetweenSpace = crossAxisFreeSpace / runCount;
        runLeadingSpace = runBetweenSpace / 2.0;
        break;
      case WrapAlignment.spaceEvenly:
        runBetweenSpace = crossAxisFreeSpace / (runCount + 1);
        runLeadingSpace = runBetweenSpace;
        break;
    }

    // runBetweenSpace += runSpacing;
    double crossAxisOffset = flipCrossAxis
        ? containerCrossAxisExtent - runLeadingSpace
        : runLeadingSpace;

    child = firstChild;
    for (int i = 0; i < runCount; ++i) {
      final _RunMetrics metrics = runMetrics[i];
      final double runMainAxisExtent = metrics.mainAxisExtent;
      final double runCrossAxisExtent = metrics.crossAxisExtent;
      final int childCount = metrics.childCount;

      final double mainAxisFreeSpace =
          math.max(0.0, containerMainAxisExtent - runMainAxisExtent);
      double childLeadingSpace = 0.0;
      double childBetweenSpace = 0.0;

      switch (alignment) {
        case WrapAlignment.start:
          break;
        case WrapAlignment.end:
          childLeadingSpace = mainAxisFreeSpace;
          break;
        case WrapAlignment.center:
          childLeadingSpace = mainAxisFreeSpace / 2.0;
          break;
        case WrapAlignment.spaceBetween:
          childBetweenSpace =
              childCount > 1 ? mainAxisFreeSpace / (childCount - 1) : 0.0;
          break;
        case WrapAlignment.spaceAround:
          childBetweenSpace = mainAxisFreeSpace / childCount;
          childLeadingSpace = childBetweenSpace / 2.0;
          break;
        case WrapAlignment.spaceEvenly:
          childBetweenSpace = mainAxisFreeSpace / (childCount + 1);
          childLeadingSpace = childBetweenSpace;
          break;
      }

      //childBetweenSpace += spacing;
      double childMainPosition = flipMainAxis
          ? containerMainAxisExtent - childLeadingSpace
          : childLeadingSpace;

      if (flipCrossAxis) {
        crossAxisOffset -= runCrossAxisExtent;
      }

      while (child != null) {
        final SelectableGroupParentData childParentData =
            child.parentData! as SelectableGroupParentData;
        if (childParentData._runIndex != i) {
          break;
        }
        final spacing = childParentData.spacing;

        final double childMainAxisExtent = _getMainAxisExtent(child.size);
        final double childCrossAxisExtent = _getCrossAxisExtent(child.size);
        final double childCrossAxisOffset = _getChildCrossAxisOffset(
            flipCrossAxis, runCrossAxisExtent, childCrossAxisExtent);
        if (flipMainAxis) {
          childMainPosition -= childMainAxisExtent;
        }
        childParentData.offset = _getOffset(childMainPosition + spacing / 2.0,
            crossAxisOffset + childCrossAxisOffset + runSpacing / 2.0);
        if (flipMainAxis) {
          childMainPosition -= childBetweenSpace - spacing;
        } else {
          childMainPosition +=
              childMainAxisExtent + childBetweenSpace + spacing;
        }
        child = childParentData.nextSibling;
      }

      if (flipCrossAxis) {
        crossAxisOffset -= runBetweenSpace - runSpacing;
      } else {
        crossAxisOffset += runCrossAxisExtent + runBetweenSpace + runSpacing;
      }
    }
  }

  void performFlexLayout() {
    final BoxConstraints constraints = this.constraints;

    _hasVisualOverflow = false;

    RenderBox? child = firstChild;
    if (child == null) {
      size = constraints.smallest;
      return;
    }

    double mainAxisExtent = 0.0;
    // double crossAxisExtent = 0.0;
    // double runMainAxisExtent = 0.0;
    // double runCrossAxisExtent = 0.0;
    int childCount = 0;

    BoxConstraints childConstraints;

    while (child != null) {
      final SelectableGroupParentData parentData =
          child.parentData as SelectableGroupParentData;

      childConstraints = direction == Axis.vertical
          ? BoxConstraints(maxWidth: constraints.maxWidth)
          : BoxConstraints(maxHeight: constraints.maxHeight);

      child.layout(childConstraints, parentUsesSize: true);
      final double childMainAxisExtent = _getMainAxisExtent(child.size);
      // final double childCrossAxisExtent = _getCrossAxisExtent(child.size);

      mainAxisExtent += childMainAxisExtent + runSpacing;
      // final runCrossAxisExtent = childCrossAxisExtent + parentData.spacing;

      // crossAxisExtent = math.max(runCrossAxisExtent, crossAxisExtent);

      child = parentData.nextSibling;
    }

    double containerMainAxisExtent;
    double containerCrossAxisExtent;

    switch (direction) {
      case Axis.horizontal:
        containerMainAxisExtent = size.width;
        containerCrossAxisExtent = size.height;
        size = constraints
            .constrain(Size(mainAxisExtent, containerCrossAxisExtent));
        break;
      case Axis.vertical:
        containerMainAxisExtent = size.height;
        containerCrossAxisExtent = size.width;
        size = constraints
            .constrain(Size(containerCrossAxisExtent, mainAxisExtent));
        break;
    }

    _hasVisualOverflow = containerMainAxisExtent < mainAxisExtent;
    //  || containerCrossAxisExtent < crossAxisExtent;

    containerCrossAxisExtent = size.height;

    double mainAxisFreeSpace = containerMainAxisExtent - mainAxisExtent;
    double childBetweenSpace = 0.0;
    double childLeadingSpace = 0.0;

    switch (alignment) {
      case WrapAlignment.start:
        break;
      case WrapAlignment.end:
        childLeadingSpace = mainAxisFreeSpace;
        break;
      case WrapAlignment.center:
        childLeadingSpace = mainAxisFreeSpace / 2.0;
        break;
      case WrapAlignment.spaceBetween:
        childBetweenSpace =
            childCount > 1 ? mainAxisFreeSpace / (childCount - 1) : 0.0;
        break;
      case WrapAlignment.spaceAround:
        childBetweenSpace = mainAxisFreeSpace / childCount;
        childLeadingSpace = childBetweenSpace / 2.0;
        break;
      case WrapAlignment.spaceEvenly:
        childBetweenSpace = mainAxisFreeSpace / (childCount + 1);
        childLeadingSpace = childBetweenSpace;
        break;
    }

    // double runAxisFreeSpace = containerCrossAxisExtent - crossAxisExtent;
    // double runLeadingSpace = 0.0;

    // switch (runAlignment) {
    //   case WrapAlignment.start:
    //     break;
    //   case WrapAlignment.end:
    //     runLeadingSpace = runAxisFreeSpace;
    //     break;
    //   case WrapAlignment.center:
    //     runLeadingSpace = runAxisFreeSpace / 2.0;
    //     break;
    //   case WrapAlignment.spaceBetween:
    //   case WrapAlignment.spaceAround:
    //   case WrapAlignment.spaceEvenly:
    //     break;
    // }

    double crossAxisOffset = 0.0;
    double childMainPosition = childLeadingSpace;

    while (child != null) {
      final SelectableGroupParentData parentData =
          child.parentData as SelectableGroupParentData;

      final double childMainAxisExtent = _getMainAxisExtent(child.size);
      final double childCrossAxisExtent = _getCrossAxisExtent(child.size);

      final childCrossAxisOffset = _getChildCrossAxisOffset(
          false, containerCrossAxisExtent, childCrossAxisExtent);

      parentData.offset = _getOffset(childMainPosition + runSpacing / 2.0,
          crossAxisOffset + childCrossAxisOffset + spacing / 2.0);

      // if (flipMainAxis) {
      //   childMainPosition -= childBetweenSpace - spacing;
      // } else {
      childMainPosition += childMainAxisExtent + childBetweenSpace + spacing;
      // }

      childMainPosition += childMainAxisExtent + spacing;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO(ianh): move the debug flex overflow paint logic somewhere common so
    // it can be reused here
    if (_hasVisualOverflow && clipBehavior != Clip.none) {
      _clipRectLayer.layer = context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        defaultPaint,
        clipBehavior: clipBehavior,
        oldLayer: _clipRectLayer.layer,
      );
    } else {
      _clipRectLayer.layer = null;
      defaultPaint(context, offset);
    }
  }

  final LayerHandle<ClipRectLayer> _clipRectLayer =
      LayerHandle<ClipRectLayer>();

  @override
  void dispose() {
    _clipRectLayer.layer = null;
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(EnumProperty<WrapAlignment>('alignment', alignment));
    properties.add(DoubleProperty('spacing', spacing));
    properties.add(EnumProperty<WrapAlignment>('runAlignment', runAlignment));
    properties.add(DoubleProperty('runSpacing', runSpacing));
    properties.add(DoubleProperty('crossAxisAlignment', runSpacing));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
    properties.add(EnumProperty<VerticalDirection>(
        'verticalDirection', verticalDirection,
        defaultValue: VerticalDirection.down));
  }
}

class _RunMetrics {
  _RunMetrics(this.mainAxisExtent, this.crossAxisExtent, this.childCount);

  final double mainAxisExtent;
  final double crossAxisExtent;
  final int childCount;
}
