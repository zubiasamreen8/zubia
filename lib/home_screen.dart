import 'package:flutter/material.dart';
import 'sections/hero_section.dart';
import 'sections/metrics_section.dart';
import 'sections/case_studies_section.dart';
import 'sections/systems_section.dart';
import 'sections/skills_contact_section.dart';
import 'widgets/app_theme.dart';
import 'widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _caseStudiesKey = GlobalKey();
  final GlobalKey _systemsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(key: _aboutKey, child: const HeroSection()),
                const MetricsSection(),
                Container(key: _caseStudiesKey, child: const CaseStudiesSection()),
                Container(key: _systemsKey, child: const SystemsSection()),
                const SkillsSection(),
                Container(key: _contactKey, child: const ContactSection()),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              aboutKey: _aboutKey,
              caseStudiesKey: _caseStudiesKey,
              systemsKey: _systemsKey,
              contactKey: _contactKey,
            ),
          ),
        ],
      ),
    );
  }
}
