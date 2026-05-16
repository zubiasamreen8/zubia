import 'package:flutter/material.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import '../data/portfolio_data.dart';

class CaseStudiesSection extends StatelessWidget {
  const CaseStudiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppTheme.pagePadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding.left,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel(label: "Case Studies"),
          const SizedBox(height: 12),
          Text(
            "Real problems. Real systems. Measurable results.",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
          ),
          const SizedBox(height: 48),
          ...PortfolioData.caseStudies.map(
            (cs) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _CaseStudyCard(caseStudy: cs),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseStudyCard extends StatefulWidget {
  final CaseStudy caseStudy;
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
              padding: const EdgeInsets.all(28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tag
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
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
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.tagText,
                                  letterSpacing: 0.5,
                                ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Problem statement
                        Text(
                          cs.problem,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppTheme.muted,
                      size: 22,
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
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StoryBlock(
                          label: "Situation",
                          content: cs.situation,
                        ),
                        const SizedBox(height: 20),
                        _StoryBlock(
                          label: "What I Did",
                          content: cs.action,
                        ),
                        const SizedBox(height: 20),
                        _StoryBlock(
                          label: "Result",
                          content: cs.result,
                        ),
                        const SizedBox(height: 24),
                        // Impact callout
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 3,
                                height: 40,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(2)),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: ShaderMask(
                                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
                                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                                  ),
                                  child: Text(
                                    cs.impact,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
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

  const _StoryBlock({required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppTheme.muted,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 15,
                height: 1.7,
              ),
        ),
      ],
    );
  }
}

class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            letterSpacing: 1.5,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.muted,
          ),
    );
  }
}
