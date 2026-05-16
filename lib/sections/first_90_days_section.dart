import 'package:flutter/material.dart';
import 'package:zubia_portfolio/sections/case_studies_section.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';

class First90DaysSection extends StatelessWidget {
  const First90DaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

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
          const SectionLabel(label: "First 90 Days"),
          SizedBox(height: r.value(mobileSmall: 10.0, mobile: 12.0, tablet: 12.0)),
          Text(
            "What I'd do in your first 90 days",
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
          _buildTimeline(context, r),
          SizedBox(height: r.value(mobileSmall: 32.0, mobile: 40.0, tablet: 48.0)),
          _buildClosing(context, r),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, Responsive r) {
    final phases = [
      _Phase(
        days: "Days 1–30",
        title: "Understand before touching anything",
        description:
            "Map what exists. Interview every department head. Shadow the current HR process end-to-end. Identify the three highest-risk gaps — the things that will cause damage if left alone. Deliver a written diagnosis to leadership by day 30.",
      ),
      _Phase(
        days: "Days 31–60",
        title: "Fix the foundation",
        description:
            "Address the highest-risk gaps first. Build or standardize whatever is missing — whether that's a payroll process, an onboarding checklist, or a recruitment pipeline. Nothing flashy. Just solid.",
      ),
      _Phase(
        days: "Days 61–90",
        title: "Build for scale",
        description:
            "Once the foundation is stable, design for what comes next. What does HR need to look like when the company is 2x its current size? Build those systems now before growth makes it harder.",
      ),
    ];

    return Column(
      children: phases.asMap().entries.map((entry) {
        final index = entry.key;
        final phase = entry.value;
        final isLast = index == phases.length - 1;

        return _PhaseCard(
          phase: phase,
          isLast: isLast,
          compact: r.isMobileSmall,
        );
      }).toList(),
    );
  }

  Widget _buildClosing(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.value(mobileSmall: 20.0, mobile: 24.0, tablet: 28.0, laptop: 32.0, desktop: 32.0)),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "Every organization is different. But this is how I think about entering one. If you want to talk about what your first 90 days would actually look like — let's talk.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: r.value(mobileSmall: 14.0, mobile: 15.0, tablet: 16.0, laptop: 17.0, desktop: 17.0),
          fontWeight: FontWeight.w500,
          color: Colors.white,
          height: 1.7,
        ),
      ),
    );
  }
}

class _Phase {
  final String days;
  final String title;
  final String description;

  const _Phase({required this.days, required this.title, required this.description});
}

class _PhaseCard extends StatelessWidget {
  final _Phase phase;
  final bool isLast;
  final bool compact;

  const _PhaseCard({
    required this.phase,
    required this.isLast,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: compact ? 60 : 80,
            child: Column(
              children: [
                Container(
                  width: compact ? 12 : 16,
                  height: compact ? 12 : 16,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.gradientStart.withValues(alpha: 0.5),
                            AppTheme.gradientEnd.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : (compact ? 24 : 32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      phase.days,
                      style: TextStyle(
                        fontSize: compact ? 12 : 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: compact ? 6 : 8),
                  Text(
                    phase.title,
                    style: AppTheme.headlineMedium(context)?.copyWith(
                          fontSize: compact ? 16 : r.value(mobile: 17.0, tablet: 18.0, laptop: 19.0, desktop: 19.0),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(height: compact ? 10 : 14),
                  Text(
                    phase.description,
                    style: AppTheme.bodyMedium(context)?.copyWith(
                          fontSize: compact ? 13 : r.value(mobile: 14.0, tablet: 14.0, laptop: 15.0, desktop: 15.0),
                          height: 1.7,
                          color: AppTheme.accentLight,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
