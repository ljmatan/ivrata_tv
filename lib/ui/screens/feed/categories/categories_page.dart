import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/category_model.dart';
import 'package:ivrata_tv/logic/api/videos.dart';
import 'package:ivrata_tv/ui/screens/feed/categories/category_entry.dart';
import 'package:ivrata_tv/ui/shared/future_no_data.dart';

class CategoriesPage extends StatefulWidget {
  final double screenWidth;

  CategoriesPage({@required this.screenWidth});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesPageState();
  }
}

class _CategoriesPageState extends State<CategoriesPage> {
  ScrollController _scrollController;

  final _firstEntryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController(initialScrollOffset: widget.screenWidth / 4 - 24);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) _firstEntryFocusNode.requestFocus();
            }));
  }

  static final Future<CategoryResponse> _getCategories =
      VideosAPI.getCategories();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCategories,
      builder: (context, AsyncSnapshot<CategoryResponse> categories) =>
          categories.connectionState != ConnectionState.done ||
                  categories.hasError ||
                  categories.hasData && categories.data.error != false ||
                  categories.hasData && categories.data.response.isEmpty
              ? FutureBuilderNoData(categories)
              : ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 4 - 12),
                    for (var i = 0; i < categories.data.response.length; i++)
                      CategoryEntry(
                        category: categories.data.response[i],
                        scrollController: _scrollController,
                        focusNode: i == 0 ? _firstEntryFocusNode : null,
                        index: i,
                      ),
                    SizedBox(width: MediaQuery.of(context).size.width / 4 - 12),
                  ],
                ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _firstEntryFocusNode.dispose();
    super.dispose();
  }
}
