import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'widgets/app_theme.dart';
import 'services/content_provider.dart';

void main() {
  runApp(const ZubiaPortfolioApp());
}

class ZubiaPortfolioApp extends StatelessWidget {
  const ZubiaPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zubia Samreen — HR Operations Specialist',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const ContentLoader(
        child: HomeScreen(),
      ),
    );
  }
}
