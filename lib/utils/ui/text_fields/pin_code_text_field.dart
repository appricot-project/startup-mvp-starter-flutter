import 'package:flutter/material.dart';

class PinCodeTextField extends StatefulWidget {
  final TextEditingController? controller;
  final int length;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBetween;
  final double height;
  final double width;
  final TextStyle? textStyle;
  final Function(String) onChangedValue;
  final Decoration? decoration;

  const PinCodeTextField({
    super.key,
    this.controller,
    required this.length,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBetween = 16,
    this.height = 44,
    this.width = 44,
    this.textStyle,
    required this.onChangedValue,
    this.decoration,
  });

  @override
  State<PinCodeTextField> createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _requestFocus() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0,
          child: SizedBox(
            height: widget.height,
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: widget.length,
              autofocus: true,
              onChanged: (value) {
                widget.onChangedValue.call(value);
                setState(() {});
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: List<Widget>.generate(widget.length, (index) {
            return GestureDetector(
              child: _pinCell(index),
              onTap: _requestFocus,
            );
          }),
        ),
      ],
    );
  }

  Widget _pinCell(int index) {
    final text = _controller.text;
    final char = index < text.length ? text[index] : '';

    return Container(
      height: widget.height,
      width: widget.width,
      margin: EdgeInsets.symmetric(horizontal: widget.spaceBetween / 2),
      decoration:
          widget.decoration ??
          BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
      alignment: Alignment.center,
      child: Text(
        char,
        style:
            widget.textStyle ??
            Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      ),
    );
  }
}
