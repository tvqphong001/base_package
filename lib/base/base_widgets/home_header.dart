import 'package:mpos/base/base.dart';
import 'package:mpos/features/home/bloc/home_bloc.dart';
import 'package:mpos/features/home/enum/enum_home.dart';
import 'package:mpos/features/home/widgets/home_search_bar.dart';

class HomeHeader extends StatelessWidget {
  final String title;
  final Widget? trailingIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final VoidCallback? onTapSearchSale;

  const HomeHeader({
    super.key,
    required this.title,
    this.trailingIcon,
    required this.controller,
    this.suffixIcon,
    this.focusNode, this.onTapSearchSale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        return Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              height: homeState.data.eHome == EHome.sale
                  ? 180
                  : homeState.data.eHome != EHome.other
                      ? 140
                      : 110,
              width: UiUtils.maxWidth(context: context),
            ),
            Container(
              width: UiUtils.maxWidth(context: context),
              height: homeState.data.eHome == EHome.sale ? 150 : 110,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
                color: Colors.black,
              ),
              child: Align(
                alignment: homeState.data.eHome == EHome.sale
                    ? Alignment.topCenter
                    : homeState.data.eHome != EHome.other
                        ? Alignment.center
                        : Alignment.bottomCenter,
                child: Container(
                  margin: homeState.data.eHome == EHome.sale
                      ? EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15)
                      : homeState.data.eHome != EHome.other
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: homeState.data.eHome != EHome.other
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.end,
                    children: <Widget>[
                      AppText(
                        text: title,
                        fontWeight: FontWeight.bold,
                        textSize: 18,
                        color: Colors.white,
                      ),
                      trailingIcon == null
                          ? const SizedBox()
                          : Expanded(
                              child: trailingIcon!,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            HomeSearchBar(
              controller: controller,
              focusNode: focusNode,
              suffixIcon: suffixIcon,
              onTapSearchSale: onTapSearchSale,
            ),
          ],
        );
      },
    );
  }
}
