import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/ui/screens/feed/home/more_videos/more_videos_screen.dart';
import 'package:ivrata_tv/ui/screens/video_view/video_view_screen.dart';

class LatestEntry extends StatefulWidget {
  final VideoData video;
  final int index;

  LatestEntry({this.video, @required this.index});

  @override
  State<StatefulWidget> createState() {
    return _LatestEntryState();
  }
}

class _LatestEntryState extends State<LatestEntry>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));
    _scale = Tween<double>(begin: 1.0, end: 1.05).animate(_animationController);
  }

  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Transform.scale(
        scale: _scale.value,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            widget.index == 0 ? 6 : 12,
            6,
            widget.index == 2 ? 6 : 12,
            6,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: kElevationToShadow[2],
              color: Colors.white70,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  if (widget.video != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Hero(
                        tag: widget.video.images.thumbsJpg,
                        child: Image.network(
                          widget.video.images.thumbsJpg,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (widget.video != null)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _isFocused ? Colors.transparent : Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          if (widget.video != null)
                            Text(
                              widget.video != null
                                  ? widget.video.title
                                  : 'See More',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: widget.video == null ? 24 : null,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.black,
                              ),
                            ),
                          Text(
                            widget.video != null
                                ? widget.video.title
                                : 'More Videos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: widget.video != null
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: widget.video == null ? 24 : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => widget.video == null
              ? MoreVideosScreen()
              : VideoViewScreen(video: widget.video))),
      onFocusChange: (isFocused) {
        if (_isFocused != isFocused) _isFocused = isFocused;
        isFocused
            ? _animationController.forward()
            : _animationController.reverse();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
