import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'strings/app_localizations.dart';
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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('vi')];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get hello;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}!'**
  String greeting(Object name);

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our app!'**
  String get welcome;

  /// No description provided for @cancel_button_dialog.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel_button_dialog;

  /// No description provided for @ok_button_dialog.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok_button_dialog;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enter_email;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get email_required;

  /// No description provided for @email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get email_invalid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_password;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get password_required;

  /// No description provided for @password_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid password.'**
  String get password_invalid;

  /// No description provided for @network_error.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection and try again.'**
  String get network_error;

  /// No description provided for @server_error.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get server_error;

  /// No description provided for @timeout_error.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again later.'**
  String get timeout_error;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_english;

  /// No description provided for @language_vietnam.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get language_vietnam;

  /// No description provided for @theme_mode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get theme_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark_mode;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light_mode;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again later.'**
  String get unknown_error;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
