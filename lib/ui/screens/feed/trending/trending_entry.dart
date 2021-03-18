import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/ui/screens/feed/trending/bloc/selected_trending_video_controller.dart';
import 'package:ivrata_tv/ui/screens/video_view/video_view_screen.dart';

class TrendingEntry extends StatefulWidget {
  final VideoData video;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final int index;

  TrendingEntry({
    @required this.video,
    @required this.scrollController,
    @required this.focusNode,
    @required this.index,
  });

  @override
  State<StatefulWidget> createState() {
    return _TrendingEntryState();
  }
}

class _TrendingEntryState extends State<TrendingEntry> {
  bool _isFocused = false;

  static final _animationDuration = const Duration(milliseconds: 300);

  void _scrollTo(double offset) => widget.scrollController
      .animateTo(offset, duration: _animationDuration, curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusNode: widget.focusNode,
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.ease,
        width: MediaQuery.of(context).size.width / (_isFocused ? 3 : 4),
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.fromLTRB(
          widget.index == 0 ? 12 : 0,
          _isFocused ? 16 : MediaQuery.of(context).size.height / 2,
          12,
          12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[_isFocused ? 2 : 0],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: widget.video.images.thumbsJpg,
                      child: Image.network(
                        widget.video.images.thumbsJpg,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _isFocused ? 0 : 0.6,
                      duration: _animationDuration,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black54),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: _isFocused ? 0 : 1,
                  duration: _animationDuration,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                widget.video.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.video.viewsCount.toString() + ' views',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              VideoViewScreen(video: widget.video))),
      onFocusChange: (isFocused) {
        if (_isFocused && !isFocused)
          SelectedTrendingVideoController.change(null);
        if (isFocused)
          _scrollTo(
              widget.index * (MediaQuery.of(context).size.width / 4 + 12));
        setState(() => _isFocused = isFocused);
        if (_isFocused) SelectedTrendingVideoController.change(widget.video);
      },
    );
  }
}
