import 'package:flutter/material.dart';

class SkipTimeDisplay extends StatefulWidget {
  final double time;

  SkipTimeDisplay(Key key, {@required this.time}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SkipTimeDisplayState();
  }
}

class _SkipTimeDisplayState extends State<SkipTimeDisplay> {
  bool _hide = false;

  int _timeInSeconds;

  int _hours, _minutes, _seconds;

  @override
  void initState() {
    super.initState();
    _timeInSeconds = widget.time.toInt();
    _hours = ((_timeInSeconds - (_timeInSeconds % 3600)) / 3600).round();
    final int minutesRemainder = _timeInSeconds - _hours * 3600;
    _minutes = ((minutesRemainder - (minutesRemainder % 60)) / 60).round();
    _seconds = (_timeInSeconds - _hours * 3600 - _minutes * 60).round();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) setState(() => _hide = true);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _hide ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      child: Stack(
        children: [
          Text(
            (_hours < 10 ? '0$_hours' : '$_hours') +
                ':' +
                (_minutes < 10 ? '0$_minutes' : '$_minutes') +
                ':' +
                (_seconds < 10 ? '0$_seconds' : '$_seconds'),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = Colors.black,
            ),
          ),
          Text(
            (_hours < 10 ? '0$_hours' : '$_hours') +
                ':' +
                (_minutes < 10 ? '0$_minutes' : '$_minutes') +
                ':' +
                (_seconds < 10 ? '0$_seconds' : '$_seconds'),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
