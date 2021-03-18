import 'package:flutter/material.dart';
import 'package:ivrata_tv/ui/shared/focusable_icon.dart';

class CustomCarouselSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomCarouselSliderState();
  }
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final _pageController = PageController();

  void _nextPage() => _pageController.nextPage(
      duration: const Duration(milliseconds: 500), curve: Curves.ease);

  void _previousPage() => _pageController.previousPage(
      duration: const Duration(milliseconds: 500), curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: [],
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 16,
          child: FocusableIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () {},
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 16,
          child: FocusableIcon(
            icon: Icons.keyboard_arrow_right,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
