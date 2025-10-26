import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (!appState.isLoggedIn) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/auth'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bambifix Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              appState.logout();
              Navigator.pushReplacementNamed(context, '/auth');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section with Marquee Images
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  child: MarqueeImages(),
                ),
                const SizedBox(height: 20),
                // Navigation Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/request'),
                        child: const Text('Make a Service Request'),
                        style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/messaging'),
                        child: const Text('Messages'),
                        style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                      ),
                      if (appState.userRole == UserRole.provider) ...[
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/provider_panel'),
                          child: const Text('Provider Panel'),
                          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MarqueeImages extends StatefulWidget {
  const MarqueeImages({super.key});

  @override
  State<MarqueeImages> createState() => _MarqueeImagesState();
}

class _MarqueeImagesState extends State<MarqueeImages> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  final List<String> _images = [
    'assets/images/service1.png', // Add your images here
    'assets/images/service2.png',
    'assets/images/service3.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Row(
        children: _images.map((image) => Expanded(
          child: Image.asset(image, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image)),
        )).toList(),
      ),
    );
  }
}