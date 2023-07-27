import 'package:base_package/base/base.dart';

Future<T?> showMenuWithOffset<T>({
  required BuildContext context,
  required Offset offset,
  required List<PopupMenuEntry<T>> items,
  Color? background,
  double? elevation,
  ShapeBorder? shape,
}){
  return showMenu<T>(
      context: context,
      color: background??Colors.transparent,
      elevation: elevation??0,
      shape: shape,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + 20,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: items);
}



