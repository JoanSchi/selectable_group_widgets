// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../selectable_group_widgets.dart';

class MaterialSelectedRadioBox<T> extends StatelessWidget {
  final String text;
  final ValueChanged<T?> onChange;
  final T value;
  final T groupValue;
  final bool enabled;
  final Color? disabledColor;

  const MaterialSelectedRadioBox({
    Key? key,
    required this.text,
    required this.onChange,
    required this.value,
    required this.groupValue,
    this.disabledColor,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
        color: enabled ? null : (disabledColor ?? theme.disabledColor));

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio(
            groupValue: groupValue,
            value: value,
            onChanged: enabled ? onChange : null,
          ),
          Text(
            text,
            style: textStyle,
          ),
          const SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }
}

class MaterialSelectableCheckBox extends StatelessWidget {
  final String text;
  final ValueChanged<bool?> onChange;
  final bool value;
  final bool enabled;
  final Color? disabledColor;

  const MaterialSelectableCheckBox({
    Key? key,
    required this.text,
    required this.onChange,
    required this.value,
    this.enabled = true,
    this.disabledColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
        color: enabled ? null : (disabledColor ?? theme.disabledColor));

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: value,
            onChanged: enabled ? onChange : null,
          ),
          Text(
            text,
            style: textStyle,
          ),
          const SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }
}
