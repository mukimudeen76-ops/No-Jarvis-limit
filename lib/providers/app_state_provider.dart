import 'package:flutter/foundation.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isListening = false;
  bool _isThinking = false;
  String _lastSpokenText = '';
  List<Map<String, String>> _messages = [];

  bool get isListening => _isListening;
  bool get isThinking => _isThinking;
  String get lastSpokenText => _lastSpokenText;
  List<Map<String, String>> get messages => _messages;

  Future<void> init() async {
    _messages = [];
    notifyListeners();
  }

  void setListening(bool val) {
    _isListening = val;
    notifyListeners();
  }

  void setThinking(bool val) {
    _isThinking = val;
    notifyListeners();
  }

  void addMessage(String role, String text) {
    _messages.add({'role': role, 'text': text});
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
