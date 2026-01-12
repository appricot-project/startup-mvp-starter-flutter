import 'package:startup_mvp_starter_flutter/utils/mask_text_input_formatter.dart';

class MaskTextInputFormatterConsts {
  static MaskTextInputFormatter phoneMaskFormatter() {
    return MaskTextInputFormatter(
      mask: '+7 (###) ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter phoneInfoMaskFormatter() {
    return MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter dateOfBirthMaskFormatter() {
    return MaskTextInputFormatter(
      mask: '##.##.####',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter cardMaskFormatter() {
    return MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }
}
