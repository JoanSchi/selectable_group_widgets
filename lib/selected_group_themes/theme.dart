import 'dart:ui';
import 'package:flutter/material.dart';

class SelectableGroupStyle extends ThemeExtension<SelectableGroupStyle> {
  const SelectableGroupStyle({
    this.itemStyle,
  });

  final SelectableItemStyle? itemStyle;

  @override
  SelectableGroupStyle copyWith({
    SelectableItemStyle? itemStyle,
  }) {
    return SelectableGroupStyle(
      itemStyle: itemStyle ?? this.itemStyle,
    );
  }

  @override
  SelectableGroupStyle lerp(
      ThemeExtension<SelectableGroupStyle>? other, double t) {
    if (other is! SelectableGroupStyle) {
      return this;
    }
    return SelectableGroupStyle(
        itemStyle: SelectableItemStyle.lerp(itemStyle, other.itemStyle, t));
  }
}

class RadioButtonStyle extends ThemeExtension<RadioButtonStyle> {
  const RadioButtonStyle({
    this.radius = 0.0,
    this.itemStyle,
    this.rounded = true,
  });

  final double? radius;
  final SelectableItemStyle? itemStyle;
  final bool rounded;

  @override
  RadioButtonStyle copyWith({
    double? radius,
    SelectableItemStyle? itemStyle,
    bool? rounded,
  }) {
    return RadioButtonStyle(
      radius: radius ?? this.radius,
      itemStyle: itemStyle ?? this.itemStyle,
      rounded: rounded ?? this.rounded,
    );
  }

  @override
  RadioButtonStyle lerp(ThemeExtension<RadioButtonStyle>? other, double t) {
    if (other is! RadioButtonStyle) {
      return this;
    }
    return RadioButtonStyle(
        radius: lerpDouble(radius, other.radius, t),
        itemStyle: SelectableItemStyle.lerp(itemStyle, other.itemStyle, t),
        rounded: other.rounded);
  }
}

class CheckButtonGroupStyle extends ThemeExtension<CheckButtonGroupStyle> {
  const CheckButtonGroupStyle({
    this.radius = 24.0,
    this.itemStyle,
    this.rounded = false,
  });

  final double? radius;
  final SelectableItemStyle? itemStyle;
  final bool? rounded;

  @override
  CheckButtonGroupStyle copyWith({
    double? radius,
    SelectableItemStyle? itemStyle,
    bool? rounded,
  }) {
    return CheckButtonGroupStyle(
      radius: radius ?? this.radius,
      itemStyle: itemStyle ?? this.itemStyle,
      rounded: rounded ?? this.rounded,
    );
  }

  @override
  CheckButtonGroupStyle lerp(
      ThemeExtension<CheckButtonGroupStyle>? other, double t) {
    if (other is! CheckButtonGroupStyle) {
      return this;
    }
    return CheckButtonGroupStyle(
      radius: lerpDouble(radius, other.radius, t),
      itemStyle: SelectableItemStyle.lerp(itemStyle, other.itemStyle, t),
      rounded: other.rounded,
    );
  }
}

class SelectableItemStyle {
  const SelectableItemStyle({
    required this.backgroundColor,
    required this.forgroundColor,
    required this.disableColor,
    this.textStyle,
    this.height,
  });

  final Color? backgroundColor;
  final Color? forgroundColor;
  final Color? disableColor;
  final TextStyle? textStyle;
  final double? height;

  SelectableItemStyle copyWith({
    Color? backgroundColor,
    Color? forgroundColor,
    double? spaceBetween,
    TextStyle? textStyle,
    double? height,
  }) {
    return SelectableItemStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      forgroundColor: forgroundColor ?? this.forgroundColor,
      disableColor: disableColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      height: height ?? this.height,
    );
  }

  static SelectableItemStyle? lerp(
      SelectableItemStyle? a, SelectableItemStyle? b, double t) {
    if (a == null && b == null) {
      return null;
    }

    return SelectableItemStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      forgroundColor: Color.lerp(a?.forgroundColor, b?.forgroundColor, t),
      disableColor: Color.lerp(a?.disableColor, b?.disableColor, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }
}
