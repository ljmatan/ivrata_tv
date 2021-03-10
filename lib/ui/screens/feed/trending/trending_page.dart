import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/logic/api/videos.dart';
import 'bloc/selected_trending_video_controller.dart';
import 'trending_entry.dart';
import 'video_details.dart';
import 'package:ivrata_tv/ui/shared/future_no_data.dart';

class TrendingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendingPageState();
  }
}

class _TrendingPageState extends State<TrendingPage> {
  final _scrollController = ScrollController();

  final _firstEntryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SelectedTrendingVideoController.init();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) _firstEntryFocusNode.requestFocus();
            }));
  }

  static final Future<VideosResponse> _getTrending = VideosAPI.getTrending();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTrending,
      builder: (context, AsyncSnapshot<VideosResponse> videos) =>
          videos.connectionState != ConnectionState.done ||
                  videos.hasError ||
                  videos.hasData && videos.data.error != false ||
                  videos.hasData && videos.data.response.rows.isEmpty
              ? FutureBuilderNoData(videos)
              : Stack(
                  children: [
                    ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => TrendingEntry(
                        video: videos.data.response
                            .rows[i % videos.data.response.rows.length],
                        scrollController: _scrollController,
                        focusNode: i == 0 ? _firstEntryFocusNode : null,
                        index: i,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: TrendingVideoDetails(),
                    ),
                  ],
                ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    SelectedTrendingVideoController.dispose();
    super.dispose();
  }
}
