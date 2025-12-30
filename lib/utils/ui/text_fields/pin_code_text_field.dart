import 'package:flutter/material.dart';

class PinCodeTextField extends StatefulWidget {
  final TextEditingController? controller;
  final int length;
  final MainAxisAlignment mainAxisAlignment;
  // final String? error;
  // final FocusNode? focusNode;
  // final ValueChanged<String> onChanged;
  // final VoidCallback? onEditingComplete;
  // final VoidCallback? onStartEditing;
  // final bool expands;
  // final bool obscureText;
  // final String obscuringCharacter;
  // final TextCapitalization? textCapitalization;
  // final bool isEnabled;
  // final double height;
  // final double borderRadius;
  // final Color? backgroundColor;
  // final void Function(bool hasFocus)? onFocusChanged;

  const PinCodeTextField({
    super.key,
    this.controller,
    required this.length,
    this.mainAxisAlignment = MainAxisAlignment.center,
    // this.borderRadius = 12,
    // this.error,
    // this.height = 44,
    // this.expands = false,
    // this.focusNode,
    // required this.onChanged,
    // this.obscureText = false,
    // this.obscuringCharacter = '•',
    // this.textCapitalization,
    // this.onEditingComplete,
    // this.onStartEditing,
    // this.isEnabled = true,
    // this.backgroundColor,
    // this.onFocusChanged,
  });

  @override
  State<PinCodeTextField> createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
  }

  // Color _color() {
  //   if (!widget.isEnabled) {
  //     return ColorConstants.disable;
  //   }
  //   if (!(widget.error == null || widget.error == '')) {
  //     return ColorConstants.error;
  //   } else {
  //     if (myFocusNode.hasFocus) {
  //       return ColorConstants.activeTextField;
  //     } else {
  //       return ColorConstants.secondary;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: List<Widget>.generate(widget.length, (index) {
        return pinCell();
      }),
    );
  }

  Widget pinCell() {
    return Container(height: 40, width: 40, color: Colors.red);
  }
}
