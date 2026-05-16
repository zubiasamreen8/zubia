import 'package:flutter/material.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';
import 'package:zubia_portfolio/services/content_provider.dart';
import 'package:zubia_portfolio/services/content_service.dart';

class CaseStudiesSection extends StatelessWidget {
  const CaseStudiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final caseStudies = context.caseStudies;

    // Don't show section if no case studies
    if (caseStudies.isEmpty) return const SizedBox.shrink();

    return Padding(
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
          const SectionLabel(label: "Case Studies"),
          SizedBox(height: r.value(mobileSmall: 10.0, mobile: 12.0, tablet: 12.0)),
          Text(
            "Real problems. Real systems. Measurable results.",
            style: AppTheme.displaySmall(context)?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: r.value(
                    mobileSmall: 20.0,
                    mobile: 22.0,
                    tablet: 24.0,
                    laptop: 26.0,
                    desktop: 26.0,
                  ),
                ),
          ),
          SizedBox(height: r.value(mobileSmall: 32.0, mobile: 40.0, tablet: 48.0)),
          ...caseStudies.map(
            (cs) => Padding(
              padding: EdgeInsets.only(
                bottom: r.value(mobileSmall: 14.0, mobile: 16.0, tablet: 20.0),
              ),
              child: _CaseStudyCard(caseStudy: cs),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseStudyCard extends StatefulWidget {
  final CaseStudyData caseStudy;
  const _CaseStudyCard({required this.caseStudy});

  @override
  State<_CaseStudyCard> createState() => _CaseStudyCardState();
}

class _CaseStudyCardState extends State<_CaseStudyCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (_expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = widget.caseStudy;
    final r = context.responsive;
    final isCompact = r.isMobileSmall;

    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: _expanded ? AppTheme.primaryGradient : null,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(_expanded ? 2 : 0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.background,
            border: _expanded ? null : Border.all(color: AppTheme.border),
            borderRadius: BorderRadius.circular(_expanded ? 6 : 8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header — always visible
              Padding(
                padding: EdgeInsets.all(
                  isCompact ? 18 : r.value(mobile: 22.0, tablet: 26.0, laptop: 28.0, desktop: 28.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tag
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isCompact ? 8 : 10,
                              vertical: isCompact ? 3 : 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.tag,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              cs.tag,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: isCompact ? 10 : 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.tagText,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ),
                          SizedBox(height: isCompact ? 10 : 14),
                          // Problem statement
                          Text(
                            cs.problem,
                            style: AppTheme.headlineMedium(context)?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: isCompact
                                      ? 15
                                      : r.value(mobile: 16.0, tablet: 17.0, laptop: 18.0, desktop: 18.0),
                                  height: 1.4,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: isCompact ? 12 : 16),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppTheme.muted,
                        size: isCompact ? 20 : 22,
                      ),
                    ),
                  ],
                ),
              ),

              // Expanded content
              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Column(
                  children: [
                    Container(height: 1, color: AppTheme.border),
                    Padding(
                      padding: EdgeInsets.all(
                        isCompact ? 18 : r.value(mobile: 22.0, tablet: 26.0, laptop: 28.0, desktop: 28.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StoryBlock(
                            label: "Situation",
                            content: cs.situation,
                            compact: isCompact,
                          ),
                          SizedBox(height: isCompact ? 16 : 20),
                          _StoryBlock(
                            label: "What I Did",
                            content: cs.action,
                            compact: isCompact,
                          ),
                          SizedBox(height: isCompact ? 16 : 20),
                          _StoryBlock(
                            label: "Result",
                            content: cs.result,
                            compact: isCompact,
                          ),
                          SizedBox(height: isCompact ? 18 : 24),
                          // Impact callout
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(isCompact ? 14 : 18),
                            decoration: BoxDecoration(
                              color: AppTheme.surface,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 3,
                                  height: isCompact ? 32 : 40,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(2)),
                                  ),
                                ),
                                SizedBox(width: isCompact ? 10 : 14),
                                Expanded(
                                  child: ShaderMask(
                                    shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
                                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                    ),
                                    child: Text(
                                      cs.impact,
                                      style: AppTheme.bodyLarge(context)?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: isCompact ? 13 : 15,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryBlock extends StatelessWidget {
  final String label;
  final String content;
  final bool compact;

  const _StoryBlock({
    required this.label,
    required this.content,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: compact ? 9 : 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppTheme.muted,
              ),
        ),
        SizedBox(height: compact ? 6 : 8),
        Text(
          content,
          style: AppTheme.bodyLarge(context)?.copyWith(
                fontSize: compact ? 13 : 15,
                height: 1.7,
              ),
        ),
      ],
    );
  }
}

class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            letterSpacing: 1.5,
            fontSize: r.value(
              mobileSmall: 10.0,
              mobile: 11.0,
              tablet: 11.0,
            ),
            fontWeight: FontWeight.w600,
            color: AppTheme.muted,
          ),
    );
  }
}
