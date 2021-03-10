import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MuteButton extends StatefulWidget {
  final VideoPlayerController playerController;
  final FocusNode focusNode;

  MuteButton({
    @required this.playerController,
    @required this.focusNode,
  });

  @override
  State<StatefulWidget> createState() {
    return MuteButtonState();
  }
}

class MuteButtonState extends State<MuteButton> {
  bool _isFocused = false;
  bool _isMuted = false;

  Future<void> action() async {
    setState(() => _isMuted = !_isMuted);
    widget.playerController.setVolume(_isMuted ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: widget.focusNode,
      child: Icon(
        _isMuted ? Icons.volume_off : Icons.volume_up,
        size: 40,
        color: Colors.white.withOpacity(
          _isFocused ? 1 : 0.5,
        ),
      ),
      onTap: () => action(),
      onFocusChange: (isFocused) => setState(() => _isFocused = isFocused),
    );
  }
}
