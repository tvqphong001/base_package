import 'dart:ui';
import '../../base.dart';


bool isLoading = false;

void showLoading([BuildContext? context]) {
  if (isLoading) return;
  isLoading = true;
  showDialog(
      context: context??currentContext,
      barrierColor: Colors.grey.withOpacity(0.6),
      builder: (context) {
        return const Loading2();
      });
}

void hideLoading([BuildContext? context]) {
  if (isLoading) {
    isLoading = false;
    pop(context);
  }
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}

class Loading2 extends StatelessWidget {
  const Loading2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: LoadingWidget(),
      ),
    );
  }
}
