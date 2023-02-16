class RegexUtils{
  RegexUtils._();
  /// Regex Email
   static RegExp get regexEmail => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Regex Phone Number
   static RegExp get  regexPhoneNumber => RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  /// Regex Passcode
   static RegExp get  regexPasscode => RegExp(r'^([0-9])\1*$');

  /// Regex Change Password
   static RegExp get  regexSpecialCharacter => RegExp(r'[!@#$&*]+');
   static RegExp get  regexUppercase => RegExp(r'[A-Z]');
   static RegExp get  regexLowercase => RegExp(r'[a-z]');
   static RegExp get  regexNumber => RegExp(r'[0-9]');
}