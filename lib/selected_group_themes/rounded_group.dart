import 'package:flutter/material.dart';

///
/// https://docs.flutter.dev/release/breaking-changes/buttons
///
///
///

class SelectedButton<T> extends StatelessWidget {
  final String text;
  final ValueChanged<T> onChange;
  final T value;
  final T groupValue;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final Color? disabledColor;
  final bool enabled;
  final OutlinedBorder outlinedBorder;

  const SelectedButton(
      {Key? key,
      required this.text,
      required this.onChange,
      required this.value,
      required this.groupValue,
      this.primaryColor,
      this.onPrimaryColor,
      this.disabledColor,
      this.outlinedBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      required this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;
    final theme = Theme.of(context);

    final primaryColor = this.primaryColor ?? theme.colorScheme.primary;
    final onPrimaryColor =
        this.onPrimaryColor ?? theme.colorScheme.onPrimaryContainer;

    final disabledColor = this.disabledColor ?? theme.disabledColor;

    final backgroundColor = (selected && enabled) ? primaryColor : null;

    final textColor =
        enabled ? (selected ? onPrimaryColor : primaryColor) : disabledColor;

    return Padding(
      padding: EdgeInsets.zero,
      child: OutlinedButton(
        style: ButtonStyle(
          visualDensity: const VisualDensity(horizontal: 1, vertical: 1),
          // padding: MaterialStateProperty.all<EdgeInsets>(
          //     const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0)),

          minimumSize: MaterialStateProperty.all<Size>(const Size(42.0, 42.0)),
          shape: MaterialStateProperty.all<OutlinedBorder>(outlinedBorder),
          backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
            final Color color = enabled
                ? (states.contains(MaterialState.pressed)
                    ? primaryColor
                    : primaryColor)
                : disabledColor;

            return BorderSide(color: color, width: 1.0);
          }),
        ),
        onPressed: enabled ? () => onChange(value) : null,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );

    // final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    //   foregroundColor: selected ? primaryColorSelected : primaryColor,
    //   backgroundColor: selected ? backgroundColorSelected : backgroundColor,
    //   minimumSize: const Size(88.0, 52.0),
    //   padding: padding,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(24.0)),
    //   ),
    // );

    // return TextButton(
    //   style: flatButtonStyle,
    //   onPressed: () => onChange(value),
    //   child: Text(text),
    // );
  }
}
