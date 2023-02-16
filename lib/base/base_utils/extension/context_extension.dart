import 'package:flutter/cupertino.dart';

extension ContextEx on BuildContext{
  dynamic get arguments => ModalRoute.of(this)?.settings.arguments;
}