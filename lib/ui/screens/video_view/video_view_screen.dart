import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';
import 'package:ivrata_tv/logic/storage/local.dart';
import 'package:ivrata_tv/ui/screens/channel_view/channel_view_screen.dart';
import 'package:ivrata_tv/ui/screens/video_view/bloc/buffering_controller.dart';
import 'package:ivrata_tv/ui/screens/video_view/player/player_screen.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';
import 'package:ivrata_tv/ui/shared/vlc/player_screen.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget {
  final VideoData video;

  VideoViewScreen({@required this.video});

  @override
  State<StatefulWidget> createState() {
    return _VideoViewScreenState();
  }
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  VideoPlayerController _videoPlayerController;

  int _currentPosition;

  StreamController _positionController;
  void _setPositionController(
      [int currenPosition = 0, VideoPlayerController controller]) {
    _currentPosition = currenPosition;
    _positionController = StreamController.broadcast();
    VideoPlayerController currentController =
        controller ?? _videoPlayerController;
    currentController.addListener(() {
      _currentPosition = currentController.value.position.inSeconds;
      _positionController.add(currentController.value.position.inSeconds);
      if (currentController.value.isBuffering && !BufferingController.buffering)
        BufferingController.change(true);
      else if (!currentController.value.isBuffering &&
          BufferingController.buffering) BufferingController.change(false);
    });
  }

  bool _animated = false;

  Set<String> _videoQualities;

  bool _saved;
  Future<void> _save() async {
    if (_saved)
      await DB.instance.insert(
        'Saved',
        {
          'videoID': widget.video.id,
          'savedVideoEncoded': jsonEncode(widget.video.toJson()),
        },
      );
    await Prefs.instance.setBool('${widget.video.id} saved', _saved);
  }

  @override
  void initState() {
    super.initState();
    _saved = Prefs.instance.getBool('${widget.video.id} saved') ?? false;
    _videoQualities = {
      widget.video.videos.mp4.hd,
      widget.video.videos.mp4.sd,
      widget.video.videos.mp4.low
    };
    _videoQualities.removeWhere((element) => element == null);
    _videoPlayerController =
        VideoPlayerController.network(_videoQualities.elementAt(0) ?? '');
    BufferingController.init();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) setState(() => _animated = true);
            }));
  }

  Future<bool> _getLargeImage() async {
    await precacheImage(
      NetworkImage(widget.video.images.poster),
      context,
    );
    return true;
  }

  Future<void> _changeVideoQuality(String videoURL) async {
    _videoPlayerController.pause();
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    final int currentPositionInSecs =
        (_videoPlayerController.value.position.inMilliseconds / 1000).round();
    try {
      _videoPlayerController.removeListener(() {});
      final _newPlayerController = VideoPlayerController.network(videoURL);
      await _newPlayerController.initialize();
      await _newPlayerController
          .seekTo(Duration(seconds: currentPositionInSecs));
      _setPositionController(currentPositionInSecs, _newPlayerController);
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => VideoPlayerScreen(
            UniqueKey(),
            playerController: _newPlayerController,
            positionController: _positionController,
            currentPosition: _currentPosition,
            video: widget.video,
            videoQualities: _videoQualities,
            changeVideoQuality: _changeVideoQuality,
          ),
        ),
      );
      await _videoPlayerController.dispose();
      _videoPlayerController = _newPlayerController;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _getLargeImage(),
            builder: (context, cached) => AnimatedCrossFade(
              firstChild: Hero(
                tag: widget.video.images.thumbsJpg,
                child: Image.network(
                  widget.video.images.thumbsJpg,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              secondChild: Image.network(
                widget.video.images.poster,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              crossFadeState: cached.hasData
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              curve: Curves.ease,
              opacity: _animated ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87,
                            Colors.black.withOpacity(0),
                          ],
                        ),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 30, 30),
                    child: Stack(
                      children: [
                        Text(
                          widget.video.title,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.black,
                          ),
                        ),
                        Text(
                          widget.video.title,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: FocusableButton(
                                  width: 160,
                                  height: 36,
                                  label: 'Channel',
                                  inverted: true,
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChannelViewScreen(
                                                  channelName:
                                                      widget.video.name,
                                                  channel: widget
                                                      .video.channelName))),
                                ),
                              ),
                              StatefulBuilder(
                                builder: (context, newState) => FocusableButton(
                                  width: 160,
                                  height: 36,
                                  label: _saved ? 'Saved' : 'Save',
                                  color: _saved ? Colors.green : null,
                                  onTap: () async {
                                    newState(() => _saved = !_saved);
                                    await _save();
                                  },
                                ),
                              ),
                              /*StatefulBuilder(
                                builder: (context, newState) => FocusableButton(
                                  width: 160,
                                  height: 36,
                                  label: 'Subscribe',
                                  onTap: () {},
                                  // TODO: Update with subscribe function
                                ),
                              ),*/
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Stack(
                                  children: [
                                    Text(
                                      '${NumberFormat.compact().format(widget.video.likes)} likes · '
                                      '${NumberFormat.compact().format(widget.video.viewsCount)} views',
                                      style: TextStyle(
                                        fontSize: 12,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '${NumberFormat.compact().format(widget.video.likes)} likes · '
                                      '${NumberFormat.compact().format(widget.video.viewsCount)} views',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              FocusableButton(
                                width: 160,
                                height: 36,
                                label: 'Play',
                                inverted: true,
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            VLCVideoPlayerScreen(UniqueKey(),
                                                video: widget.video))),
                                /*() async {
                                  bool error = false;
                                  if (_currentPosition == null) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Center(
                                            child:
                                                CircularProgressIndicator()));
                                    try {
                                      await _videoPlayerController.initialize();
                                      _setPositionController();
                                    } catch (e) {
                                      error = true;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text('$e')));
                                    }
                                    Navigator.pop(context);
                                  }
                                  if (!error) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            VideoPlayerScreen(
                                          UniqueKey(),
                                          playerController:
                                              _videoPlayerController,
                                          positionController:
                                              _positionController,
                                          currentPosition: _currentPosition,
                                          video: widget.video,
                                          videoQualities: _videoQualities,
                                          changeVideoQuality:
                                              _changeVideoQuality,
                                        ),
                                      ),
                                    );
                                    FocusScope.of(context).previousFocus();
                                  }
                                },*/
                              ),
                              const SizedBox(height: 8),
                              FocusableButton(
                                width: 160,
                                height: 36,
                                label: 'Back',
                                autofocus: true,
                                inverted: true,
                                onTap: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Text(
                                widget.video.description,
                                style: TextStyle(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Colors.black,
                                ),
                              ),
                              Text(widget.video.description),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _positionController?.close();
    _videoPlayerController.dispose();
    BufferingController.dispose();
    super.dispose();
  }
}
