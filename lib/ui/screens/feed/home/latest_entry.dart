import 'package:carousel_slider/carousel_slider.dart';
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

  List<String> _images;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));
    _scale = Tween<double>(begin: 1.0, end: 1.05).animate(_animationController);
    if (widget.video != null)
      _images = [
        widget.video.images.thumbsJpg,
        if (!widget.video.images.poster.contains('notfound'))
          widget.video.images.poster,
        widget.video.images.thumbsJpg,
        if (!widget.video.images.poster.contains('notfound'))
          widget.video.images.poster,
      ];
  }

  bool _isFocused = false;

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Transform.scale(
        scale: _scale.value,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            widget.index == 0 ? 12 : 6,
            6,
            widget.index == 3 ? 12 : 6,
            6,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(blurRadius: 6)],
              color: Colors.white70,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  if (widget.video != null)
                    Positioned.fill(
                      child: CarouselSlider(
                        carouselController: _carouselController,
                        items: [
                          for (var image in _images)
                            SizedBox.expand(
                              child: Image.network(
                                image,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                        options: CarouselOptions(
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlayInterval: Duration(seconds: 1),
                          aspectRatio: MediaQuery.of(context).size.width /
                              MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                  if (widget.video != null)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _isFocused ? Colors.transparent : Colors.black54,
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
        if (isFocused) {
          _animationController.forward();
          _carouselController?.startAutoPlay();
        } else {
          _animationController.reverse();
          _carouselController?.stopAutoPlay();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
