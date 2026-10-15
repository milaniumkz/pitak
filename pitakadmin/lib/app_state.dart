import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _support = prefs.getString('ff_support')?.ref ?? _support;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<DocumentReference> _favorites = [];
  List<DocumentReference> get favorites => _favorites;
  set favorites(List<DocumentReference> value) {
    _favorites = value;
  }

  void addToFavorites(DocumentReference value) {
    favorites.add(value);
  }

  void removeFromFavorites(DocumentReference value) {
    favorites.remove(value);
  }

  void removeAtIndexFromFavorites(int index) {
    favorites.removeAt(index);
  }

  void updateFavoritesAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    favorites[index] = updateFn(_favorites[index]);
  }

  void insertAtIndexInFavorites(int index, DocumentReference value) {
    favorites.insert(index, value);
  }

  List<DocumentReference> _resultSearch = [];
  List<DocumentReference> get resultSearch => _resultSearch;
  set resultSearch(List<DocumentReference> value) {
    _resultSearch = value;
  }

  void addToResultSearch(DocumentReference value) {
    resultSearch.add(value);
  }

  void removeFromResultSearch(DocumentReference value) {
    resultSearch.remove(value);
  }

  void removeAtIndexFromResultSearch(int index) {
    resultSearch.removeAt(index);
  }

  void updateResultSearchAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    resultSearch[index] = updateFn(_resultSearch[index]);
  }

  void insertAtIndexInResultSearch(int index, DocumentReference value) {
    resultSearch.insert(index, value);
  }

  bool _filter = false;
  bool get filter => _filter;
  set filter(bool value) {
    _filter = value;
  }

  bool _addVideo = false;
  bool get addVideo => _addVideo;
  set addVideo(bool value) {
    _addVideo = value;
  }

  int _summa = 0;
  int get summa => _summa;
  set summa(int value) {
    _summa = value;
  }

  bool _top = false;
  bool get top => _top;
  set top(bool value) {
    _top = value;
  }

  bool _color = false;
  bool get color => _color;
  set color(bool value) {
    _color = value;
  }

  Color _topColor = Color(4289975244);
  Color get topColor => _topColor;
  set topColor(Color value) {
    _topColor = value;
  }

  Color _colorColor = Color(4289975244);
  Color get colorColor => _colorColor;
  set colorColor(Color value) {
    _colorColor = value;
  }

  DocumentReference? _support =
      FirebaseFirestore.instance.doc('/users/jYUX4UribwgvpPEyssJFmyyFQFw1');
  DocumentReference? get support => _support;
  set support(DocumentReference? value) {
    _support = value;
    value != null
        ? prefs.setString('ff_support', value.path)
        : prefs.remove('ff_support');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}
