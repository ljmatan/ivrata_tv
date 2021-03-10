import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VLCStopButton extends StatefulWidget {
  final VlcPlayerController playerController;
  final FocusNode focusNode;

  VLCStopButton({
    @required this.playerController,
    @required this.focusNode,
  });

  @override
  State<StatefulWidget> createState() {
    return VLCStopButtonState();
  }
}

class VLCStopButtonState extends State<VLCStopButton> {
  bool _isFocused = false;

  Future<void> action() async => Navigator.pop(context);

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
