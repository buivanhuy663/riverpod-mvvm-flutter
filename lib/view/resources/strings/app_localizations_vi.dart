// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get hello => 'Xin chào!';

  @override
  String greeting(Object name) {
    return 'Chào $name!';
  }

  @override
  String get welcome => 'Chào mừng đến với ứng dụng của chúng tôi!';

  @override
  String get cancel_button_dialog => 'HỦY BỎ';

  @override
  String get ok_button_dialog => 'OK';

  @override
  String get login_button => 'Đăng nhập';

  @override
  String get email => 'Email';

  @override
  String get enter_email => 'Nhập địa chỉ email của bạn';

  @override
  String get email_required => 'Email là bắt buộc.';

  @override
  String get email_invalid => 'Vui lòng nhập địa chỉ email hợp lệ.';

  @override
  String get password => 'Mật khẩu';

  @override
  String get enter_password => 'Nhập mật khẩu của bạn';

  @override
  String get password_required => 'Mật khẩu là bắt buộc.';

  @override
  String get password_invalid => 'Vui lòng nhập mật khẩu hợp lệ.';

  @override
  String get network_error => 'Lỗi mạng. Vui lòng kiểm tra kết nối của bạn và thử lại.';

  @override
  String get server_error => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get timeout_error => 'Yêu cầu đã hết thời gian chờ. Vui lòng thử lại sau.';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get language_english => 'Tiếng Anh';

  @override
  String get language_vietnam => 'Tiếng Việt';

  @override
  String get theme_mode => 'Giao diện';

  @override
  String get dark_mode => 'Tối';

  @override
  String get light_mode => 'Sáng';

  @override
  String get unknown_error => 'Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.';
}
