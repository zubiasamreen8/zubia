import 'package:flutter/material.dart';
import 'package:zubia_portfolio/sections/case_studies_section.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';
import 'package:zubia_portfolio/services/content_provider.dart';
import 'package:zubia_portfolio/services/content_service.dart';

class SystemsSection extends StatelessWidget {
  const SystemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final systems = context.systems;

    // Don't show section if no systems
    if (systems.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.subtleGradient,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: r.pagePadding.left,
        vertical: r.value(
          mobileSmall: 48.0,
          mobile: 56.0,
          tablet: 72.0,
          laptop: 80.0,
          desktop: 80.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel(label: "Systems Built"),
          SizedBox(height: r.value(mobileSmall: 10.0, mobile: 12.0, tablet: 12.0)),
          Text(
            r.isMobileSmall
                ? "Tangible HR infrastructure delivered to each organization."
                : "Tangible HR infrastructure\ndelivered to each organization.",
            style: AppTheme.displaySmall(context)?.copyWith(
                  fontSize: r.value(
                    mobileSmall: 20.0,
                    mobile: 22.0,
                    tablet: 24.0,
                    laptop: 26.0,
                    desktop: 26.0,
                  ),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
          ),
          SizedBox(height: r.value(mobileSmall: 32.0, mobile: 40.0, tablet: 48.0)),
          _buildSystemsGrid(context, r, systems),
        ],
      ),
    );
  }

  Widget _buildSystemsGrid(BuildContext context, Responsive r, List<SystemData> systems) {
    // Single column for mobile
    if (r.isMobileOrSmaller) {
      return Column(
        children: systems
            .map(
              (s) => Padding(
                padding: EdgeInsets.only(
                  bottom: r.value(mobileSmall: 12.0, mobile: 14.0),
                ),
                child: _SystemCard(system: s, compact: r.isMobileSmall),
              ),
            )
            .toList(),
      );
    }

    // Two columns for tablet and up
    return Column(
      children: [
        for (int i = 0; i < systems.length; i += 2)
          Padding(
            padding: EdgeInsets.only(
              bottom: r.value(mobile: 14.0, tablet: 14.0, laptop: 16.0, desktop: 16.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _SystemCard(system: systems[i])),
                SizedBox(width: r.value(mobile: 14.0, tablet: 14.0, laptop: 16.0, desktop: 16.0)),
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
}

class _SystemCard extends StatefulWidget {
  final SystemData system;
  final bool compact;

  const _SystemCard({required this.system, this.compact = false});

  @override
  State<_SystemCard> createState() => _SystemCardState();
}

class _SystemCardState extends State<_SystemCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

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
          padding: EdgeInsets.all(
            widget.compact
                ? 16
                : r.value(mobile: 20.0, tablet: 22.0, laptop: 24.0, desktop: 24.0),
          ),
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
                style: AppTheme.headlineMedium(context)?.copyWith(
                      fontSize: widget.compact
                          ? 14
                          : r.value(mobile: 15.0, tablet: 15.0, laptop: 16.0, desktop: 16.0),
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: widget.compact ? 8 : 10),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.compact ? 8 : 10,
                  vertical: widget.compact ? 4 : 5,
                ),
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
                          fontSize: widget.compact ? 10 : 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              SizedBox(height: widget.compact ? 10 : 14),
              Text(
                widget.system.description,
                style: AppTheme.bodyMedium(context)?.copyWith(
                      fontSize: widget.compact
                          ? 12
                          : r.value(mobile: 13.0, tablet: 13.0, laptop: 14.0, desktop: 14.0),
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
