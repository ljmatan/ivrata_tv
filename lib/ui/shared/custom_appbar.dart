import 'package:flutter/material.dart';
import 'package:ivrata_tv/ui/shared/focusable_button.dart';
import 'package:ivrata_tv/ui/shared/focusable_icon.dart';

class CustomAppBar extends StatelessWidget {
  final String label;
  final FocusNode closeButtonFocusNode, searchButtonFocusNode;
  final bool seriesFilter, searchButton;
  final Function searchOnTap;

  CustomAppBar({
    @required this.label,
    @required this.closeButtonFocusNode,
    this.searchButtonFocusNode,
    this.seriesFilter: false,
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
