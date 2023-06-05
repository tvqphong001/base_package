import 'package:base_package/base/base.dart';

Future<T?> showMenuWithOffset<T>({
  required BuildContext context,
  required Offset offset,
  required List<PopupMenuEntry<T>> items
}){
  return showMenu<T>(
      context: context,
      color: Colors.transparent,
      elevation: 0,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + 20,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: items);
}



