import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:jarvis_ai/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _orbitAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _orbitAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030402),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Orb (simplified)
                    CustomPaint(
                      size: const Size(180, 180),
                      painter: SplashOrbPainter(
                        progress: _orbitAnimation.value,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'J.A.R.V.I.S.',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 8,
                        color: Color(0xFFFFF2C2),
                        shadows: [
                          Shadow(color: Color(0xFFFFB347), blurRadius: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Just A Rather Very Intelligent System',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 4,
                        color: Color(0xFFFFF2C2),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 160,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            const Color(0xFFFFB347).withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Initializing Systems...',
                      style: TextStyle(
                        fontFamily: 'ShareTechMono',
                        fontSize: 12,
                        color: Color(0xFFFFB347),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SplashOrbPainter extends CustomPainter {
  final double progress;

  SplashOrbPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.7;

    // Glow background
    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          const Color(0xFFFFB347).withOpacity(0.2),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 1.8));
    canvas.drawCircle(center, radius * 1.8, glowPaint);

    // Outer ring
    final ringPaint = Paint()
      ..color = const Color(0xFFFFB347)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(center, radius, ringPaint);

    // Rotating inner ring
    final innerPaint = Paint()
      ..color = const Color(0xFFFFB347).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(progress * 2 * math.pi);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: radius * 1.2, height: radius * 0.5),
      innerPaint,
    );
    canvas.restore();

    // Core dot
    final corePaint = Paint()
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(center, radius * 0.15, corePaint);

    // Pulsing dot
    final pulseFactor = 0.6 + 0.3 * (1 + math.sin(progress * 2 * math.pi));
    final pulsePaint = Paint()
      ..color = const Color(0xFFFFB347).withOpacity(pulseFactor.clamp(0.0, 1.0));
    canvas.drawCircle(center, radius * 0.08, pulsePaint);
  }

  @override
  bool shouldRepaint(covariant SplashOrbPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
