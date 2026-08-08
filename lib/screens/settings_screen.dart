import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jarvis_ai/providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _openAiCtrl;
  late TextEditingController _geminiCtrl;
  late TextEditingController _anthropicCtrl;
  late TextEditingController _braveCtrl;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsProvider>();
    _openAiCtrl = TextEditingController(text: settings.openAiKey);
    _geminiCtrl = TextEditingController(text: settings.geminiKey);
    _anthropicCtrl = TextEditingController(text: settings.anthropicKey);
    _braveCtrl = TextEditingController(text: settings.braveKey);
  }

  @override
  void dispose() {
    _openAiCtrl.dispose();
    _geminiCtrl.dispose();
    _anthropicCtrl.dispose();
    _braveCtrl.dispose();
    super.dispose();
  }

  void _saveSettings() {
    final settings = context.read<SettingsProvider>();
    settings.updateKeys(
      openAi: _openAiCtrl.text.trim(),
      gemini: _geminiCtrl.text.trim(),
      anthropic: _anthropicCtrl.text.trim(),
      brave: _braveCtrl.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings Saved Successfully!'),
        backgroundColor: Color(0xFFFFB347),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030402),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'J.A.R.V.I.S. CONFIGURATION',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Color(0xFFFFB347),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildKeyField('Google Gemini API Key', _geminiCtrl),
          const SizedBox(height: 14),
          _buildKeyField('OpenAI API Key', _openAiCtrl),
          const SizedBox(height: 14),
          _buildKeyField('Anthropic Claude Key', _anthropicCtrl),
          const SizedBox(height: 14),
          _buildKeyField('Brave Search API Key', _braveCtrl),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB347),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: _saveSettings,
            child: const Text(
              'SAVE SETTINGS',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'ShareTechMono',
            fontSize: 12,
            color: Color(0xFFFFB347),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: true,
          style: const TextStyle(color: Colors.white, fontFamily: 'ShareTechMono'),
          decoration: InputDecoration(
            hintText: 'Enter $label...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
            filled: true,
            fillColor: const Color(0xFF0D120A),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFFFFB347).withOpacity(0.4)),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFB347)),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }
}
