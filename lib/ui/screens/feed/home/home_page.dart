import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/logic/api/videos.dart';
import 'package:ivrata_tv/ui/screens/feed/home/latest_entry.dart';
import 'package:ivrata_tv/ui/shared/future_no_data.dart';

class HomePage extends StatelessWidget {
  static final Future<VideosResponse> _getLatest = VideosAPI.getLatest();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getLatest,
      builder: (context, AsyncSnapshot<VideosResponse> videos) =>
          videos.connectionState != ConnectionState.done ||
                  videos.hasError ||
                  videos.hasData && videos.data.error != false ||
                  videos.hasData && videos.data.response.rows.isEmpty
              ? FutureBuilderNoData(videos)
              : Column(
                  children: [
                    const SizedBox(height: 6),
                    for (var i = 2; i >= 0; i--)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: LatestEntry(
                                video: videos.data.response.rows[i * 4],
                                index: 0,
                              ),
                            ),
                            Expanded(
                              child: LatestEntry(
                                video: videos.data.response.rows[i * 4 + 1],
                                index: 1,
                              ),
                            ),
                            Expanded(
                              child: LatestEntry(
                                video: videos.data.response.rows[i * 4 + 2],
                                index: 2,
                              ),
                            ),
                            Expanded(
                              child: LatestEntry(
                                video: i != 0
                                    ? videos.data.response.rows[i * 4 + 3]
                                    : null,
                                index: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 6),
                  ],
                ),
    );
  }
}
