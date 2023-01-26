// ignore_for_file: public_member_api_docs, sort_constructors_first
library selectable_group_widgets;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:selectable_group_widgets/selected_group_themes/material_inkwell_group.dart';

import 'selectable_group_layout/selectable_group_layout.dart';
import 'selected_group_themes/material_group.dart';
import 'selected_group_themes/rounded_group.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

typedef CheckedValueChanged<T> = void Function(T identifier, bool value);

enum SelectedGroupTheme {
  material,
  materialInkWell,
  button,
}

abstract class SelectableGroup {
  final SelectedGroupTheme? _groupTheme;
  final Color? primaryColor;
  final Color? onPrimaryColor;

  SelectableGroup({
    SelectedGroupTheme? groupTheme,
    this.primaryColor,
    this.onPrimaryColor,
  }) : _groupTheme = groupTheme;

  List<Widget> buildChildren(
      BuildContext context, SelectedGroupTheme? selectedGroupTheme);

  SelectedGroupTheme selectGroupTheme(SelectedGroupTheme? defaultGroupTheme) {
    if (_groupTheme != null) {
      return _groupTheme!;
    } else if (defaultGroupTheme != null) {
      return defaultGroupTheme;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return SelectedGroupTheme.material;
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return SelectedGroupTheme.material;
    }
  }
}

class RadioSelectable<V> {
  String text;
  V value;
  bool enabled;

  RadioSelectable({
    required this.text,
    required this.value,
    this.enabled = true,
  });
}

class CheckSelectable<V> {
  String text;
  V identifier;
  bool value;
  bool enabled;

  CheckSelectable({
    required this.text,
    required this.identifier,
    required this.value,
    this.enabled = true,
  });
}

class RadioGroup<V> extends SelectableGroup {
  final V groupValue;
  final List<RadioSelectable<V>> list;
  final ValueChanged<V?> onChange;
  final double? space;

  RadioGroup({
    required this.list,
    required this.groupValue,
    required this.onChange,
    this.space,
    super.primaryColor,
    super.onPrimaryColor,
    super.groupTheme,
  });

  @override
  List<Widget> buildChildren(
      BuildContext context, SelectedGroupTheme? selectedGroupTheme) {
    switch (selectGroupTheme(selectedGroupTheme)) {
      case SelectedGroupTheme.material:
        {
          return [
            for (RadioSelectable<V> s in list)
              MaterialSelectedRadioBox<V>(
                  text: s.text,
                  onChange: onChange,
                  value: s.value,
                  groupValue: groupValue)
          ];
        }
      case SelectedGroupTheme.materialInkWell:
        {
          return [
            for (RadioSelectable<V> s in list)
              MaterialInkwellSelectedRadioBox<V>(
                text: s.text,
                onChange: onChange,
                value: s.value,
                groupValue: groupValue,
              )
          ];
        }
      case SelectedGroupTheme.button:
        {
          final space = this.space ?? 4.0;
          return [
            for (RadioSelectable<V> s in list)
              GroupSpacing(
                space: space,
                child: SelectedButton(
                    text: s.text,
                    onChange: onChange,
                    value: s.value,
                    groupValue: groupValue,
                    enabled: s.enabled,
                    outlinedBorder: const StadiumBorder()),
              )
          ];
        }
    }
  }
}

class CheckGroup<V> extends SelectableGroup {
  final List<CheckSelectable<V>> list;
  final CheckedValueChanged onChange;
  final double? space;

  CheckGroup({
    required this.list,
    required this.onChange,
    this.space,
    super.primaryColor,
    super.onPrimaryColor,
    super.groupTheme,
  });

  @override
  List<Widget> buildChildren(
      BuildContext context, SelectedGroupTheme? selectedGroupTheme) {
    switch (selectGroupTheme(selectedGroupTheme)) {
      case SelectedGroupTheme.material:
        {
          return [
            for (CheckSelectable<V> s in list)
              MaterialSelectableCheckBox(
                text: s.text,
                onChange: (bool? value) => onChange(s.identifier, s.value),
                value: s.value,
                primaryColor: primaryColor,
                onPrimaryColor: onPrimaryColor,
              )
          ];
        }
      case SelectedGroupTheme.materialInkWell:
        {
          return [
            for (CheckSelectable<V> s in list)
              MaterialInkWellSelectableCheckBox(
                text: s.text,
                onChange: (bool? value) => onChange(s.identifier, s.value),
                value: s.value,
                primaryColor: primaryColor,
                onPrimaryColor: onPrimaryColor,
              )
          ];
        }
      case SelectedGroupTheme.button:
        {
          final space = this.space ?? 4.0;

          return [
            for (CheckSelectable<V> s in list)
              GroupSpacing(
                space: space,
                child: SelectedButton(
                  text: s.text,
                  onChange: (bool? value) => onChange(s.identifier, s.value),
                  value: true,
                  groupValue: s.value,
                  enabled: s.enabled,
                  primaryColor: primaryColor,
                  onPrimaryColor: onPrimaryColor,
                ),
              )
          ];
        }
    }
  }
}

class UndefinedSelectableGroup extends StatelessWidget {
  final List<SelectableGroup> groups;
  final bool wrap;
  final SelectedGroupTheme selectedGroupTheme;
  final int directionMaxWidgets;
  final Axis direction;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAlignment;
  final WrapAlignment runAlignment;
  // final MainAxisSize mainAxisSize;

  const UndefinedSelectableGroup(
      {Key? key,
      required this.groups,
      required this.wrap,
      this.directionMaxWidgets = -1,
      required this.direction,
      this.alignment = WrapAlignment.center,
      this.runAlignment = WrapAlignment.center,
      this.crossAlignment = WrapCrossAlignment.start,
      this.selectedGroupTheme = SelectedGroupTheme.material})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      for (SelectableGroup group in groups)
        ...group.buildChildren(context, selectedGroupTheme)
    ];

    return SelectableGroupLayout(
      wrap: wrap,
      directionMaxWidgets: directionMaxWidgets,
      direction: direction,
      alignment: alignment,
      crossAxisAlignment: crossAlignment,
      runAlignment: runAlignment,
      runSpacing: 0.0,
      children: children,
    );

    // return wrap
    //     ? SelectableGroupLayout(
    //         directionMaxWidgets: directionMaxWidgets,
    //         direction: direction,
    //         alignment: WrapAlignment.center,
    //         crossAxisAlignment: WrapCrossAlignment.center,
    //         runSpacing: 0.0,
    //         children: children,
    //       )
    //     : Flex(
    //         direction: direction,
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: children,
    //       );
  }
}
