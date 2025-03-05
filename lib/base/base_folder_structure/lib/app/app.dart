/*
import 'package:digi_aqua2/routes/routes.dart';

import '../base/base_app.dart';
import '../config/config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Digi Aqua',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() async {
        configApp();
      }),
      getPages: routes(),
  builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
              boldText: false,
              alwaysUse24HourFormat: true,
              devicePixelRatio: 3.0,
            ),
            child: child ?? const SizedBox(),
          ),
        );
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: Routes.Splash.routeName,
    );
  }
}
*/
