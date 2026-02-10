import 'package:flutter/material.dart';

enum ButtonSize { small, large }

enum ButtonColor { primary, secondary, tertiary }

class CustomButton extends StatefulWidget {
  final String text;
  final String? subtitle;
  final VoidCallback onPressed;
  final Color? tintColor;
  final ButtonSize size;
  final ButtonColor color;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isEnabled;
  final double? height;
  final TextAlign textAlign;
  final MainAxisAlignment mainAxisAlignment;

  const CustomButton({
    super.key,
    this.tintColor,
    required this.text,
    this.subtitle,
    required this.onPressed,
    this.size = ButtonSize.large,
    this.color = ButtonColor.primary,
    this.leftIcon,
    this.rightIcon,
    this.isEnabled = true,
    this.height,
    this.textAlign = TextAlign.center,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
        height: _getHeight(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _getColor(),
            borderRadius: BorderRadius.circular(8),
            border: _getBorder(),
          ),
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.leftIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: widget.leftIcon!,
                  ),
                ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.text,
                        overflow: TextOverflow.ellipsis,
                        textAlign: widget.textAlign,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: widget.tintColor ?? _getFontColor(),
                        ),
                      ),
                      if (widget.subtitle?.isNotEmpty ?? false)
                        Text(
                          widget.subtitle!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary,
                                height: 1,
                              ),
                        ),
                    ],
                  ),
                ),
              ),
              if (widget.rightIcon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: widget.rightIcon!,
                  ),
                ),
            ],
          ),
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

  double? _getHeight() {
    if (widget.height != null) {
      return widget.height;
    }
    switch (widget.size) {
      case ButtonSize.small:
        return 36.0;
      case ButtonSize.large:
        return 44.0;
    }
  }

  Color _getFontColor() {
    if (!widget.isEnabled) {
      return widget.color == ButtonColor.tertiary
          ? Theme.of(context).disabledColor
          : Theme.of(context).scaffoldBackgroundColor;
    }
    switch (widget.color) {
      case ButtonColor.primary:
        return Theme.of(context).colorScheme.onPrimary;
      case ButtonColor.secondary:
        return Theme.of(context).colorScheme.onPrimary;
      case ButtonColor.tertiary:
        return isPressed
            ? Theme.of(context).focusColor
            : Theme.of(context).colorScheme.secondary;
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
