import 'package:flutter/material.dart';
import 'package:ivrata_tv/data/user_data.dart';
import 'package:ivrata_tv/logic/api/social.dart';
import 'package:ivrata_tv/logic/cache/prefs.dart';
import 'dislike.dart';

class LikeButton extends StatefulWidget {
  final FocusNode focusNode;
  final int videoID;
  final GlobalKey<DislikeButtonState> dislikeButtonKey;

  LikeButton(
    Key key, {
    @required this.focusNode,
    @required this.videoID,
    @required this.dislikeButtonKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LikeButtonState();
  }
}

class LikeButtonState extends State<LikeButton> {
  bool _isFocused = false;

  bool _liked;
  bool get liked => _liked;
  void setLiked(bool value) => setState(() => _liked = value);

  bool _processing = false;
  bool get processing => _processing;
  void setProcessing(bool value, [bool updateOther = false]) {
    setState(() => _processing = value);
    if (updateOther) widget.dislikeButtonKey.currentState.setProcessing(value);
  }

  @override
  void initState() {
    super.initState();
    _liked = Prefs.instance.getBool('${widget.videoID}');
    if (_liked == null && User.loggedIn)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() => _processing = true);
        _liked = await Social.isLiked(widget.videoID, 1);
        if (widget.dislikeButtonKey.currentState.liked != null) {
          widget.dislikeButtonKey.currentState.setProcessing(false);
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
        await Social.like(widget.videoID);
        await Prefs.instance
            .setBool('${widget.videoID}', _liked == null || !_liked);
        if (widget.dislikeButtonKey.currentState.liked == false)
          widget.dislikeButtonKey.currentState
              .setLiked(_liked == null || !_liked);
        _liked = _liked == null || !_liked;
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
          ? SizedBox(
              width: 20,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CircularProgressIndicator(),
              ),
            )
          : Icon(
              _liked != null && _liked
                  ? Icons.thumb_up
                  : Icons.thumb_up_off_alt,
              size: 40,
              color: _liked != null && _liked
                  ? Colors.green.shade300.withOpacity(_isFocused ? 1 : 0.5)
                  : Colors.white.withOpacity(_isFocused ? 1 : 0.5),
            ),
      onTap: _processing ? null : () => _action(),
      onFocusChange: (isFocused) => setState(() => _isFocused = isFocused),
    );
  }
}
