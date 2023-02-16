import '../../base.dart';

void pop([BuildContext? context,dynamic result]){
  Navigator.of(context??currentContext).pop(result);
}