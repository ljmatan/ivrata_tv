import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/videos.dart';

class LivestreamsPage extends StatelessWidget {
  static final Future _getLivestreams = VideosAPI.getLivestreams();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getLivestreams,
      builder: (context, livestreams) =>
          livestreams.connectionState != ConnectionState.done ||
                  livestreams.hasError ||
                  livestreams.hasData && livestreams.data['error'] != false ||
                  livestreams.hasData &&
                      livestreams.data['1'] == null &&
                      livestreams.data['0']['msg'] == 'OFFLINE'
              ? Center(
                  child: livestreams.connectionState != ConnectionState.done
                      ? CircularProgressIndicator()
                      : Text(
                          livestreams.hasError
                              ? livestreams.error.toString()
                              : livestreams.data['error'] != false
                                  ? livestreams.data['error']
                                  : 'No livestreams active at this time!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 30),
                        ),
                )
              : const SizedBox(),
    );
  }
}
