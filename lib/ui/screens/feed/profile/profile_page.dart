import 'package:flutter/material.dart';
import 'package:ivrata_tv/data/user_data.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/logic/api/videos.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';
import 'package:ivrata_tv/logic/storage/local.dart';
import 'package:ivrata_tv/ui/bloc/main_view_controller.dart';
import 'package:ivrata_tv/ui/screens/saved/saved_videos_screen.dart';
import 'package:ivrata_tv/ui/screens/user_auth/login/login_display.dart';
import 'package:ivrata_tv/ui/screens/user_auth/register/register_display.dart';
import 'package:ivrata_tv/ui/screens/welcome/welcome_screen.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';
import 'package:ivrata_tv/ui/shared/video_entry_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  static int _currentPage = 1;

  static final Future<VideosResponse> _getChannelVideos =
      VideosAPI.getChannelVideos(User.instance.channelName, _currentPage);

  final _loginButtonFocusNode = FocusNode();
  final _registerButtonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return !User.loggedIn
        ? Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FocusableButton(
                  inverted: true,
                  focusNode: _loginButtonFocusNode,
                  width: MediaQuery.of(context).size.width / 4,
                  height: 64,
                  label: 'LOGIN',
                  autofocus: true,
                  onTap: () async {
                    final success = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginDisplay()));
                    if (success) setState(() {});
                    _loginButtonFocusNode.requestFocus();
                  },
                  focusColor: Colors.transparent,
                ),
                const SizedBox(width: 16),
                FocusableButton(
                  inverted: true,
                  focusNode: _registerButtonFocusNode,
                  width: MediaQuery.of(context).size.width / 4,
                  height: 64,
                  label: 'REGISTER',
                  onTap: () async {
                    final success = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterDisplay()));
                    if (!success) _loginButtonFocusNode.requestFocus();
                  },
                  focusColor: Colors.transparent,
                ),
              ],
            ),
          )
        : ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      User.instance.name,
                      style: const TextStyle(fontSize: 28),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FocusableButton(
                            width: 120,
                            height: 36,
                            label: 'Favorites',
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SavedVideosScreen())),
                            borderRadius: 18,
                          ),
                        ),
                        FocusableButton(
                          width: 120,
                          height: 36,
                          label: 'Logout',
                          onTap: () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: Theme.of(context).primaryColor,
                                builder: (context) =>
                                    Center(child: CircularProgressIndicator()));
                            await DB.instance.delete('Saved');
                            for (var key in Prefs.instance.getKeys())
                              await Prefs.instance.remove(key);
                            User.setInstance(null);
                            Navigator.pop(context);
                            MainViewController.change(WelcomeScreen());
                          },
                          borderRadius: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: _getChannelVideos,
                builder: (context, AsyncSnapshot<VideosResponse> videos) =>
                    videos.connectionState != ConnectionState.done ||
                            videos.hasError ||
                            videos.hasData && videos.data.error != false ||
                            videos.hasData && videos.data.response.rows.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                                videos.connectionState != ConnectionState.done
                                    ? 'Loading...'
                                    : videos.hasError
                                        ? videos.error.toString()
                                        : videos.hasData &&
                                                videos.data.error != false
                                            ? videos.data.error
                                            : 'No videos found'),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 16 / 10,
                            ),
                            itemCount: videos.data.response.rows.length,
                            itemBuilder: (context, i) => VideoEntryButton(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              video: videos.data.response.rows[i],
                              padding: EdgeInsets.fromLTRB(
                                i % 4 == 0 ? 12 : 6,
                                6,
                                (i + 1) % 4 == 0 ? 12 : 6,
                                6,
                              ),
                            ),
                          ),
              ),
            ],
          );
  }

  @override
  void dispose() {
    _loginButtonFocusNode.dispose();
    _registerButtonFocusNode.dispose();
    super.dispose();
  }
}
