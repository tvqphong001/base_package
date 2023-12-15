import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base_package.dart';

typedef BlocWidgetProviderBuilder<B , S> = Widget Function(BuildContext context, B bloc,S state);

class BlocProviderBuilder<B extends StateStreamableSource<S>, S> extends StatelessWidget {
  final B Function(BuildContext context) create;
  final BlocWidgetProviderBuilder<B,S> builder;
  const BlocProviderBuilder({super.key, required this.create, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: create,
      child: BlocBuilder<B, S>(
        builder: (context, state) {
          var bloc = context.read<B>();
          return builder(context,bloc,state);
        },
      ),
    );
  }
}
