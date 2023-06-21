import 'package:base_package/base/base.dart';

class SelectableController<Data> extends TextEditingController{
  SelectableController({this.valueData,String? text}){
    this.text = text??'';
  }
  Data? valueData;

  void setData({required Data? value,required String? text}){
    this.text = text??'';
    valueData = value;
  }
  set data(Data? value){
    valueData = value;
  }

  Data? get data{
    return valueData;
  }


}

// class SelectableController2<Data> extends TextEditingController{
//   SelectableController2({this.valueData,String? text}){
//     this.text = text??'';
//   }
//   Data? valueData;
//
//   void setData({required Data? value,required String? text}){
//     this.text = text??'';
//     valueData = value;
//   }
//   set data(Data? value){
//     valueData = value;
//   }
//
//   Data? get data{
//     return valueData;
//   }
//
//   @override
//   TextSpan buildTextSpan({required BuildContext context, TextStyle? style , required bool withComposing}) {
//     assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);
//     // If the composing range is out of range for the current text, ignore it to
//     // preserve the tree integrity, otherwise in release mode a RangeError will
//     // be thrown and this EditableText will be built with a broken subtree.
//     final bool composingRegionOutOfRange = !value.isComposingRangeValid || !withComposing;
//
//     if (composingRegionOutOfRange) {
//       return TextSpan(style: style, text: text);
//     }
//
//     final TextStyle composingStyle = style?.merge(const TextStyle(decoration: TextDecoration.underline))
//         ?? const TextStyle(decoration: TextDecoration.underline);
//     // return TextSpan(
//     //   style: style,
//     //   children: <TextSpan>[
//     //     TextSpan(text: value.composing.textBefore(value.text)),
//     //     TextSpan(
//     //       style: composingStyle,
//     //       text: value.composing.textInside(value.text),
//     //     ),
//     //     TextSpan(text: value.composing.textAfter(value.text)),
//     //     TextSpan(text: '/n 123123'),
//     //   ],
//     // );
//
//     return super;
//   }
// }