import '../../../base_package.dart';

class Validators {

  const Validators._();
  /// Regex Email
  static final RegExp regexEmail = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Regex Phone Number
  static final RegExp regexPhoneNumber = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static final RegExp number = RegExp(r'^\d+(?:\.\d+)?$');
  // static final RegExp numberMoney = RegExp(r'^\d+(?:,\d+)*(?:\.\d|\.\d\d)?$');
  static final RegExp numberMoney = RegExp(r'^\d+(?:,\d+)*(?:\.\d*)?$');
  static final regExpPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+])[A-Za-z0-9!@#$%^&*()_+]{8,}$');

  static checkMailFunction(String? value,{String? errorText, bool emptyCheck = false}) {
    if (value == null || value.isEmpty) {
      if(emptyCheck){
        return errorText??baseLocalizations.invalid_email;
      }else{
        return null;
      }
    } else {
      if (!regexEmail.hasMatch(value)) {
        return errorText??baseLocalizations.invalid_email;
      } else {
        return null;
      }
    }
  }

  static FormFieldValidator<String> emailValidator({String? errorText, bool emptyCheck = false}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??baseLocalizations.invalid_email;
        }else{
          return null;
        }
      } else {
        if (!regexEmail.hasMatch(value)) {
          return errorText??baseLocalizations.invalid_email;
        } else {
          return null;
        }
      }
    };
  }


  static FormFieldValidator<String> numberValidator({String? errorText, bool emptyCheck = false}) {
    return (String? value) {

      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??baseLocalizations.invalid_number;
        }else{
          return null;
        }
      } else{
        if (!number.hasMatch(value))
          return baseLocalizations.invalid_number;
        else
          return null;
      }
    };
  }

  static FormFieldValidator<String> numberWithCommaValidator({String? errorText, bool emptyCheck = false}) {
    return (String? value) {

      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??baseLocalizations.invalid_number;
        }else{
          return null;
        }
      } else{
        if (!numberMoney.hasMatch(value))
          return baseLocalizations.invalid_number;
        else
          return null;
      }
    };
  }

  static FormFieldValidator<String> numberMoneyValidator({String? errorText, bool emptyCheck = false}) {
    return (String? value) {

      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??baseLocalizations.invalid_currency;
        }else{
          return null;
        }
      } else{
        if (!numberMoney.hasMatch(value))
          return baseLocalizations.invalid_currency;
        else
          return null;
      }
    };
  }

  static FormFieldValidator<String> passwordValidator({String? errorText, bool emptyCheck = false, String? Function(String? value)? customValidate}) {
    return (String? value) {
      if(customValidate != null){
        return customValidate(value);
      }
      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??baseLocalizations.invalid_password;
        }else{
          return null;
        }
      } else{
        if (!regExpPassword.hasMatch(value))
          return baseLocalizations.invalid_password;
        else
          return null;
      }
    };
  }

  static FormFieldValidator<T> validatorNull<T>({String? errorText}) {
    return (T? object) {
      if(object == null){
        return errorText??baseLocalizations.empty_field;
      }else{
        return null;
      }
    };
  }

  static FormFieldValidator<String> nameValidator({String? errorText}) {
    return (String? text) {
      var value = text?.trim();
      if (value == null || value.isEmpty) {
        return errorText??baseLocalizations.invalid_name;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> phoneNumberValidator({String? errorText,bool emptyCheck = false}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??baseLocalizations.invalid_phone_number;
        }else{
          return null;
        }

      } else {
        if (!regexPhoneNumber.hasMatch(value)) {
          return errorText??baseLocalizations.invalid_phone_number;
        } else {
          return null;
        }
      }
    };
  }

  static bool hasMatchPhoneNumber(String value){
    if (!regexPhoneNumber.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  static FormFieldValidator<String> emptyValidator({String? errorText}) {
    return (String? text) {
      var value = text?.trim();
      if (value == null || value.isEmpty) {
        return errorText??baseLocalizations.empty_field;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> validatorPattern(RegExp regExp,{String? errorText}) {
    return (String? text) {
      var value = text?.trim();
      var match = regExp.hasMatch(value??'');
      if (match) {
        return null;
      } else {

        return errorText??baseLocalizations.invalid;
      }
    };
  }

  static FormFieldValidator<T>? validatorEmptySelect<T>({String? errorText}) {
    return (value) {
      if (value == null) {
        return errorText??baseLocalizations.empty_field;
      } else {
        return null;
      }
    };
  }
}

