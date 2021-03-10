import 'package:flutter/material.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';
import 'package:ivrata_tv/ui/shared/focusable_icon.dart';

class CustomAppBar extends StatelessWidget {
  final String label;
  final FocusNode closeButtonFocusNode,
      seriesFilterFocusNode,
      moviesFilterFocusNode,
      searchButtonFocusNode;
  final bool seriesFilter, searchButton;
  final Function seriesFilterOnTap, searchOnTap;
  final int selectedSeriesOption;

  CustomAppBar({
    @required this.label,
    @required this.closeButtonFocusNode,
    this.seriesFilterFocusNode,
    this.moviesFilterFocusNode,
    this.seriesFilter: false,
    this.seriesFilterOnTap,
    this.selectedSeriesOption,
    this.searchButtonFocusNode,
    this.searchButton: false,
    this.searchOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 24,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (seriesFilter)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        FocusableButton(
                          width: 100,
                          height: 36,
                          focusNode: moviesFilterFocusNode,
                          color: selectedSeriesOption == 0
                              ? Colors.white
                              : Colors.white54,
                          label: 'Films',
                          inverted: true,
                          onTap: () => seriesFilterOnTap(0),
                        ),
                        const SizedBox(width: 10),
                        FocusableButton(
                          width: 100,
                          height: 36,
                          focusNode: seriesFilterFocusNode,
                          color: selectedSeriesOption == 1
                              ? Colors.white
                              : Colors.white54,
                          label: 'Series',
                          inverted: true,
                          onTap: () => seriesFilterOnTap(1),
                        ),
                      ],
                    ),
                  ),
                if (searchButton)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FocusableButton(
                      focusNode: searchButtonFocusNode,
                      width: 200,
                      height: 36,
                      label: 'SEARCH',
                      icon: Icons.search,
                      inverted: true,
                      onTap: () => searchOnTap(),
                    ),
                  ),
                FocusableIcon(
                  autoFocus: true,
                  focusNode: closeButtonFocusNode,
                  icon: Icons.close,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
