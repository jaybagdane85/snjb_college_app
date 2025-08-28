import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart'; // Make sure this path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );
  late final AnimationController _textController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );

  late final Animation<double> _logoFade = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));
  late final Animation<double> _logoScale = Tween(begin: 0.8, end: 1.0).animate(
    CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
  );
  late final Animation<double> _textFade = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
  late final Animation<double> _textScale = Tween(
    begin: 0.8,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOutBack));

  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );
  late final Animation<double> _pulseAnimation = Tween(begin: 1.0, end: 1.1)
      .chain(CurveTween(curve: Curves.easeInOut))
      .animate(_pulseController);

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _startAnimations();
    _pulseController.repeat(reverse: true);
  }

  Future<void> _startAnimations() async {
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF7E00FF),  // Updated background color here
        child: Column(
          children: [
            const Spacer(),

            // Logo animation
            FadeTransition(
              opacity: _logoFade,
              child: ScaleTransition(
                scale: _logoScale,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/snjblogo1.png',
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Title with pulse scale animation and horizontal padding
            FadeTransition(
              opacity: _textFade,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: child,
                    );
                  },
                  child: const Text(
                    'SNJB K.B.J COE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 32,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'College Management System',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 90),

            // Loader animation
            FadeTransition(
              opacity: _logoFade,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ),

            const Spacer(),

            // Footer college name
            FadeTransition(
              opacity: _textFade,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  "SNJB's Late Sau Kantabai Bhavarlalji Jain\nCollege of Engineering",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.white60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
