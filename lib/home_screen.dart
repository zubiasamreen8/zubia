import 'package:flutter/material.dart';
import 'sections/hero_section.dart';
import 'sections/metrics_section.dart';
import 'sections/case_studies_section.dart';
import 'sections/systems_section.dart';
import 'sections/skills_contact_section.dart';
import 'widgets/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeroSection(),
            MetricsSection(),
            CaseStudiesSection(),
            SystemsSection(),
            SkillsSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}
