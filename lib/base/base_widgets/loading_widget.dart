import 'dart:ui';
import '../base.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: UiUtils.loading(context: context),
    );
  }
}

bool isLoading = false;

void showLoading() {
  if (isLoading) return;
  isLoading = true;
  showDialog(
      context: currentContext,
      barrierColor: Colors.grey.withOpacity(0.6),
      builder: (context) {
        return const Loading2();
      });
}

void hideLoading() {
  if (isLoading) {
    isLoading = false;

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
