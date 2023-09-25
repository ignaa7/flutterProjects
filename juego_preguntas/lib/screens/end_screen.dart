import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EndScreen extends StatefulWidget {
  final String player;

  const EndScreen(this.player, {super.key});

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String url =
        'https://lottie.host/fb2586d3-88ef-426c-8a91-20b9fd12fe45/wLEeSKJkUV.json';

    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
            child: Column(
              children: [
                Text('¡${widget.player} ha ganado!'),
                const SizedBox(height: 100),
                Lottie.network(url, controller: _animationController,
                    onLoaded: (composition) {
                  _animationController
                    ..duration = composition.duration
                    ..forward()
                    ..repeat();
                }),
              ],
            )),
      ),
    );
  }
}
