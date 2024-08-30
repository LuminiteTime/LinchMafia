import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linch_mafia_test/screens/distribution_screen.dart';
import 'package:linch_mafia_test/screens/roles_screen.dart';
import 'package:linch_mafia_test/screens/start_screen.dart';

void main() {
  runApp(const ProviderScope(child: LinchMafiaApp()));
}

class LinchMafiaApp extends StatelessWidget {
  const LinchMafiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinchMafia',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'RobotoMono',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'), // TODO: Хз, пока не работает =(
      ],
      initialRoute: "/",
      routes: {
        '/': (context) => const MainScreen(),
        '/roles': (context) => const RolesScreen(),
        '/distribution': (context) => const DistributionCardScreen(),
      },
    );
  }
}
