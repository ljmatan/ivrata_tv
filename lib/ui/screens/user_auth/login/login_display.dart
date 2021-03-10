import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ivrata_tv/data/user_data.dart';
import 'package:ivrata_tv/logic/api/models/user_model.dart';
import 'package:ivrata_tv/logic/api/auth.dart';
import 'package:ivrata_tv/ui/shared/authenticating_dialog.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';

class LoginDisplay extends StatefulWidget {
  final Function authSuccess;

  LoginDisplay({this.authSuccess});

  @override
  State<StatefulWidget> createState() {
    return _LoginDisplayState();
  }
}

class _LoginDisplayState extends State<LoginDisplay> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _loginButtonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_3.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          autofocus: true,
                          focusNode: _usernameFocusNode,
                          controller: _usernameTextController,
                          decoration: InputDecoration(labelText: 'Username'),
                          onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          obscureText: true,
                          focusNode: _passwordFocusNode,
                          controller: _passwordTextController,
                          decoration: InputDecoration(labelText: 'Password'),
                          onSubmitted: (_) =>
                              _loginButtonFocusNode.requestFocus(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16,
                          bottom: 8,
                        ),
                        child: FocusableButton(
                          focusNode: _loginButtonFocusNode,
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          label: 'Login',
                          onTap: () async {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    Center(child: CircularProgressIndicator()));
                            try {
                              print('Sending login request');
                              final response = await Auth.login(
                                _usernameTextController.text,
                                _passwordTextController.text,
                              );
                              print('Request finished');
                              final decoded = jsonDecode(response.body);
                              if (decoded['id'] != false) {
                                print('Login successful');
                                final data = UserData.fromJson(decoded);
                                print('Saving user data');
                                await User.setInstance(data, true);
                                print('Saved user data');
                                Navigator.pop(context);
                                Navigator.pop(context, true);
                                if (widget.authSuccess != null)
                                  widget.authSuccess();
                              } else {
                                print('Login failed');
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => AuthenticatingDialog(
                                        label: decoded['error'] != null &&
                                                decoded['error'].runtimeType ==
                                                    String
                                            ? decoded['error']
                                            : 'Login unsuccessful. Please check your details.'));
                              }
                            } catch (e) {
                              print('Request failed');
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AuthenticatingDialog(label: '$e'));
                            }
                            if (mounted) _usernameFocusNode.requestFocus();
                          },
                        ),
                      ),
                    ],
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
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _loginButtonFocusNode.dispose();
    super.dispose();
  }
}
