import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class PlayPauseButton extends StatefulWidget {
  final VlcPlayerController playerController;
  final FocusNode focusNode;

  PlayPauseButton(
    Key key, {
    @required this.playerController,
    @required this.focusNode,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PlayPauseButtonState();
  }
}

class PlayPauseButtonState extends State<PlayPauseButton> {
  bool isPlaying = true;
  bool _isFocused = false;

  void action() {
    setState(() => isPlaying = !isPlaying);
    if (isPlaying)
      widget.playerController.play();
    else
      widget.playerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      autofocus: true,
      focusNode: widget.focusNode,
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        size: 56,
        color: Colors.white.withOpacity(
          _isFocused ? 1 : 0.5,
        ),
      ),
      onTap: () => action(),
      onFocusChange: (isFocused) => setState(() => _isFocused = isFocused),
    );
  }
}
