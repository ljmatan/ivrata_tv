import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StopButton extends StatefulWidget {
  final VideoPlayerController playerController;
  final FocusNode focusNode;

  StopButton({
    @required this.playerController,
    @required this.focusNode,
  });

  @override
  State<StatefulWidget> createState() {
    return StopButtonState();
  }
}

class StopButtonState extends State<StopButton> {
  bool _isFocused = false;

  Future<void> action() async {
    widget.playerController.pause();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: widget.focusNode,
      child: Icon(
        Icons.stop,
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
