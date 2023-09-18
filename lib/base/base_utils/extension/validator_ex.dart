import 'package:base_package/base/base.dart';

extension GlobalKeyFormStateEx on GlobalKey<FormState>{
  bool validate(){
    return currentState?.validate()??false;
  }
}