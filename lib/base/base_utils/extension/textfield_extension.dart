import 'package:base_package/base/base.dart';

extension TextEditingControllerEx on TextEditingController{
  void setTextAndSelectionEnd(String text){
    this.text = text;
    selection = TextSelection.fromPosition(TextPosition(offset: this.text.length));
  }

  void selectionEnd(){
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}