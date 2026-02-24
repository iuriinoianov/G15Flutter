import 'package:flutter/material.dart';

class Plate {
  final int number;

  Plate({
    required this.number,
  });

  Plate copyWith({
    int? number,
  }) {
    return Plate(
      number: number ?? this.number,
    );
  }
}

class G15ModelState {
  final List<Plate> plates;

  G15ModelState({
    this.plates = const <Plate>[],
  });
  factory G15ModelState.initial() {
    return G15ModelState(
      plates: List.generate(14, (index) => Plate(number: index)),
    );
  }

  G15ModelState copyWith({
    List<Plate>? plates,
  }) {
    return G15ModelState(
      plates: plates ?? this.plates,
    );
  }

}


class ViewModel extends ChangeNotifier {
  var _state = G15ModelState();

  G15ModelState get state => _state;
  set state(G15ModelState val) {
    _state = _state.copyWith(plates: val.plates);
    notifyListeners();
  }

}