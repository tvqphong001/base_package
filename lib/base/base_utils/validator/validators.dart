import '../../../base_package.dart';

class Validators {
  /// Regex Email
  static final RegExp regexEmail = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  /// Regex Phone Number
  static final RegExp regexPhoneNumber = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static final RegExp number = RegExp(r'[0-9]');

  static checkMailFunction(String? value,{String? errorText, bool emptyCheck = false}) {
    if (value == null || value.isEmpty) {
      if(emptyCheck){
        return errorText??'Invalid Email';
      }else{
        return null;
      }
    } else {
      if (!regexEmail.hasMatch(value)) {
        return errorText??'Invalid Email';
      } else {
        return null;
      }
    }
  }

  static FormFieldValidator<String> emailValidator({String? errorText, bool emptyCheck = false}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??'Invalid Email';
        }else{
          return null;
        }
      } else {
        if (!regexEmail.hasMatch(value)) {
          return errorText??'Invalid Email';
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
          return errorText??'Invalid number';
        }else{
          return null;
        }
      } else {
        if (!number.hasMatch(value)) {
          return errorText??'Invalid number';
        } else {
          return null;
        }
      }
    };
  }

  static FormFieldValidator<T> validatorNull<T>({String? errorText}) {
    return (T? object) {
      if(object == null){
        return errorText??"This field can't empty";
      }else{
        return null;
      }
    };
  }

  static FormFieldValidator<String> nameValidator({String? errorText}) {
    return (String? text) {
      var value = text?.trim();
      if (value == null || value.isEmpty) {
        return errorText??'Invalid Name';
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> phoneNumberValidator({String? errorText,bool emptyCheck = false}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        if(emptyCheck){
          return errorText??'Invalid phone number';
        }else{
          return null;
        }

      } else {
        if (!regexPhoneNumber.hasMatch(value)) {
          return errorText??'Invalid phone number';
        } else {
          return null;
        }
      }
    };
  }

  static FormFieldValidator<String> emptyValidator({String? errorText}) {
    return (String? text) {
      var value = text?.trim();
      if (value == null || value.isEmpty) {
        return errorText??"This field can't empty";
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

        return errorText??'Invalid';
      }
    };
  }
}

