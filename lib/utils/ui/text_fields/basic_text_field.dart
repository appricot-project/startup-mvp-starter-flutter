import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/platform_components.dart';

class BasicTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? error;
  final FocusNode? focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onStartEditing;
  final String? label;
  final String? hintText;
  final String? errorHintText;
  final bool expands;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final bool isEnabled;
  final double height;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isClearable;
  final double borderRadius;
  final VoidCallback? onLeftIconTap;
  final VoidCallback? onRightIconTap;
  final Color? backgroundColor;
  final Color? labelColor;
  final List<String>? suggestions;
  final void Function(int index)? onSuggestionSelected;
  final void Function(bool hasFocus)? onFocusChanged;

  const BasicTextField({
    super.key,
    this.controller,
    this.labelColor,
    this.borderRadius = 12,
    this.error,
    this.height = 44,
    this.expands = false,
    this.label,
    this.focusNode,
    required this.hintText,
    required this.onChanged,
    this.errorHintText,
    this.inputFormatters,
    this.keyboardType,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.textCapitalization,
    this.onEditingComplete,
    this.onStartEditing,
    this.maxLines,
    this.isEnabled = true,
    this.leftIcon,
    this.rightIcon,
    this.isClearable = false,
    this.onLeftIconTap,
    this.onRightIconTap,
    this.backgroundColor,
    this.suggestions,
    this.onSuggestionSelected,
    this.onFocusChanged,
  });

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  late FocusNode myFocusNode;
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();
  List<String> suggestions = [];

  @override
  void initState() {
    myFocusNode = widget.focusNode ?? FocusNode();
    myFocusNode.addListener(_handleFocusChanged);
    suggestions = widget.suggestions ?? [];
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BasicTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.suggestions != widget.suggestions) {
      setState(() {
        suggestions = widget.suggestions ?? [];
      });

      if (myFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _removeOverlay();
          _showOverlay();
        });
      }
    }
  }

  @override
  void dispose() {
    // myFocusNode.dispose();
    myFocusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  void _handleFocusChanged() {
    setState(() {});
    widget.onFocusChanged?.call(myFocusNode.hasFocus);

    if (myFocusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    if (overlayEntry != null || suggestions.isEmpty) return;

    overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 10),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.outline,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        String newValue = suggestions[index];
                        widget.controller?.text = newValue;
                        widget.onChanged.call(newValue);
                        widget.onSuggestionSelected?.call(index);
                        myFocusNode.unfocus();
                        _removeOverlay();
                      });
                    },
                    child: Text(
                      suggestions[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: suggestions[index] == widget.controller?.text
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: suggestions.length,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _color() {
    if (!widget.isEnabled) {
      return Theme.of(context).disabledColor;
    }
    if (!(widget.error == null || widget.error == '')) {
      return Theme.of(context).colorScheme.error;
    } else {
      if (myFocusNode.hasFocus) {
        return Theme.of(context).focusColor;
      } else {
        return Theme.of(context).colorScheme.secondary;
      }
    }
  }

  List<BoxShadow> _shadowBorder() {
    if (!widget.isEnabled) {
      return [];
    }
    if (!(widget.error == null || widget.error == '')) {
      return [
        BoxShadow(
          color: Theme.of(context).colorScheme.error,
          spreadRadius: 1,
          blurRadius: 0,
          offset: Offset(0, 0),
        ),
      ];
    } else {
      if (myFocusNode.hasFocus) {
        return [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            spreadRadius: 1,
            blurRadius: 0,
            offset: Offset(0, 0),
          ),
        ];
      } else {
        return [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  if (widget.isEnabled) {
                    if (widget.onStartEditing != null) {
                      widget.onStartEditing!();
                    }
                    myFocusNode.requestFocus();
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.label != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            widget.label ?? '',
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  color:
                                      widget.labelColor ??
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        height: widget.height,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: _color(), width: 1),
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                            color: widget.isEnabled
                                ? widget.backgroundColor ??
                                      Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).disabledColor,
                            boxShadow: _shadowBorder(),
                          ),
                          child: Row(
                            children: [
                              if (widget.leftIcon != null)
                                GestureDetector(
                                  onTap: () => widget.onLeftIconTap?.call(),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: widget.leftIcon,
                                  ),
                                ),
                              Expanded(
                                child: TextField(
                                  expands: widget.expands,
                                  textAlignVertical: widget.expands
                                      ? TextAlignVertical.top
                                      : TextAlignVertical.center,
                                  focusNode: myFocusNode,
                                  enabled: widget.isEnabled,
                                  controller: widget.controller,
                                  maxLines: widget.expands
                                      ? null
                                      : widget.obscureText
                                      ? 1
                                      : (widget.maxLines ?? 1),
                                  onTap: widget.onStartEditing,
                                  cursorColor: Theme.of(context).focusColor,
                                  keyboardType: widget.keyboardType,
                                  inputFormatters: widget.inputFormatters,
                                  textCapitalization:
                                      widget.textCapitalization ??
                                      TextCapitalization.none,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(
                                      widget.height < 44 ? 5 : 10,
                                    ),
                                    isDense: true,
                                    hintMaxLines: 1,
                                    border: InputBorder.none,
                                    hintText:
                                        widget.error != null &&
                                            widget.error != ''
                                        ? widget.errorHintText ??
                                              widget.hintText
                                        : widget.hintText,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  obscureText: widget.obscureText,
                                  obscuringCharacter: widget.obscuringCharacter,
                                  onChanged: (value) {
                                    if (widget.isEnabled) {
                                      widget.onChanged(value);
                                      setState(() {});
                                    }
                                  },
                                  onEditingComplete: () {
                                    if (widget.onEditingComplete != null &&
                                        myFocusNode.hasFocus) {
                                      widget.onEditingComplete!();
                                    }
                                    if (myFocusNode.hasFocus) {
                                      myFocusNode.unfocus();
                                    }
                                  },
                                  onTapOutside: (event) {
                                    if (overlayEntry == null ||
                                        suggestions.isEmpty) {
                                      if (widget.onEditingComplete != null &&
                                          (myFocusNode.hasFocus)) {
                                        widget.onEditingComplete!();
                                      }
                                      if (myFocusNode.hasFocus) {
                                        myFocusNode.unfocus();
                                      }
                                    }
                                  },
                                ),
                              ),
                              if (widget.isClearable)
                                Padding(
                                  padding: EdgeInsetsGeometry.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.controller?.clear();
                                      widget.onChanged.call('');
                                    },
                                    child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: PlatformComponents.clearIcon(),
                                    ),
                                  ),
                                ),
                              if (widget.rightIcon != null)
                                GestureDetector(
                                  onTap: () => widget.onRightIconTap?.call(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 2,
                                      right: 10,
                                    ),
                                    child: widget.rightIcon,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (widget.error != null && widget.error != '' && widget.isEnabled)
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                widget.error ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
