import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pppcalculator/view/screens/calculator/calculator.dart';
import 'constants.dart';

void main() => runApp(const PPPCalculator());

class PPPCalculator extends StatelessWidget {
  const PPPCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   builder: EasyLoading.init(),
    //   title: APP_TITLE,
    //   theme:
    //       ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
    //   debugShowCheckedModeBanner: false,
    //   routeInformationProvider:
    //       NyAppRouter.returnRouter(false).routeInformationProvider,
    //   routeInformationParser:
    //       NyAppRouter.returnRouter(false).routeInformationParser,
    //   routerDelegate: NyAppRouter.returnRouter(false).routerDelegate,
    // );

    return MaterialApp(
      builder: EasyLoading.init(),
      title: APP_TITLE,
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: const Calculator(),
    );
  }
}
