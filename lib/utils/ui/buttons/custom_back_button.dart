import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';

class CustomBackButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final ButtonColor color;
  final Widget? icon;
  final bool isEnabled;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.icon,
    this.color = ButtonColor.primary,
    this.isEnabled = true,
  });

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  bool isPressed = false;

  _back() {
    if (widget.onPressed == null) {
      Navigator.of(context).pop();
    } else {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTapDown: (_) {
            if (widget.isEnabled) {
              setState(() {
                isPressed = true;
              });
            }
          },
          onTapUp: (_) {
            if (widget.isEnabled) {
              setState(() {
                isPressed = false;
              });
              _back();
            }
          },
          onTapCancel: () {
            if (widget.isEnabled) {
              setState(() {
                isPressed = false;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: _getBorder(),
            ),
            margin: EdgeInsets.only(left: 8, top: 16),
            padding: EdgeInsets.all(4),
            child: Row(
              children: [
                widget.icon ??
                    Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    ),
                4.w,
                Text(
                  AppLocalizations.of(context)!.commonBack,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                4.w,
              ],
            ),
          ),
        ),
      ],
    );
  }

  BoxBorder? _getBorder() {
    if (!widget.isEnabled) {
      return null;
    }
    switch (widget.color) {
      case ButtonColor.primary:
        return Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        );
      case ButtonColor.secondary:
        return Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        );
      case ButtonColor.tertiary:
        return null;
    }
  }
}
