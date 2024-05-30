//
//
// import '../../../base.dart';
//
// class AppAlertDialog extends StatelessWidget {
//   final String title;
//   final VoidCallback? onPressedCancel;
//   final VoidCallback onPressed;
//   final String? cancelText;
//   final String? confirmText;
//   final Widget? content;
//   const AppAlertDialog({
//     Key? key,
//     required this.title,
//     this.onPressedCancel,
//     required this.onPressed,
//     this.cancelText,
//     this.confirmText,
//     this.content,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       titlePadding: const EdgeInsets.only(left: 30,top: 15,right: 0,bottom: 10),
//       contentPadding: EdgeInsets.zero,
//       title: Row(
//         children: <Widget>[
//           Expanded(
//             child: AppText(
//               text: title,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           Button(
//             onPressed: () {
//               pop();
//             },
//             child: Container(
//               color: Colors.transparent,
//               padding: const EdgeInsets.all(0),
//               child: const Icon(
//                 Icons.clear,
//                 color: ColorsApp.wiserink100,
//               ),
//             ),
//           ),
//         ],
//       ),
//       content: Container(
//         width: 400,
//         padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (content != null) content!,
//             Row(
//               children: [
//                 Expanded(
//                     child: AppButton.secondary(
//                   onPressed: () {
//                     if (onPressedCancel != null) {
//                       onPressedCancel?.call();
//                     } else {
//                       pop();
//                     }
//                   },
//                   titleButton: cancelText??language.cancel,
//                 )),
//                 const SizedBox(width: 10,),
//                 Expanded(
//                     child: AppButton(
//                   onPressed: onPressed,
//                   titleButton: confirmText ?? language.confirm,
//                 ))
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
