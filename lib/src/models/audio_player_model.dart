import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;
  AnimationController _controller;
  Duration _songDuration = new Duration(milliseconds: 0);
  Duration _current = new Duration(milliseconds: 0);


  String get songTotalDuration => this.printDuration(this._songDuration);
  String get currentSecond => this.printDuration(this._current);


  double get percent => (this._songDuration.inSeconds > 0)
      ? this._current.inSeconds / this._songDuration.inSeconds
      : 0;

  set controller(AnimationController controller) {
    this._controller = controller;
  }

  AnimationController get controller => this._controller;

  bool get playing => this._playing;

  Duration get songDuration => _songDuration;

  Duration get current => _current;

  set playing(bool playing) {
    this._playing = playing;
    notifyListeners();
  }

  set songDuration(Duration duration) {
    this._songDuration = duration;
    notifyListeners();
  }

  set current(Duration duration) {
    this._current = duration;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitsSeconds";
  }


}
