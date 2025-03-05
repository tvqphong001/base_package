import 'package:base_package/base/base.dart';

Future delay({Duration duration = defaultDuration, VoidCallback? callBack}){
  return Future.delayed(duration,callBack);
}