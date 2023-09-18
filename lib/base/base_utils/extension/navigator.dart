import '../../base.dart';
import '../../base.dart' as base;

extension NavigatorEx on BuildContext{
  void pushName(String routeName,{ dynamic arguments}){
    Navigator.pushNamed(this, routeName,arguments: arguments);
  }

  void pop([dynamic result]){
    Navigator.pop(this,result);
  }

  void popUntil(String routeName){
    Navigator.popUntil(this,ModalRoute.withName(routeName));
  }

  void pushReplacementNamed(String routeName,{ dynamic arguments}){
    Navigator.pushReplacementNamed(this, routeName,arguments: arguments);
  }
}

extension ExtensionBuildContext on BuildContext{
  hideKeyBoard(){
    base.hideKeyBoard(this);
  }
}