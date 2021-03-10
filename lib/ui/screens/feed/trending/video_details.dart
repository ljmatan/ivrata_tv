import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/ui/screens/feed/trending/bloc/selected_trending_video_controller.dart';

class TrendingVideoDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrendingVideoDetailsState();
  }
}

class _TrendingVideoDetailsState extends State<TrendingVideoDetails> {
  VideoData _details;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: SelectedTrendingVideoController.stream,
      builder: (context, video) {
        if (video.hasData) _details = video.data;
        return video.hasData
            ? SizedBox(
                width: MediaQuery.of(context).size.width * (2 / 3) - 36,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _details.title,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }
}
