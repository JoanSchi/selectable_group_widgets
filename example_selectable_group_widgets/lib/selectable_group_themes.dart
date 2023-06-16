// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:selectable_group_widgets/selectable_group_layout/selectable_group_layout.dart';
import 'package:selectable_group_widgets/selectable_group_widgets.dart';
import 'package:selectable_group_widgets/selected_group_themes/material_group.dart';
import 'package:selectable_group_widgets/selected_group_themes/material_inkwell_group.dart';
import 'package:selectable_group_widgets/selected_group_themes/rounded_group.dart';

enum SelectedGroupTheme {
  material,
  materialInkWell,
  button,
}

class SelectableGroupOptions {
  String test;

  SelectableGroupOptions(
    this.test,
  );
}

class MyRadioGroup<V> extends RadioGroup<V, SelectableGroupOptions> {
  final double? space;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final SelectedGroupTheme groupTheme;

  MyRadioGroup({
    required super.list,
    required super.groupValue,
    required super.onChange,
    super.enabled = true,
    this.space,
    this.primaryColor,
    this.onPrimaryColor,
    this.groupTheme = SelectedGroupTheme.material,
  });

  @override
  List<Widget> buildChildren(
      BuildContext context, SelectableGroupOptions? options) {
    debugPrint('Options ${options?.test}');

    switch (groupTheme) {
      case SelectedGroupTheme.material:
        {
          return [
            for (RadioSelectable<V> s in list)
              MaterialSelectedRadioBox<V>(
                  enabled: enabled,
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
                enabled: enabled,
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
                    enabled: enabled,
                    outlinedBorder: const StadiumBorder()),
              )
          ];
        }
    }
  }
}

class MyCheckGroup<V> extends CheckGroup<V, SelectableGroupOptions> {
  final double? space;
  final SelectedGroupTheme groupTheme;
  final Color? primaryColor;
  final Color? onPrimaryColor;

  MyCheckGroup({
    required super.list,
    required super.onChange,
    super.enabled,
    this.space,
    this.primaryColor,
    this.onPrimaryColor,
    this.groupTheme = SelectedGroupTheme.material,
  });

  @override
  List<Widget> buildChildren(
      BuildContext context, SelectableGroupOptions? options) {
    switch (groupTheme) {
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
                enabled: s.enabled,
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
                enabled: s.enabled,
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

class UndefinedSelectableGroup<O> extends StatelessWidget {
  final List<SelectableGroup> groups;
  final bool wrap;
  final int directionMaxWidgets;
  final Axis direction;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAlignment;
  final WrapAlignment runAlignment;
  final O? options;
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
      this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      for (SelectableGroup group in groups)
        ...group.buildChildren(context, options)
    ];

    return SelectableGroupLayout(
      wrap: wrap,
      directionMaxWidgets: directionMaxWidgets,
      direction: direction,
      alignment: alignment,
      crossAxisAlignment: crossAlignment,
      runAlignment: runAlignment,
      runSpacing: 0.0,
      // dynamicMaxRuns: const [
      //   DynamicMaxRun(numberList: [2, 1, 2], maxAxisLimit: 350),
      //   DynamicMaxRun(numberList: [5], maxAxisLimit: 900),
      // ],
      children: children,
    );

    // return Wrap(
    //   direction: direction,
    //   alignment: alignment,
    //   crossAxisAlignment: crossAlignment,
    //   runSpacing: 0.0,
    //   children: children,
    // );
  }
}
