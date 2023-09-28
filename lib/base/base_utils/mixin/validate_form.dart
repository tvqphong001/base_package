import 'package:base_package/base/base.dart';

mixin FormMixin {
  final keyForm = GlobalKey<FormState>();

  bool validate(){
    return keyForm.validate();
  }
}