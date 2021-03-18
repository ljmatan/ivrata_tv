import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:ivrata_tv/global/button_keycodes.dart';
import 'package:ivrata_tv/ui/shared/focusable_icon.dart';
import 'controls/dislike.dart';
import 'controls/like.dart';
import 'controls/quality_setting.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'controls/ffr.dart';
import 'controls/ffw.dart';
import 'controls/mute_button.dart';
import 'controls/play_pause_button.dart';
import 'controls/stop_button.dart';
import 'skip_time_display.dart';

class VLCVideoPlayerScreen extends StatefulWidget {
  final VideoData video;

  VLCVideoPlayerScreen(Key key, {@required this.video}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VLCVideoPlayerScreenState();
  }
}

class _VLCVideoPlayerScreenState extends State<VLCVideoPlayerScreen> {
  VlcPlayerController _currentVideoController;
  VlcPlayerController _videoPlayerController;

  int _currentPosition = 0;
  int get currentPosition => _currentPosition;

  final _positionController = StreamController.broadcast();

  final _controlsController = StreamController.broadcast();

  void _addVideoControllerListener(VlcPlayerController controller) =>
      controller.addListener(() {
        if (controller.value.isPlaying) {
          _positionController.add(controller.value.position.inSeconds);
        }
      });

  Set<String> _videoQualities;

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
  final _closeButtonFocusNode = FocusNode();

  double _sliderValue = 0.0;

  StreamSubscription _positionSubscription;
  final _skipValueController = StreamController.broadcast();

  bool _skipping = false;

  Timer _skipConfirmationTimer;

  void _setSkipConfirmationTimer() {
    _skipConfirmationTimer?.cancel();
    _skipConfirmationTimer = Timer(const Duration(milliseconds: 200), () {
      setState(() => _skipping = false);
      (_currentVideoController ?? _videoPlayerController)
          .seekTo(Duration(seconds: _sliderValue.floor()));
    });
  }

  StreamSubscription _skipSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setVisibilityTimer());
    _videoQualities = {
      widget.video.videos.mp4.hd,
      widget.video.videos.mp4.sd,
      widget.video.videos.mp4.low
    };
    _videoQualities.removeWhere((element) => element == null);
    _videoPlayerController = VlcPlayerController.network(
      _videoQualities.elementAt(0) ?? '',
      autoInitialize: false,
      autoPlay: false,
    );
    _addVideoControllerListener(_videoPlayerController);
    _positionSubscription = _positionController.stream.listen((value) {
      if (value.runtimeType == int && value != 0) _currentPosition = value;
      if (value.runtimeType == int && !_skipping)
        _sliderValue = value.toDouble();
    });
    _skipSubscription =
        _skipValueController.stream.listen((value) => _sliderValue = value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        // If initialisation is not delayed it doesn't work
        Future.delayed(const Duration(milliseconds: 200), () async {
          print('Controller initialisation start');
          await Future.doWhile(() =>
              _videoPlayerController.isReadyToInitialize == null ||
              !_videoPlayerController.isReadyToInitialize);
          print('Controller initialisation ready');
          await _videoPlayerController.initialize();
          print('Controller initialised');
          _videoPlayerController.play();
          _controlsController.add(true);
          _playPauseButtonFocusNode.requestFocus();
        });
      } catch (e) {
        print('VLC init error: $e');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Video initialisation failed')));
      }
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

  Key _playerKey = UniqueKey();

  void _changeVideoQuality(String newVideoURL) async {
    _controlsController.add(false);
    _closeButtonFocusNode.requestFocus();
    if (_videoPlayerController != null) {
      setState(() {
        _playerKey = UniqueKey();
        _currentVideoController =
            VlcPlayerController.network(newVideoURL, onInit: () {
          _addVideoControllerListener(_currentVideoController);
          _controlsController.add(true);
          _playPauseButtonFocusNode.requestFocus();
          Future.delayed(
              const Duration(milliseconds: 200),
              () => _currentVideoController
                  .seekTo(Duration(seconds: _sliderValue.floor())));
        });
      });
      await _videoPlayerController?.stopRendererScanning();
      await _videoPlayerController?.dispose();
      _videoPlayerController = null;
    } else {
      setState(() {
        _playerKey = UniqueKey();
        _videoPlayerController =
            VlcPlayerController.network(newVideoURL, onInit: () {
          _addVideoControllerListener(_videoPlayerController);
          _controlsController.add(true);
          _playPauseButtonFocusNode.requestFocus();
          Future.delayed(
              const Duration(milliseconds: 200),
              () => _videoPlayerController
                  .seekTo(Duration(seconds: _sliderValue.floor())));
        });
      });
      await _currentVideoController?.stopRendererScanning();
      await _currentVideoController?.dispose();
      _videoPlayerController = null;
    }
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(),
                  CircularProgressIndicator(),
                  SizedBox.expand(
                    child: VlcPlayer(
                      key: _playerKey,
                      controller:
                          _currentVideoController ?? _videoPlayerController,
                      aspectRatio:
                          (_currentVideoController ?? _videoPlayerController)
                              .value
                              .aspectRatio,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: _controlsController.stream,
              initialData: false,
              builder: (context, enabled) => !enabled.data
                  ? Positioned(
                      top: 16,
                      right: 16,
                      child: FocusableIcon(
                        focusNode: _closeButtonFocusNode,
                        autoFocus: true,
                        icon: Icons.close,
                        onTap: () => Navigator.pop(context),
                      ),
                    )
                  : const SizedBox(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: StreamBuilder(
                stream: _controlsController.stream,
                initialData: false,
                builder: (context, enabled) => enabled.data
                    ? StreamBuilder(
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
                                    padding: const EdgeInsets.fromLTRB(
                                        160, 8, 160, 44),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        VLCStopButton(
                                          playerController:
                                              _currentVideoController ??
                                                  _videoPlayerController,
                                          focusNode: _stopButtonFocusNode,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: FFRButton(
                                            _ffrButtonKey,
                                            playerController:
                                                _currentVideoController ??
                                                    _videoPlayerController,
                                            focusNode: _ffrButtonFocusNode,
                                          ),
                                        ),
                                        PlayPauseButton(
                                          _playPauseButtonKey,
                                          playerController:
                                              _currentVideoController ??
                                                  _videoPlayerController,
                                          focusNode: _playPauseButtonFocusNode,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: FFWButton(
                                            _ffwButtonKey,
                                            playerController:
                                                _currentVideoController ??
                                                    _videoPlayerController,
                                            focusNode: _ffwButtonFocusNode,
                                          ),
                                        ),
                                        MuteButton(
                                          playerController:
                                              _currentVideoController ??
                                                  _videoPlayerController,
                                          focusNode: _muteButtonFocusNode,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: SettingsButton(
                                      playerController:
                                          _currentVideoController ??
                                              _videoPlayerController,
                                      focusNode: _qualitySettingFocusNode,
                                      showSettingsDisplay: _showSettingsDisplay,
                                      hideSettingsDisplay: _hideSettingsDisplay,
                                      videoQualities: _videoQualities,
                                      changeVideoQuality: _changeVideoQuality,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    left: 12,
                                    right: 12,
                                    child: StreamBuilder(
                                      stream: _skipping
                                          ? _skipValueController.stream
                                          : _positionController.stream,
                                      initialData: currentPosition.toDouble(),
                                      builder: (context, position) {
                                        print(position.data);
                                        print((_currentVideoController ??
                                                _videoPlayerController)
                                            .value
                                            ?.duration
                                            ?.inSeconds);
                                        int duration =
                                            (_currentVideoController ??
                                                    _videoPlayerController)
                                                .value
                                                ?.duration
                                                ?.inSeconds;
                                        if (duration == 0.0)
                                          duration = 10000000000;
                                        return Slider(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: position.data / duration,
                                          focusNode: _sliderFocusNode,
                                          onChanged: (_) => null,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
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
            if (_rightKey &&
                _sliderValue + 1 <
                    (_currentVideoController ?? _videoPlayerController)
                        .value
                        .duration
                        .inSeconds) {
              _sliderValue++;
            } else if (_leftKey && _sliderValue - 1 > 0) {
              _sliderValue--;
            }
            if (!_skipping) setState(() => _skipping = true);
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
    _closeButtonFocusNode.dispose();
    _visibilityController.close();
    _visibilityTimer.cancel();
    _skipConfirmationTimer?.cancel();
    _skipValueController.close();
    _positionSubscription.cancel();
    _currentVideoController?.dispose();
    _videoPlayerController?.dispose();
    _controlsController.close();
    _skipSubscription.cancel();
    super.dispose();
  }
}
