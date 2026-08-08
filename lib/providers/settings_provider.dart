import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  String _openAiKey = '';
  String _anthropicKey = '';
  String _geminiKey = '';
  String _braveKey = '';
  String _newsApiKey = '';
  String _shodanKey = '';
  String _selectedProvider = 'gemini';

  String get openAiKey => _openAiKey;
  String get anthropicKey => _anthropicKey;
  String get geminiKey => _geminiKey;
  String get braveKey => _braveKey;
  String get newsApiKey => _newsApiKey;
  String get shodanKey => _shodanKey;
  String get selectedProvider => _selectedProvider;

  void setProvider(String provider) {
    _selectedProvider = provider;
    notifyListeners();
  }

  void updateKeys({
    String? openAi,
    String? anthropic,
    String? gemini,
    String? brave,
    String? newsApi,
    String? shodan,
  }) {
    if (openAi != null) _openAiKey = openAi;
    if (anthropic != null) _anthropicKey = anthropic;
    if (gemini != null) _geminiKey = gemini;
    if (brave != null) _braveKey = brave;
    if (newsApi != null) _newsApiKey = newsApi;
    if (shodan != null) _shodanKey = shodan;
    notifyListeners();
  }
}
