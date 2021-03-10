import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivrata_tv/logic/storage/local.dart';
import 'logic/cache/prefs.dart';
import 'ui/main_view.dart';

void main() async {
  // Required by the framework
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();

  await DB.init();

  runApp(TVDisplay());
}

class TVDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Rubik',
            brightness: Brightness.dark,
            primaryColor: const Color(0xffadd8e6),
            accentColor: const Color(0xffadd8e6),
            focusColor: Colors.transparent,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.white,
              selectionColor: Colors.white,
              selectionHandleColor: Colors.white,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            appBarTheme: const AppBarTheme(
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          home: MainView(),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
