import 'dart:async';

import 'package:flutter/material.dart';
import 'profile/profile_page.dart';
import 'trending/trending_page.dart';
import 'categories/categories_page.dart';
import 'home/home_page.dart';
import 'livestreams/livestreams_page.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedScreenState();
  }
}

class _FeedScreenState extends State<FeedScreen> {
  final _pageController = PageController();

  final _labels = const {'LATEST', 'TRENDING', 'CATEGORIES', 'LIVE', 'PROFILE'};

  void _goToPage(int page) => _pageController.animateToPage(page,
      duration: const Duration(milliseconds: 300), curve: Curves.ease);

  int _currentPage = 0;

  final _currentPageController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page.round() != _currentPage) {
        _currentPage = _pageController.page.round();
        _currentPageController.add(_currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < 5; i++)
                    StreamBuilder(
                      stream: _currentPageController.stream,
                      initialData: _currentPage,
                      builder: (context, currentPage) => FocusableButton(
                        width: MediaQuery.of(context).size.width / 6,
                        height: 36,
                        label: _labels.elementAt(i),
                        onTap: () => _goToPage(i),
                        textColor: currentPage.data == i ? Colors.black : null,
                        fontWeight:
                            currentPage.data == i ? FontWeight.bold : null,
                        inverted: true,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              TrendingPage(),
              CategoriesPage(screenWidth: MediaQuery.of(context).size.width),
              LivestreamsPage(),
              ProfilePage(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _currentPageController.close();
    _pageController.dispose();
    super.dispose();
  }
}
