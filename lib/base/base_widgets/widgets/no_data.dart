

import '../../base.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: TextApp(baseLanguage.no_data,fontWeight: FontWeight.bold,));
  }
}
