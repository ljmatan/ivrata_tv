import 'package:flutter/material.dart';
import 'package:ivrata_tv/data/user_data.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';
import 'package:ivrata_tv/ui/bloc/main_view_controller.dart';
import 'package:ivrata_tv/ui/elemets/user_agreement.dart';
import 'package:ivrata_tv/ui/screens/feed/feed_screen.dart';
import 'package:ivrata_tv/ui/screens/welcome/welcome_screen.dart';

class MainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    MainViewController.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Prefs.instance.getBool('eulaAccepted') == null)
        showDialog(context: context, builder: (context) => AgreementDialog());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: MainViewController.stream,
        initialData: User.loggedIn ? FeedScreen() : WelcomeScreen(),
        builder: (context, body) => Stack(
          children: [
            Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            body.data,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    MainViewController.dispose();
    super.dispose();
  }
}
