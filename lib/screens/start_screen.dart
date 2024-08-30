import 'package:flutter/material.dart';
import 'package:linch_mafia_test/theme/bg_painter.dart';
import 'package:linch_mafia_test/widgets/standard_button.dart';
import 'package:bordered_text/bordered_text.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const FlutterLogo(size: 100),
              const SizedBox(height: 20),
              const Text(
                'LinchMafia',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Localizations.override(
                // ! FIX: Wrap each text block, mb will help =)
                context: context,
                locale: const Locale('ru'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MStandardButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/roles",
                        );
                      },
                      text: 'Play with Host',
                    ),
                    const SizedBox(width: 20),
                    Stack(
                      children: [
                        const MStandardButton(
                          text: 'Play without Host',
                          isActive: false,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 200,
                            height: 30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/coming-soon.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: BorderedText(
                                strokeWidth: 1.0,
                                strokeColor: Colors.black,
                                child: const Text(
                                  'Comming soon',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationStyle: TextDecorationStyle.wavy,
                                    decorationColor: Colors.red,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
