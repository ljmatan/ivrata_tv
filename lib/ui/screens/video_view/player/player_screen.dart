import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ivrata_tv/global/button_keycodes.dart';
import 'package:ivrata_tv/ui/screens/video_view/bloc/buffering_controller.dart';
import 'package:ivrata_tv/ui/screens/video_view/player/controls/dislike.dart';
import 'package:ivrata_tv/ui/screens/video_view/player/controls/like.dart';
import 'package:ivrata_tv/ui/screens/video_view/player/controls/quality_setting.dart';
import 'package:video_player/video_player.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'controls/ffr.dart';
import 'controls/ffw.dart';
import 'controls/mute_button.dart';
import 'controls/play_pause_button.dart';
import 'controls/stop_button.dart';
import 'skip_time_display.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoPlayerController playerController;
  final StreamController positionController;
  final int currentPosition;
  final VideoData video;
  final Set<String> videoQualities;
  final Function changeVideoQuality;

  VideoPlayerScreen(
    Key key, {
    @required this.playerController,
    @required this.positionController,
    @required this.currentPosition,
    @required this.video,
    @required this.videoQualities,
    @required this.changeVideoQuality,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerScreenState();
  }
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final _keyboardListenerFocusNode = FocusNode(canRequestFocus: false);

  bool _buttonsVisible = true;

  final _visibilityController = StreamController.broadcast();

  Timer _visibilityTimer;
  void _setVisibilityTimer() =>
      _visibilityTimer = Timer(const Duration(seconds: 4), () {
        _visibilityController.add(false);
        _buttonsVisible = false;
      });

  // Since keyboard listener widget is added, nodes must be present for each control.
  // In other places focus nodes are added due to the fact the support for TV devices is subpar.
  final _likeButtonFocusNode = FocusNode();
  final _likeButtonKey = GlobalKey<LikeButtonState>();
  final _dislikeButtonFocusNode = FocusNode();
  final _dislikeButtonKey = GlobalKey<DislikeButtonState>();
  final _playPauseButtonFocusNode = FocusNode();
  final _playPauseButtonKey = GlobalKey<PlayPauseButtonState>();
  final _stopButtonFocusNode = FocusNode();
  final _ffrButtonFocusNode = FocusNode();
  final _ffrButtonKey = GlobalKey<FFRButtonState>();
  final _ffwButtonFocusNode = FocusNode();
  final _ffwButtonKey = GlobalKey<FFWButtonState>();
  final _muteButtonFocusNode = FocusNode();
  final _sliderFocusNode = FocusNode();
  final _qualitySettingFocusNode = FocusNode();

  double _sliderValue;

  StreamSubscription _positionSubscription;
  final _skipValueController = StreamController.broadcast();

  bool _skipping = false;

  Timer _skipConfirmationTimer;

  void _setSkipConfirmationTimer() {
    _skipConfirmationTimer?.cancel();
    _skipConfirmationTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() => _skipping = false);
      widget.playerController.seekTo(Duration(seconds: _sliderValue.floor()));
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.playerController.play();
      _setVisibilityTimer();
    });
    _sliderValue = widget.currentPosition.toDouble();
    _positionSubscription = widget.positionController.stream.listen((position) {
      if (!_skipping) _sliderValue = position.toDouble();
    });
  }

  void _showSettingsDisplay() {
    _visibilityTimer.cancel();
    _visibilityController.add(false);
    if (_playPauseButtonKey.currentState.isPlaying)
      _playPauseButtonKey.currentState.action();
  }

  void _hideSettingsDisplay() {
    Navigator.pop(context);
    _visibilityController.add(true);
    _qualitySettingFocusNode.requestFocus();
    _playPauseButtonKey.currentState.action();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _keyboardListenerFocusNode,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.black),
              child: SizedBox.expand(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: widget.playerController.value.aspectRatio,
                    child: VideoPlayer(widget.playerController),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: StreamBuilder(
                stream: _visibilityController.stream,
                initialData: true,
                builder: (context, visible) => AnimatedOpacity(
                  opacity: visible.data ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 16,
                            top: 16,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LikeButton(
                                  _likeButtonKey,
                                  focusNode: _likeButtonFocusNode,
                                  videoID: widget.video.id,
                                  dislikeButtonKey: _dislikeButtonKey,
                                ),
                                const SizedBox(width: 12),
                                DislikeButton(
                                  _dislikeButtonKey,
                                  focusNode: _dislikeButtonFocusNode,
                                  videoID: widget.video.id,
                                  likeButtonKey: _likeButtonKey,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(160, 8, 160, 44),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StopButton(
                                  playerController: widget.playerController,
                                  focusNode: _stopButtonFocusNode,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: FFRButton(
                                    _ffrButtonKey,
                                    playerController: widget.playerController,
                                    focusNode: _ffrButtonFocusNode,
                                  ),
                                ),
                                PlayPauseButton(
                                  _playPauseButtonKey,
                                  playerController: widget.playerController,
                                  focusNode: _playPauseButtonFocusNode,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: FFWButton(
                                    _ffwButtonKey,
                                    playerController: widget.playerController,
                                    focusNode: _ffwButtonFocusNode,
                                  ),
                                ),
                                MuteButton(
                                  playerController: widget.playerController,
                                  focusNode: _muteButtonFocusNode,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: SettingsButton(
                              playerController: widget.playerController,
                              focusNode: _qualitySettingFocusNode,
                              showSettingsDisplay: _showSettingsDisplay,
                              hideSettingsDisplay: _hideSettingsDisplay,
                              videoQualities: widget.videoQualities,
                              changeVideoQuality: widget.changeVideoQuality,
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            left: 12,
                            right: 12,
                            child: StreamBuilder(
                              stream: _skipping
                                  ? _skipValueController.stream
                                  : widget.positionController.stream,
                              initialData: _sliderValue,
                              builder: (context, position) => Slider(
                                activeColor: Theme.of(context).primaryColor,
                                value: position.data /
                                    widget.playerController.value.duration
                                        .inSeconds,
                                focusNode: _sliderFocusNode,
                                onChanged: (_) => null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: StreamBuilder(
                stream: _skipValueController.stream,
                builder: (context, time) => time.hasData
                    ? SkipTimeDisplay(UniqueKey(), time: time.data)
                    : const SizedBox(),
              ),
            ),
            Center(
              child: StreamBuilder(
                stream: BufferingController.stream,
                builder: (context, buffering) =>
                    buffering.hasData && buffering.data
                        ? CircularProgressIndicator()
                        : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
      onKey: (key) {
        if (key.runtimeType == RawKeyDownEvent) {
          final bool _leftKey =
              key.data.toString().contains('keyCode: ${Buttons.left.code}');
          final bool _rightKey =
              key.data.toString().contains('keyCode: ${Buttons.right.code}');
          if (_sliderFocusNode.hasFocus && _leftKey ||
              _sliderFocusNode.hasFocus && _rightKey) {
            if (!_skipping) setState(() => _skipping = true);
            if (_rightKey &&
                _sliderValue + 1 <
                    widget.playerController.value.duration.inSeconds) {
              _sliderValue++;
              widget.positionController.add(_sliderValue);
            } else if (_leftKey && _sliderValue - 1 > 0) {
              _sliderValue--;
              widget.positionController.add(_sliderValue);
            }
            _skipValueController.add(_sliderValue);
            _setSkipConfirmationTimer();
          }
        } else if (key.runtimeType == RawKeyUpEvent) {
          if (key.data.toString().contains('keyCode: ${Buttons.ffr.code}'))
            _ffrButtonKey.currentState.action();
          else if (key.data.toString().contains('keyCode: ${Buttons.ffw.code}'))
            _ffwButtonKey.currentState.action();
          else if (key.data
              .toString()
              .contains('keyCode: ${Buttons.playPause.code}'))
            _playPauseButtonKey.currentState.action();
          if (_buttonsVisible) {
            _visibilityTimer.cancel();
            _setVisibilityTimer();
          } else {
            _visibilityController.add(true);
            _buttonsVisible = true;
            _playPauseButtonFocusNode.requestFocus();
          }
          if (_sliderFocusNode.hasFocus) {
            if (key.data.toString().contains('keyCode: ${Buttons.up.code}'))
              _playPauseButtonFocusNode.requestFocus();
            else if (key.data
                .toString()
                .contains('keyCode: ${Buttons.left.code}')) {
              widget.positionController.add(_sliderValue - 60);
            } else if (key.data
                .toString()
                .contains('keyCode: ${Buttons.right.code}')) {
              widget.positionController.add(_sliderValue + 60);
            }
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _likeButtonFocusNode.dispose();
    _dislikeButtonFocusNode.dispose();
    _playPauseButtonFocusNode.dispose();
    _stopButtonFocusNode.dispose();
    _ffrButtonFocusNode.dispose();
    _ffwButtonFocusNode.dispose();
    _muteButtonFocusNode.dispose();
    _sliderFocusNode.dispose();
    _qualitySettingFocusNode.dispose();
    _keyboardListenerFocusNode.dispose();
    _visibilityController.close();
    _visibilityTimer.cancel();
    _skipConfirmationTimer?.cancel();
    _skipValueController.close();
    _positionSubscription.cancel();
    super.dispose();
  }
}
