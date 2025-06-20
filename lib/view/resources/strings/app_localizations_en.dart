// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello!';

  @override
  String greeting(Object name) {
    return 'Hi $name!';
  }

  @override
  String get welcome => 'Welcome to our app!';

  @override
  String get cancel_button_dialog => 'CANCEL';

  @override
  String get ok_button_dialog => 'OK';

  @override
  String get login_button => 'Login';

  @override
  String get email => 'Email';

  @override
  String get enter_email => 'Enter your email address';

  @override
  String get email_required => 'Email is required.';

  @override
  String get email_invalid => 'Please enter a valid email address.';

  @override
  String get password => 'Password';

  @override
  String get enter_password => 'Enter your password';

  @override
  String get password_required => 'Password is required.';

  @override
  String get password_invalid => 'Please enter a valid password.';

  @override
  String get network_error => 'Network error. Please check your connection and try again.';

  @override
  String get server_error => 'Server error. Please try again later.';

  @override
  String get timeout_error => 'Request timed out. Please try again later.';

  @override
  String get language => 'Language';

  @override
  String get language_english => 'English';

  @override
  String get language_vietnam => 'Vietnamese';

  @override
  String get theme_mode => 'Theme mode';

  @override
  String get dark_mode => 'Dark';

  @override
  String get light_mode => 'Light';

  @override
  String get unknown_error => 'An unknown error occurred. Please try again later.';
}
