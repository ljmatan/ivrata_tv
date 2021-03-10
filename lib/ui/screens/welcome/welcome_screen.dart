import 'package:flutter/material.dart';
import 'package:ivrata_tv/ui/bloc/main_view_controller.dart';
import 'package:ivrata_tv/ui/screens/feed/feed_screen.dart';
import 'package:ivrata_tv/ui/screens/user_auth/login/login_display.dart';
import 'package:ivrata_tv/ui/screens/user_auth/register/register_display.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _hidden = false;

  final _animationDuration = const Duration(milliseconds: 800);

  final _loginButtonFocusNode = FocusNode();
  final _registerButtonFocusNode = FocusNode();
  final _guestButtonFocusNode = FocusNode();

  void _authSuccess() => MainViewController.change(FeedScreen());

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.ease,
      opacity: _hidden ? 0 : 1,
      duration: _animationDuration,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Welcome!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 64,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FocusableButton(
                    focusNode: _loginButtonFocusNode,
                    width: MediaQuery.of(context).size.width / 4,
                    height: 64,
                    label: 'LOGIN',
                    autofocus: true,
                    onTap: () async {
                      final success = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LoginDisplay(authSuccess: _authSuccess)));
                      if (!success) _loginButtonFocusNode.requestFocus();
                    },
                    focusColor: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FocusableButton(
                      focusNode: _registerButtonFocusNode,
                      width: MediaQuery.of(context).size.width / 4,
                      height: 64,
                      label: 'REGISTER',
                      onTap: () async {
                        final success = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegisterDisplay(
                                        authSuccess: _authSuccess)));
                        if (!success) _loginButtonFocusNode.requestFocus();
                      },
                      focusColor: Colors.transparent,
                    ),
                  ),
                  FocusableButton(
                    focusNode: _guestButtonFocusNode,
                    width: MediaQuery.of(context).size.width / 4,
                    height: 64,
                    label: 'GUEST',
                    onTap: () => MainViewController.change(FeedScreen()),
                    focusColor: Colors.transparent,
                  ),
                ],
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Image.asset(
                    'assets/images/ivrata_logo.png',
                    height: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginButtonFocusNode.dispose();
    _registerButtonFocusNode.dispose();
    _guestButtonFocusNode.dispose();
    super.dispose();
  }
}
