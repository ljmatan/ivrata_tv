import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivrata_tv/data/user_data.dart';
import 'package:ivrata_tv/logic/api/models/user_model.dart';
import 'package:ivrata_tv/logic/api/auth.dart';
import 'package:ivrata_tv/ui/shared/authenticating_dialog.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';

class RegisterDisplay extends StatefulWidget {
  final Function authSuccess;

  RegisterDisplay({this.authSuccess});

  @override
  State<StatefulWidget> createState() {
    return _RegisterDisplayState();
  }
}

class _RegisterDisplayState extends State<RegisterDisplay> {
  final _nameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _registerButtonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_2.jpg',
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
                          focusNode: _nameFocusNode,
                          controller: _nameTextController,
                          decoration: InputDecoration(labelText: 'Your name'),
                          onSubmitted: (_) => _usernameFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          focusNode: _usernameFocusNode,
                          controller: _usernameTextController,
                          decoration: InputDecoration(labelText: 'Username'),
                          onSubmitted: (_) => _emailFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          focusNode: _emailFocusNode,
                          controller: _emailTextController,
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
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
                              _confirmPasswordFocusNode.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          obscureText: true,
                          focusNode: _confirmPasswordFocusNode,
                          controller: _confirmPasswordTextController,
                          decoration:
                              InputDecoration(labelText: 'Repeat Password'),
                          onSubmitted: (_) =>
                              _registerButtonFocusNode.requestFocus(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16,
                          bottom: widget.authSuccess != null ? 8 : 0,
                        ),
                        child: FocusableButton(
                          focusNode: _registerButtonFocusNode,
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          label: 'Register',
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailTextController.text) &&
                                _nameTextController.text.isNotEmpty &&
                                _usernameTextController.text.isNotEmpty &&
                                _passwordTextController.text.isNotEmpty &&
                                _confirmPasswordTextController
                                    .text.isNotEmpty &&
                                _emailTextController.text.isNotEmpty &&
                                _confirmPasswordTextController.text ==
                                    _passwordTextController.text) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => Center(
                                      child: CircularProgressIndicator()));
                              try {
                                final response = await Auth.register(
                                  _usernameTextController.text,
                                  _emailTextController.text,
                                  _passwordTextController.text,
                                  _nameTextController.text,
                                );
                                final decoded = jsonDecode(response.body);
                                if (decoded['error'] == null) {
                                  final int id = int.parse(decoded['status']);
                                  final userInfoResponse =
                                      await Auth.getUserInfo(id);
                                  final decodedUserInfo =
                                      jsonDecode(userInfoResponse.body);
                                  if (decodedUserInfo['error'] == true)
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'User created but couldn\'t fetch data. Please try logging in.')));
                                  else {
                                    print(userInfoResponse.body);
                                    final userData = UserData.fromJson(
                                        decodedUserInfo['response']['user']);
                                    await User.setInstance(userData, true);
                                    Navigator.pop(context);
                                    Navigator.pop(context, true);
                                    if (widget.authSuccess != null)
                                      widget.authSuccess();
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(decoded['error'])));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$e')));
                              }
                              if (mounted) _nameFocusNode.requestFocus();
                            } else {
                              final bool passwordsNoMatch =
                                  _confirmPasswordTextController.text !=
                                      _passwordTextController.text;
                              passwordsNoMatch
                                  ? _passwordFocusNode.requestFocus()
                                  : _nameFocusNode.requestFocus();
                              await showDialog(
                                  context: context,
                                  builder: (context) => AuthenticatingDialog(
                                      label: passwordsNoMatch
                                          ? 'Passwords don\'t match'
                                          : 'All fields must be submitted for registration'));
                              _usernameFocusNode.requestFocus();
                            }
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
    _nameTextController.dispose();
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _nameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _registerButtonFocusNode.dispose();
    super.dispose();
  }
}
