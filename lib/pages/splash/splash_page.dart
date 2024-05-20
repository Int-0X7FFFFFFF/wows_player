import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeApp();
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => MainPage()),
      // );
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
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/Icon.png",
                  width: 150,
                  height: 150,
                ),
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * 3.1415926535897932,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _initializeApp() async {}
}
