import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/mask_text_input_formatter_consts.dart';
import 'package:startup_mvp_starter_flutter/utils/mask_text_input_formatter.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    required this.controller,
    this.error,
    this.label,
    this.hintText,
    required this.onChanged,
    this.errorHintText,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.textCapitalization,
    this.onEditingComplete,
    this.onStartEditing,
    this.isEnable = true,
    this.leftIcon,
    this.rightIcon,
    this.isClearable = false,
  });
  final TextEditingController controller;
  final String? error;
  final ValueChanged<String> onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onStartEditing;
  final String? label;
  final String? hintText;
  final String? errorHintText;
  final bool obscureText;
  final String obscuringCharacter;
  final TextCapitalization? textCapitalization;
  final bool isEnable;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isClearable;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  late FocusNode myFocusNode;
  MaskTextInputFormatter phoneMaskFormatter =
      MaskTextInputFormatterConsts.phoneInfoMaskFormatter();

  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode.addListener(_handleFocusChanged);
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.removeListener(_handleFocusChanged);
    myFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BasicTextField(
      key: widget.key,
      controller: widget.controller,
      error: widget.error,
      label: widget.label,
      hintText: widget.hintText,
      onChanged: (value) {
        widget.onChanged.call(phoneMaskFormatter.unmaskText(value));
      },
      errorHintText: widget.errorHintText,
      inputFormatters: [phoneMaskFormatter],
      keyboardType: TextInputType.phone,
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      onEditingComplete: widget.onEditingComplete,
      onStartEditing: widget.onStartEditing,
      isEnabled: widget.isEnable,
      leftIcon: widget.leftIcon,
      rightIcon: widget.rightIcon,
      isClearable: widget.isClearable,
    );
  }
}
