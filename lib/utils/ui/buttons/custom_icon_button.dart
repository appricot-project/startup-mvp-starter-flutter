import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';

class CustomIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ButtonColor color;
  final Widget icon;
  final bool isEnabled;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color = ButtonColor.primary,
    this.isEnabled = true,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          widget.onPressed();
        }
      },
      onTapCancel: () {
        if (widget.isEnabled) {
          setState(() {
            isPressed = false;
          });
        }
      },
      child: SizedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _getColor(),
            borderRadius: BorderRadius.circular(8),
            border: _getBorder(),
          ),
          child: Padding(padding: EdgeInsets.all(8), child: widget.icon),
        ),
      ),
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

  Color _getColor() {
    if (!widget.isEnabled && widget.color != ButtonColor.tertiary) {
      return Theme.of(context).disabledColor;
    }
    switch (widget.color) {
      case ButtonColor.primary:
        return isPressed
            ? Theme.of(context).focusColor
            : Theme.of(context).primaryColor;
      case ButtonColor.secondary:
        return isPressed
            ? Theme.of(context).focusColor
            : Theme.of(context).colorScheme.secondary;
      case ButtonColor.tertiary:
        return Colors.transparent;
    }
  }
}
