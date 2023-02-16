

import '../../base.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('No data');
    // return Center(child: SvgPicture.asset(Images.icNoDataFound));
  }
}
