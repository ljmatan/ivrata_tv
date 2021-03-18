import 'package:flutter/material.dart';
import 'package:ivrata_tv/data/user_data.dart';
import 'package:ivrata_tv/logic/api/social.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';
import 'like.dart';

class DislikeButton extends StatefulWidget {
  final FocusNode focusNode;
  final int videoID;
  final GlobalKey<LikeButtonState> likeButtonKey;

  DislikeButton(
    Key key, {
    @required this.focusNode,
    @required this.videoID,
    @required this.likeButtonKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DislikeButtonState();
  }
}

class DislikeButtonState extends State<DislikeButton> {
  bool _isFocused = false;

  bool _liked;
  bool get liked => _liked;
  void setLiked(bool value) => setState(() => _liked = value);

  bool _processing = false;
  bool get processing => _processing;
  void setProcessing(bool value, [bool updateOther = false]) {
    setState(() => _processing = value);
    if (updateOther) widget.likeButtonKey.currentState.setProcessing(value);
  }

  @override
  void initState() {
    super.initState();
    _liked = Prefs.instance.getBool('${widget.videoID}');
    if (_liked == null && User.loggedIn)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() => _processing = true);
        _liked = await Social.isLiked(widget.videoID, 1);
        if (widget.likeButtonKey.currentState.liked != null) {
          widget.likeButtonKey.currentState.setProcessing(false);
          setState(() => _processing = false);
        }
      });
  }

  Future<void> _action() async {
    if (!User.loggedIn)
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be logged in to do that')));
    else
      try {
        setProcessing(true, true);
        await Social.dislike(widget.videoID);
        await Prefs.instance.setBool(
            '${widget.videoID}', _liked == null ? false : _liked == false);
        if (widget.likeButtonKey.currentState.liked == true)
          widget.likeButtonKey.currentState
              .setLiked(_liked == null ? false : _liked == false);
        _liked = _liked == null ? false : _liked == false;
        setProcessing(false, true);
      } catch (e) {
        setProcessing(false, true);
      }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: widget.focusNode,
      child: _processing
          ? const SizedBox()
          : Icon(
              _liked != null && !_liked
                  ? Icons.thumb_down
                  : Icons.thumb_down_off_alt,
              size: 40,
              color: _liked != null && !_liked
                  ? Colors.red.shade300.withOpacity(_isFocused ? 1 : 0.5)
                  : Colors.white.withOpacity(_isFocused ? 1 : 0.5),
            ),
      onTap: _processing ? null : () => _action(),
      onFocusChange: (isFocused) => setState(() => _isFocused = isFocused),
    );
  }
}
