class RegExpConsts {
  static RegExp email = RegExp(
    '[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}',
  );
  static RegExp latinAlphabet = RegExp(r'^[a-zA-Z\s]+$');
  static RegExp cyrillic = RegExp(r'^[а-яА-ЯёЁ]+$');
  static RegExp address = RegExp(r"^[а-яА-ЯёЁ0-9\s№.,()'-]+$");
  static RegExp baseText = RegExp(r'''^[а-яА-ЯёЁ0-9\s,\.\(\)\-\"\'\№\»/]+$''');
  static RegExp passportCodeIssue = RegExp(r"^\d{2}[0-3]-?\d{3}$");
}
