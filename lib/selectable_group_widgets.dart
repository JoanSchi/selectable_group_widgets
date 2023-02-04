// ignore_for_file: public_member_api_docs, sort_constructors_first
library selectable_group_widgets;

import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

typedef CheckedValueChanged<T> = void Function(T identifier, bool value);

abstract class SelectableGroup<O> {
  SelectableGroup();

  List<Widget> buildChildren(BuildContext context, O options);
}

class RadioSelectable<V> {
  String text;
  V value;

  RadioSelectable({
    required this.text,
    required this.value,
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

abstract class RadioGroup<V, O> extends SelectableGroup<O> {
  final V groupValue;
  final List<RadioSelectable<V>> list;
  final ValueChanged<V?> onChange;
  final bool enabled;

  RadioGroup({
    required this.list,
    required this.groupValue,
    required this.onChange,
    this.enabled = true,
  });
}

abstract class CheckGroup<V, O> extends SelectableGroup<O> {
  final List<CheckSelectable<V>> list;
  final CheckedValueChanged onChange;
  final bool enabled;

  CheckGroup({required this.list, required this.onChange, this.enabled = true});
}
