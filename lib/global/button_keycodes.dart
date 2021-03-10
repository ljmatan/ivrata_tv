enum Buttons { up, down, left, right, center, ffr, ffw, playPause }

extension KeyCodes on Buttons {
  int get code {
    switch (this) {
      case Buttons.up:
        return 19;
      case Buttons.down:
        return 20;
      case Buttons.left:
        return 21;
      case Buttons.right:
        return 22;
      case Buttons.center:
        return 23;
      case Buttons.ffr:
        return 89;
      case Buttons.ffw:
        return 0;
      case Buttons.playPause:
        return 85;
      default:
        return null;
    }
  }
}
