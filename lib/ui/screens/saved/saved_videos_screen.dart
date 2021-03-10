import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/logic/storage/local.dart';
import 'package:ivrata_tv/ui/shared/custom_appbar.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';
import 'package:ivrata_tv/ui/shared/video_entry_button.dart';

class SavedVideosScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavedVideosScreenState();
  }
}

class _SavedVideosScreenState extends State<SavedVideosScreen> {
  static final Future _getSavedVideos =
      DB.instance.rawQuery('SELECT * FROM Saved');

  final _scrollController = ScrollController();

  final _closeButtonFocusNode = FocusNode();
  final _goToTopButtonFocusNode = FocusNode();

  void _scrollTo(double offset) => _scrollController.animateTo(offset,
      duration: const Duration(milliseconds: 300), curve: Curves.ease);

  @override
  void initState() {
    super.initState();
    _closeButtonFocusNode.addListener(() {
      if (_closeButtonFocusNode.hasFocus) _scrollTo(0);
    });
    _goToTopButtonFocusNode.addListener(() {
      if (_goToTopButtonFocusNode.hasFocus)
        _scrollTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_4.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: ListView(
              shrinkWrap: true,
              controller: _scrollController,
              children: [
                CustomAppBar(
                  label: 'Saved Videos',
                  closeButtonFocusNode: _closeButtonFocusNode,
                ),
                FutureBuilder(
                  future: _getSavedVideos,
                  builder: (context, videos) => videos.connectionState !=
                              ConnectionState.done ||
                          videos.hasError ||
                          videos.hasData && videos.data.isEmpty
                      ? Center(
                          child: videos.connectionState == ConnectionState.done
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    videos.hasData && videos.data.isEmpty
                                        ? 'No saved videos'
                                        : videos.error.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                    ),
                                  ),
                                )
                              : CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 16 / 10,
                              ),
                              itemCount: videos.data.length,
                              itemBuilder: (context, i) => VideoEntryButton(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                video: VideoData.fromJson(jsonDecode(
                                    videos.data[i]['savedVideoEncoded'])),
                                padding: EdgeInsets.fromLTRB(
                                  (i + 1) % 3 == 0 ? 0 : 12,
                                  6,
                                  i % 3 == 0 ? 0 : 12,
                                  6,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (videos.data.length > 6)
                                    FocusableButton(
                                      focusNode: _goToTopButtonFocusNode,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height: 48,
                                      label: 'GO TO TOP',
                                      inverted: true,
                                      onTap: () {
                                        _scrollTo(0);
                                        _closeButtonFocusNode.requestFocus();
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _closeButtonFocusNode.dispose();
    _goToTopButtonFocusNode.dispose();
    super.dispose();
  }
}
