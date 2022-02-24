import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  Duration _songDuration = new Duration(milliseconds: 0);
  Duration _current = new Duration(milliseconds: 0);
  String get songTotalDuration => this.printDuration(songDuration);
  String get currentSecond => this.printDuration(current);
  double get porcentaje => (this._songDuration.inSeconds > 0)
      ? this._current.inSeconds / this._songDuration.inSeconds
      : 0;

  bool _playing = false;
  late AnimationController _controller;
  set controller(AnimationController value) {
    this._controller = value;
  }

  AnimationController get controller => this._controller;

  bool get playing => this._playing;
  set playing(bool valor) {
    this._playing = valor;
    notifyListeners();
  }

  Duration get songDuration => this._songDuration;
  Duration get current => this._current;
  set songDuration(Duration value) {
    this._songDuration = value;
    notifyListeners();
  }

  set current(Duration value) {
    this._current = value;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitsMinutos = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitsMinutos:$twoDigitsSeconds";
  }
}
