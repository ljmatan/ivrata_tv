import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';

class SettingsButton extends StatefulWidget {
  final VlcPlayerController playerController;
  final FocusNode focusNode;
  final Function showSettingsDisplay, hideSettingsDisplay;
  final Set<String> videoQualities;
  final Function(String) changeVideoQuality;

  SettingsButton({
    @required this.playerController,
    @required this.focusNode,
    @required this.showSettingsDisplay,
    @required this.hideSettingsDisplay,
    @required this.videoQualities,
    @required this.changeVideoQuality,
  });

  @override
  State<StatefulWidget> createState() {
    return SettingsButtonState();
  }
}

class SettingsButtonState extends State<SettingsButton> {
  bool _isFocused = false;

  Widget _qualitySettingSelection(
    String filenameEndsWith,
    String label,
  ) {
    final String thisOption = widget.videoQualities
        .singleWhere((e) => e.endsWith(filenameEndsWith), orElse: () => null);
    return thisOption != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FocusableButton(
              autofocus:
                  widget.playerController.dataSource.endsWith(filenameEndsWith),
              width: MediaQuery.of(context).size.width / 4,
              height: 64,
              label: label,
              onTap: () {
                widget.hideSettingsDisplay();
                if (!widget.playerController.dataSource
                    .endsWith(filenameEndsWith))
                  widget.changeVideoQuality(thisOption);
              },
            ),
          )
        : const SizedBox();
  }

  Future<void> action() async {
    widget.showSettingsDisplay();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Material(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(2),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _qualitySettingSelection('HD.mp4', '4K'),
                _qualitySettingSelection('SD.mp4', '1080p'),
                _qualitySettingSelection('Low.mp4', 'SD'),
                FocusableButton(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 64,
                  label: 'Cancel',
                  onTap: () => widget.hideSettingsDisplay(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: widget.focusNode,
      child: Icon(
        Icons.settings,
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
