import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/mask_text_input_formatter_consts.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/platform_components.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? error;
  final void Function(String value) onChanged;

  const DateTextField({
    super.key,
    required this.controller,
    this.error,
    required this.onChanged,
  });

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final TextInputFormatter _formatter =
      MaskTextInputFormatterConsts.dateOfBirthMaskFormatter();

  showCustomDatePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: SizedBox(
            height: 360,
            width: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                child: SfDateRangePicker(
                  headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  todayHighlightColor: Theme.of(context).primaryColor,
                  selectionColor: Theme.of(context).primaryColor,
                  selectionTextStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  showActionButtons: true,
                  toggleDaySelection: true,
                  minDate: DateTime(1950),
                  maxDate: DateTime(2050),
                  onSubmit: (value) {
                    if (value is DateTime) {
                      final valueString = DateFormat(
                        'dd.MM.yyyy',
                      ).format(value);
                      final newValue = TextEditingValue(text: valueString);
                      widget.controller.value = _formatter.formatEditUpdate(
                        TextEditingValue.empty,
                        newValue,
                      );
                      widget.onChanged(valueString);
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicTextField(
      label: AppLocalizations.of(context)!.profileBirthdayLabel,
      hintText: '',
      inputFormatters: [_formatter],
      keyboardType: TextInputType.number,
      rightIcon: PlatformComponents.calendarIcon(),
      controller: widget.controller,
      error: widget.error,
      onRightIconTap: () => showCustomDatePicker(),
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }
}
