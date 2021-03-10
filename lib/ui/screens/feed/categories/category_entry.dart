import 'package:flutter/material.dart';
import 'package:ivrata_tv/logic/api/models/category_model.dart';
import 'package:ivrata_tv/ui/screens/feed/categories/category_screen/category_screen.dart';

class CategoryEntry extends StatefulWidget {
  final CategoryData category;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final int index;

  CategoryEntry({
    @required this.category,
    @required this.scrollController,
    @required this.focusNode,
    @required this.index,
  });

  @override
  State<StatefulWidget> createState() {
    return _CategoryEntryState();
  }
}

class _CategoryEntryState extends State<CategoryEntry> {
  bool _isFocused = false;

  static final _animationDuration = const Duration(milliseconds: 300);

  void _scrollTo(double offset) => widget.scrollController
      .animateTo(offset, duration: _animationDuration, curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
      child: InkWell(
        focusNode: widget.focusNode,
        child: AnimatedOpacity(
          duration: _animationDuration,
          opacity: _isFocused ? 1 : 0.2,
          child: Stack(
            children: [
              AnimatedPositioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height / 4 +
                    (_isFocused ? -50 : 50),
                duration: _animationDuration,
                child: AnimatedOpacity(
                  duration: _animationDuration,
                  opacity: _isFocused ? 1 : 0,
                  child: Text(
                    widget.category.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                curve: Curves.ease,
                duration: _animationDuration,
                width: MediaQuery.of(context).size.width / (_isFocused ? 2 : 3),
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4 +
                        (_isFocused ? 0 : 50)),
                decoration: BoxDecoration(
                  boxShadow: kElevationToShadow[_isFocused ? 16 : 1],
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/categories/' +
                          widget.category.name +
                          '.jpeg',
                    ),
                  ),
                ),
                child: AnimatedContainer(
                  duration: _animationDuration,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _isFocused ? Colors.transparent : Colors.white30,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                CategoryScreen(category: widget.category))),
        onFocusChange: (isFocused) {
          setState(() => _isFocused = isFocused);
          if (_isFocused)
            _scrollTo(widget.index *
                    ((MediaQuery.of(context).size.width / 4 - 12) +
                        (MediaQuery.of(context).size.width / 3 + 24)) -
                (widget.index * (MediaQuery.of(context).size.width / 4 - 12)));
        },
      ),
    );
  }
}
