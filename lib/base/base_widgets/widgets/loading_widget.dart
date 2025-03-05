import 'dart:async';
import '../../base.dart';


bool isLoading = false;

Widget? loadingWidgetGlobal;

final List<Completer> listCompleter = [];

void showLoading({BuildContext? context,Completer? completer}) {

  if(completer != null){
    listCompleter.add(completer);
  }
  if (isLoading) return;
  isLoading = true;
  showDialog(
      context: context??currentContext,
      barrierColor: Colors.grey.withOpacity(0.6),
      builder: (context) {
        return const Loading2();
      });
}

void hideLoading({BuildContext? context, Completer? completer}) {
  var isComplete = false;

  if(completer != null){
    if(!completer.isCompleted){
      completer.complete();
    }
    final listNotComplete = listCompleter.where((element) => element.isCompleted == false,).toList();
    if(listNotComplete.isEmpty){
      isComplete = true;

      listCompleter.clear();
    }

  }else{
    isComplete = true;
  }

  if (isLoading && isComplete) {
    isLoading = false;
    pop(context);
  }
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return loadingWidgetGlobal ?? const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
        // valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}

class Loading2 extends StatelessWidget {
  const Loading2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: loadingWidgetGlobal??LoadingWidget(),
      ),
    );
  }
}
