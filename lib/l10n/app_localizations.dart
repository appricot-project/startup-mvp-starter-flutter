import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @authSignin.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignin;

  /// No description provided for @authLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get authLogout;

  /// No description provided for @authUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get authUsername;

  /// No description provided for @authEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get authEnterEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authRepeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get authRepeatPassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get authResetPassword;

  /// No description provided for @authGetCode.
  ///
  /// In en, this message translates to:
  /// **'Get code'**
  String get authGetCode;

  /// No description provided for @authGetNewCode.
  ///
  /// In en, this message translates to:
  /// **'Get new code'**
  String get authGetNewCode;

  /// No description provided for @authAfterThrough.
  ///
  /// In en, this message translates to:
  /// **'through'**
  String get authAfterThrough;

  /// No description provided for @authCodeError.
  ///
  /// In en, this message translates to:
  /// **'Error code'**
  String get authCodeError;

  /// No description provided for @authVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter code from mail'**
  String get authVerificationTitle;

  /// No description provided for @profileSignIn.
  ///
  /// In en, this message translates to:
  /// **'Login to your profile'**
  String get profileSignIn;

  /// No description provided for @profileLoginSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully logged in'**
  String get profileLoginSuccess;

  /// No description provided for @profileLogoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get profileLogoutConfirm;

  /// No description provided for @profileEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmailLabel;

  /// No description provided for @profileNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileNameLabel;

  /// No description provided for @profilePersonalData.
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get profilePersonalData;

  /// No description provided for @profilePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get profilePhoneNumber;

  /// No description provided for @profileBirthdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get profileBirthdayLabel;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonAgree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get commonAgree;

  /// No description provided for @commonDisagree.
  ///
  /// In en, this message translates to:
  /// **'Disagree'**
  String get commonDisagree;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get commonOpen;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get commonFinish;

  /// No description provided for @commonApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get commonApply;

  /// No description provided for @commonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get commonReset;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @commonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get commonCopy;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get commonSelect;

  /// No description provided for @navigationHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHome;

  /// No description provided for @navigationProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navigationProfile;

  /// No description provided for @navigationSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navigationSettings;

  /// No description provided for @navigationFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navigationFavorite;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsChangeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get settingsChangeLanguage;

  /// No description provided for @settingsChangeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get settingsChangeTheme;

  /// No description provided for @settingsDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get settingsDarkTheme;

  /// No description provided for @settingsLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get settingsLightTheme;

  /// No description provided for @settingsSystemTheme.
  ///
  /// In en, this message translates to:
  /// **'System theme'**
  String get settingsSystemTheme;

  /// No description provided for @settingsRuLanguage.
  ///
  /// In en, this message translates to:
  /// **'Russion'**
  String get settingsRuLanguage;

  /// No description provided for @settingsEnLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsEnLanguage;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurity;

  /// No description provided for @statusLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get statusLoading;

  /// No description provided for @statusSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get statusSuccess;

  /// No description provided for @statusError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get statusError;

  /// No description provided for @errorsSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorsSomethingWentWrong;

  /// No description provided for @errorsNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get errorsNetworkError;

  /// No description provided for @errorsNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorsNoInternet;

  /// No description provided for @errorsRequiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get errorsRequiredField;

  /// No description provided for @errorsInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid mail format'**
  String get errorsInvalidEmail;

  /// No description provided for @errorsPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password is too short'**
  String get errorsPasswordTooShort;

  /// No description provided for @errorBirthdayCuttent.
  ///
  /// In en, this message translates to:
  /// **'Date of birth cannot be the current date'**
  String get errorBirthdayCuttent;

  /// No description provided for @errorBirthdayGreater.
  ///
  /// In en, this message translates to:
  /// **'Date of birth cannot be greater than the current date.'**
  String get errorBirthdayGreater;

  /// No description provided for @errorsTryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Please try again later'**
  String get errorsTryAgainLater;

  /// No description provided for @actionsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionsRetry;

  /// No description provided for @actionsSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get actionsSearch;

  /// No description provided for @dialogsAreYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get dialogsAreYouSure;

  /// No description provided for @emptyNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get emptyNoData;

  /// No description provided for @emptyEmptyList.
  ///
  /// In en, this message translates to:
  /// **'Empty list'**
  String get emptyEmptyList;

  /// No description provided for @emptyNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get emptyNoResults;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
