import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jarvis_ai/providers/app_state_provider.dart';
import 'package:jarvis_ai/providers/settings_provider.dart';
import 'package:jarvis_ai/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _orbController;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _orbController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;
    final appState = context.read<AppStateProvider>();
    appState.addMessage('user', text.trim());
    _textController.clear();

    appState.setThinking(true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      appState.setThinking(false);
      appState.addMessage(
        'assistant',
        'All systems online, boss. Ready for your command.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF030402),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFFB347).withOpacity(0.6)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'J.A.R.V.I.S. 2.0',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFFFFB347),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF00FF66),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Color(0xFF00FF66), blurRadius: 6),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFFFFB347)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Holographic Orb Stage
            Expanded(
              flex: 4,
              child: Center(
                child: AnimatedBuilder(
                  animation: _orbController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: const Size(200, 200),
                      painter: JarvisHudPainter(
                        rotation: _orbController.value,
                        isListening: appState.isListening,
                        isThinking: appState.isThinking,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Chat Messages / Terminal Stream
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0D08),
                  border: Border.all(color: const Color(0xFFFFB347).withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: appState.messages.isEmpty
                    ? Center(
                        child: Text(
                          'AWAITING INPUT COMMAND...',
                          style: TextStyle(
                            fontFamily: 'ShareTechMono',
                            fontSize: 12,
                            color: const Color(0xFFFFB347).withOpacity(0.5),
                            letterSpacing: 2,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: appState.messages.length,
                        itemBuilder: (context, index) {
                          final msg = appState.messages[index];
                          final isUser = msg['role'] == 'user';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isUser ? '> USER: ' : '> JARVIS: ',
                                  style: TextStyle(
                                    fontFamily: 'ShareTechMono',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: isUser
                                        ? const Color(0xFF00E5FF)
                                        : const Color(0xFFFFB347),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    msg['text'] ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'ShareTechMono',
                                      fontSize: 12,
                                      color: Color(0xFFF8FAFC),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),

            // Command Input Bar & Mic Trigger
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(color: Colors.white, fontFamily: 'ShareTechMono'),
                      decoration: InputDecoration(
                        hintText: 'Enter command or question...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        filled: true,
                        fillColor: const Color(0xFF0D120A),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color(0xFFFFB347).withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFFFFB347)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                      onSubmitted: _handleSendMessage,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      appState.setListening(!appState.isListening);
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: appState.isListening
                            ? const Color(0xFFFF3366)
                            : const Color(0xFFFFB347),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: (appState.isListening
                                    ? const Color(0xFFFF3366)
                                    : const Color(0xFFFFB347))
                                .withOpacity(0.4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        appState.isListening ? Icons.mic : Icons.mic_none,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFFFFB347)),
                    onPressed: () => _handleSendMessage(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JarvisHudPainter extends CustomPainter {
  final double rotation;
  final bool isListening;
  final bool isThinking;

  JarvisHudPainter({
    required this.rotation,
    required this.isListening,
    required this.isThinking,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.8;

    final primaryColor = isListening
        ? const Color(0xFFFF3366)
        : (isThinking ? const Color(0xFF00E5FF) : const Color(0xFFFFB347));

    // Glow background
    final glowPaint = Paint()
      ..color = primaryColor.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(center, radius, glowPaint);

    // Orbiting rings
    final ringPaint = Paint()
      ..color = primaryColor.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius * 0.9, ringPaint);

    // Inner wireframe oval
    final innerPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * 2 * 3.14159);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: radius * 1.2, height: radius * 0.4),
      innerPaint,
    );
    canvas.rotate(1.57);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: radius * 1.2, height: radius * 0.4),
      innerPaint,
    );
    canvas.restore();

    // Central Core
    final corePaint = Paint()..color = primaryColor;
    canvas.drawCircle(center, radius * 0.12, corePaint);
  }

  @override
  bool shouldRepaint(covariant JarvisHudPainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.isListening != isListening ||
        oldDelegate.isThinking != isThinking;
  }
}
