import 'package:flutter/material.dart';
import 'package:zubia_portfolio/sections/case_studies_section.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import '../data/portfolio_data.dart';

class SystemsSection extends StatelessWidget {
  const SystemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final padding = AppTheme.pagePadding(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.subtleGradient,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: padding.left,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: "Systems Built"),
          const SizedBox(height: 12),
          Text(
            "Tangible HR infrastructure\ndelivered to each organization.",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 48),
          isMobile ? _mobileList(context) : _desktopGrid(context),
        ],
      ),
    );
  }

  Widget _desktopGrid(BuildContext context) {
    final systems = PortfolioData.systems;
    return Column(
      children: [
        for (int i = 0; i < systems.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(child: _SystemCard(system: systems[i])),
                const SizedBox(width: 16),
                if (i + 1 < systems.length)
                  Expanded(child: _SystemCard(system: systems[i + 1]))
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
      ],
    );
  }

  Widget _mobileList(BuildContext context) {
    return Column(
      children: PortfolioData.systems
          .map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _SystemCard(system: s),
            ),
          )
          .toList(),
    );
  }
}

class _SystemCard extends StatefulWidget {
  final SystemBuilt system;
  const _SystemCard({required this.system});

  @override
  State<_SystemCard> createState() => _SystemCardState();
}

class _SystemCardState extends State<_SystemCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(_hovering ? 2 : 0),
        decoration: BoxDecoration(
          gradient: _hovering ? AppTheme.primaryGradient : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: _hovering ? null : Border.all(color: AppTheme.border),
            borderRadius: BorderRadius.circular(_hovering ? 6 : 8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.system.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.gradientStart.withValues(alpha: 0.1),
                      AppTheme.gradientEnd.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    "↗ ${widget.system.businessProblem}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                widget.system.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      height: 1.65,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
