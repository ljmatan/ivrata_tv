import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/videos_response_model.dart';
import 'package:ivrata_tv/logic/api/videos.dart';
import 'package:ivrata_tv/ui/shared/custom_appbar.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';
import 'package:ivrata_tv/ui/shared/future_no_data.dart';
import 'package:ivrata_tv/ui/shared/video_entry_button.dart';

class MoreVideosScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoreVideosScreenState();
  }
}

class _MoreVideosScreenState extends State<MoreVideosScreen> {
  final _scrollController = ScrollController();

  final _closeButtonFocusNode = FocusNode();
  final _previousPageFocusNode = FocusNode();
  final _goToTopButtonFocusNode = FocusNode();
  final _nextPageButtonFocusNode = FocusNode();
  final _searchButtonFocusNode = FocusNode();

  void _scrollTo(double offset) => _scrollController.animateTo(offset,
      duration: const Duration(milliseconds: 300), curve: Curves.ease);

  @override
  void initState() {
    super.initState();
    _closeButtonFocusNode.addListener(() {
      if (_closeButtonFocusNode.hasFocus) _scrollTo(0);
    });
    _previousPageFocusNode.addListener(() {
      if (_previousPageFocusNode.hasFocus)
        _scrollTo(_scrollController.position.maxScrollExtent);
    });
    _goToTopButtonFocusNode.addListener(() {
      if (_goToTopButtonFocusNode.hasFocus)
        _scrollTo(_scrollController.position.maxScrollExtent);
    });
    _nextPageButtonFocusNode.addListener(() {
      if (_nextPageButtonFocusNode.hasFocus)
        _scrollTo(_scrollController.position.maxScrollExtent);
    });
    _searchButtonFocusNode.addListener(() {
      if (_searchButtonFocusNode.hasFocus) _scrollTo(0);
    });
  }

  int _currentPage = 1;

  final _searchTermController = TextEditingController();

  String _searchTerm;

  void _searchButtonOnTap() => setState(() => _searchTerm = null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_1.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          if (_searchTerm == null)
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: kToolbarHeight,
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4,
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _searchTermController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                  onSubmitted: (_) {
                    _closeButtonFocusNode.requestFocus();
                    if (_searchTermController.text.length < 3)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please enter at least 3 characters')));
                    else
                      setState(() => _searchTerm = _searchTermController.text);
                  },
                ),
              ),
            ),
          ListView(
            shrinkWrap: true,
            controller: _scrollController,
            children: [
              CustomAppBar(
                label: 'More Videos',
                closeButtonFocusNode: _closeButtonFocusNode,
                searchButton: _searchTerm != null,
                searchButtonFocusNode: _searchButtonFocusNode,
                searchOnTap: _searchButtonOnTap,
              ),
              if (_searchTerm != null)
                FutureBuilder(
                  future: VideosAPI.searchVideos(_searchTerm, _currentPage),
                  builder: (context, AsyncSnapshot<VideosResponse> videos) =>
                      videos.connectionState != ConnectionState.done ||
                              videos.hasError ||
                              videos.hasData && videos.data.error != false ||
                              videos.hasData &&
                                  videos.data.response.rows.isEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height -
                                  kToolbarHeight,
                              child: videos.hasData &&
                                      videos.data.response.rows.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No videos found',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                    )
                                  : FutureBuilderNoData(videos),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 16 / 10,
                                  ),
                                  itemCount: videos.data.response.rows.length,
                                  itemBuilder: (context, i) => VideoEntryButton(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    video: videos.data.response.rows[i],
                                    padding: EdgeInsets.fromLTRB(
                                      (i + 1) % 3 == 0 ? 0 : 12,
                                      6,
                                      i % 3 == 0 ? 0 : 12,
                                      6,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_currentPage != 1)
                                        FocusableButton(
                                          focusNode: _previousPageFocusNode,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 48,
                                          label: 'PREVIOUS PAGE',
                                          inverted: true,
                                          onTap: () =>
                                              setState(() => _currentPage -= 1),
                                        ),
                                      if (videos.data.response.rows.length >
                                              6 &&
                                          _currentPage != 1)
                                        const SizedBox(width: 16),
                                      if (videos.data.response.rows.length > 6)
                                        FocusableButton(
                                          focusNode: _goToTopButtonFocusNode,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 48,
                                          label: 'GO TO TOP',
                                          inverted: true,
                                          onTap: () {
                                            _scrollTo(0);
                                            _closeButtonFocusNode
                                                .requestFocus();
                                          },
                                        ),
                                      const SizedBox(width: 16),
                                      if (videos.data.response.rows.length ==
                                          60)
                                        FocusableButton(
                                          focusNode: _nextPageButtonFocusNode,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 48,
                                          label: 'NEXT PAGE',
                                          inverted: true,
                                          onTap: () =>
                                              setState(() => _currentPage += 1),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchTermController.dispose();
    _closeButtonFocusNode.dispose();
    _previousPageFocusNode.dispose();
    _goToTopButtonFocusNode.dispose();
    _nextPageButtonFocusNode.dispose();
    _searchButtonFocusNode.dispose();
    super.dispose();
  }
}
