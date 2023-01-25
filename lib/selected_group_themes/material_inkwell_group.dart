// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MaterialInkwellSelectedRadioBox<T> extends StatelessWidget {
  final String text;
  final ValueChanged<T?> onChange;
  final T value;
  final T groupValue;
  final bool enabled;
  final Color? disabledColor;

  const MaterialInkwellSelectedRadioBox({
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

    final primaryOpacity = theme.colorScheme.primary.withOpacity(0.2);

    return InkWell2(
        borderRadius: BorderRadius.circular(16.0),
        onTap: enabled ? () => onChange(value) : null,
        splashColor: primaryOpacity,
        highlightColor: primaryOpacity,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio(
                groupValue: groupValue,
                value: value,
                onChanged: enabled ? onChange : null,
                splashRadius: 0.0,
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
        ));
  }
}

class MaterialInkWellSelectableCheckBox extends StatelessWidget {
  final String text;
  final ValueChanged<bool?> onChange;
  final bool value;
  final bool enabled;
  final Color? disabledColor;

  const MaterialInkWellSelectableCheckBox({
    Key? key,
    required this.text,
    required this.onChange,
    required this.value,
    this.disabledColor,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
        color: enabled ? null : (disabledColor ?? theme.disabledColor));

    return InkWell2(
        borderRadius: BorderRadius.circular(16.0),
        splashColor: Colors.blue.withOpacity(0.2),
        highlightColor: Colors.blue.withOpacity(0.2),
        onTap: enabled
            ? () {
                onChange(!value);
              }
            : null,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: value,
                onChanged: enabled ? onChange : null,
                splashRadius: 0.0,
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
        ));
  }
}

class InkWell2 extends InkWell {
  const InkWell2({
    super.key,
    super.borderRadius,
    super.splashColor,
    super.highlightColor,
    super.onTap,
    super.child,
  });

  @override
  RectCallback? getRectCallback(RenderBox referenceBox) {
    return () =>
        const Offset(0.0, 0.0) & (referenceBox.size + const Offset(8.0, 0.0));
  }
}
