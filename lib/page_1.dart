import 'package:flutter/material.dart';

import 'page_2.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  double scaleFactor = 1.0;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: scale,
          child: Transform.scale(
            scale: scaleFactor,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 40,
              child: Visibility(
                visible: isVisible,
                child: const Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  scale() async {
    setState(() {
      isVisible = false;
    });
    for (var i = 0; i < 200; i++) {
      await Future.delayed(const Duration(milliseconds: 1), () {
        setState(
          () {
            scaleFactor += 0.15;
          },
        );
      });
    }

    Navigator.of(context).push(_createRoute()).then((value) async => {
      for (var i = 0; i < 200; i++) {
        await Future.delayed(const Duration(milliseconds: 1), () {
          setState(
            () {
              scaleFactor -= 0.15;
            },
          );
        })
      },
      setState(() {
        isVisible = true;
      })
    });
  }
  
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        final curevedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return ScaleTransition(
          scale: curevedAnimation,
          child: child,
        );
      },
    );
  }
}
