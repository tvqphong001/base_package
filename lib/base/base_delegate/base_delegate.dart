import '../base.dart';

BaseLocalizations get baseLocalizations => BaseLocalizations.of(currentContext);

BaseLocalizations get baseLanguage => BaseLocalizations.of(currentContext);

class BaseLocalizations {
  BaseLocalizations(this.locale);

  final Locale locale;

  static BaseLocalizations of(BuildContext context) {
    return Localizations.of<BaseLocalizations>(context, BaseLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'invalid_email': 'Invalid Email',
      'invalid_number': 'Invalid number',
      'invalid_currency': 'Invalid Currency',
      'empty_field': "This field can't empty",
      'invalid_name': 'Invalid Name',
      'invalid_phone_number': 'Invalid phone number',
      'invalid_password': 'Invalid password',
      'invalid': 'Invalid',

      'loadingText': 'Loading…',
      'canLoadingText': 'Release to load more',
      'idleLoadingText': 'Pull up Load more',

      'no_data' : 'No Data',
    },
    'vi': {
      'invalid_email': 'Email không hợp lệ',
      'invalid_number': 'Số không hợp lệ',
      'invalid_currency': 'Số tiền không hợp lệ',
      'empty_field': "Không thể để trống dòng này",
      'invalid_name': 'Tên không hợp lệ',
      'invalid_phone_number': 'Số điện thoại không hợp lệ',
      'invalid_password': 'Mật khẩu không hợp lệ',
      'invalid': 'Không hợp lệ',

      'loadingText': 'Đang tải…',
      'canLoadingText': 'Thả tay để tải thêm',
      'idleLoadingText': 'Kéo lên Tải thêm',

      'no_data': 'Không có dữ liệu',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  Map get languageMap => _localizedValues[locale.languageCode]!;

  String get invalid_email {
    return languageMap['invalid_email']!;
  }

  String get invalid_number {
    return languageMap['invalid_number']!;
  }

  String get invalid_currency {
    return languageMap['invalid_currency']!;
  }

  String get empty_field {
    return languageMap['empty_field']!;
  }

  String get invalid_name {
    return languageMap['invalid_name']!;
  }

  String get invalid_phone_number {
    return languageMap['invalid_phone_number']!;
  }

  String get invalid {
    return languageMap['invalid']!;
  }

  String get loadingText {
    return languageMap['loadingText']!;
  }

  String get canLoadingText {
    return languageMap['canLoadingText']!;
  }

  String get idleLoadingText {
    return languageMap['idleLoadingText']!;
  }

  String get no_data {
    return languageMap['no_data']!;
  }

  String get invalid_password {
    return languageMap['invalid_password']!;
  }
}

class BaseLocalizationsDelegate extends LocalizationsDelegate<BaseLocalizations> {
  const BaseLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => BaseLocalizations.languages().contains(locale.languageCode);

  @override
  Future<BaseLocalizations> load(Locale locale) {
    return SynchronousFuture<BaseLocalizations>(BaseLocalizations(locale));
  }

  @override
  bool shouldReload(BaseLocalizationsDelegate old) => false;
}
