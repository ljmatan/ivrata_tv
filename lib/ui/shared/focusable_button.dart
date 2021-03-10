import 'package:flutter/material.dart';

class FocusableButton extends StatefulWidget {
  final double width, height, borderRadius;
  final String label, image;
  final Function onTap;
  final FocusNode focusNode;
  final Color color, focusColor, textColor;
  final bool autofocus, inverted;
  final IconData icon;
  final FontWeight fontWeight;

  FocusableButton({
    @required this.width,
    @required this.height,
    @required this.label,
    this.image,
    @required this.onTap,
    this.focusNode,
    this.color,
    this.focusColor,
    this.textColor,
    this.autofocus: false,
    this.icon,
    this.borderRadius,
    this.inverted: false,
    this.fontWeight,
  });

  @override
  State<StatefulWidget> createState() {
    return _FocusableButtonState();
  }
}

class _FocusableButtonState extends State<FocusableButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addListener(() => setState(() {}));
    _scale = Tween<double>(begin: 1, end: 1.05).animate(_animationController);
  }

  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      autofocus: widget.autofocus,
      focusColor: widget.focusColor ?? Theme.of(context).focusColor,
      focusNode: widget.focusNode,
      child: Transform.scale(
        scale: _scale.value,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.color == null
                ? widget.inverted
                    ? Colors.white70
                    : Colors.black54
                : widget.color,
            boxShadow: _isFocused && widget.focusColor == null
                ? [
                    BoxShadow(
                      color: widget.inverted ? Colors.white70 : Colors.black54,
                    ),
                  ]
                : null,
            image: widget.image == null
                ? null
                : DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
          ),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Stack(
              children: [
                if (widget.image != null && _isFocused)
                  Container(color: Colors.black87),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            widget.icon,
                            color: _isFocused
                                ? widget.inverted
                                    ? Colors.black87
                                    : Colors.white70
                                : widget.textColor ?? Colors.grey.shade600,
                            size: _isFocused ? 22 : 20,
                          ),
                        ),
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: _isFocused ? 20 : 18,
                          fontWeight: widget.fontWeight,
                          color: _isFocused
                              ? widget.inverted
                                  ? Colors.black87
                                  : Colors.white70
                              : widget.textColor ?? Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => widget.onTap(),
      onFocusChange: (isFocused) {
        _isFocused = isFocused;
        if (_isFocused)
          _animationController.forward();
        else
          _animationController.reverse();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
