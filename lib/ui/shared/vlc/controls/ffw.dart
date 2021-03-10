import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class FFWButton extends StatefulWidget {
  final VlcPlayerController playerController;
  final FocusNode focusNode;

  FFWButton(
    Key key, {
    @required this.playerController,
    @required this.focusNode,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FFWButtonState();
  }
}

class FFWButtonState extends State<FFWButton> {
  bool _isFocused = false;

  Future<void> action() async {
    widget.playerController.seekTo(Duration(
        seconds: widget.playerController.value.position.inSeconds + 10));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: widget.focusNode,
      child: Icon(
        Icons.fast_forward,
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
