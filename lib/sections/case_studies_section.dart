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

// Visual steps/layers data for each case study
const Map<String, List<_StepData>> _caseStudySteps = {
  'Recruitment Operations': [
    _StepData('Layer 1', 'Job Definition', 'Created standardized JD templates for every department. Each JD had a must-have vs nice-to-have split so screening became objective, not gut-feel.'),
    _StepData('Layer 2', 'Sourcing Funnel', 'Built a structured sourcing checklist — LinkedIn, Naukri, internal referrals, and college hiring in priority order based on role level.'),
    _StepData('Layer 3', 'Interview Architecture', 'Defined 3-stage interview process — HR screening → technical/functional round → culture fit. Each stage had a scorecard.'),
    _StepData('Layer 4', 'Pipeline Tracker', 'Built a live Excel dashboard tracking every open role — candidate name, stage, interviewer, feedback status, expected offer date.'),
    _StepData('Final', 'Team Building', 'Hired and mentored a team of 4–5 recruiters. Each recruiter owned specific departments. Daily 15-minute standups.'),
  ],
  'Employee Engagement': [
    _StepData('Part 1', 'Formal Grievance Process', 'Created a documented grievance path. Employee raises concern → HR logs it → resolution within 5 working days → outcome communicated back.'),
    _StepData('Part 2', 'Structured Engagement', 'Monthly townhalls, quarterly one-on-ones, anonymous pulse surveys every two months, D&I and policy awareness sessions.'),
    _StepData('Part 3', 'Becoming the Bridge', 'Positioned as the trusted point of contact between 100+ employees and senior leadership. Mediated disputes, escalated what needed escalating.'),
  ],
  'HR Ops from Zero': [
    _StepData('Week 1–2', 'Payroll Foundation', 'Built Excel-based attendance tracker. Integrated with Petpooja platform. Defined monthly payroll calendar — data cutoff, processing, transfer dates.'),
    _StepData('Month 1', 'Documentation Standards', 'Created master offer letter template. Built employee record system — one folder per employee, standardized documents at each lifecycle stage.'),
    _StepData('Month 2', 'Policy Suite', 'Drafted core HR policies — attendance, leave, code of conduct, grievance policy. Got reviewed, approved, and circulated with signed acknowledgement.'),
    _StepData('Month 3–6', 'Lifecycle Ownership', 'Owned end-to-end recruitment, structured onboarding, and all exits — resignation, notice period, Full & Final settlement coordination.'),
  ],
  'Building Structured HR Operations': [
    _StepData('Week 1–2', 'Payroll Foundation', 'Built Excel-based attendance tracker. Integrated with Petpooja platform. Defined monthly payroll calendar — data cutoff, processing, transfer dates.'),
    _StepData('Month 1', 'Documentation Standards', 'Created master offer letter template. Built employee record system — one folder per employee, standardized documents at each lifecycle stage.'),
    _StepData('Month 2', 'Policy Suite', 'Drafted core HR policies — attendance, leave, code of conduct, grievance policy. Got reviewed, approved, and circulated with signed acknowledgement.'),
    _StepData('Month 3–6', 'Lifecycle Ownership', 'Owned end-to-end recruitment, structured onboarding, and all exits — resignation, notice period, Full & Final settlement coordination.'),
  ],
  'SSG': [
    _StepData('Week 1–2', 'Payroll Foundation', 'Built Excel-based attendance tracker. Integrated with Petpooja platform. Defined monthly payroll calendar — data cutoff, processing, transfer dates.'),
    _StepData('Month 1', 'Documentation Standards', 'Created master offer letter template. Built employee record system — one folder per employee, standardized documents at each lifecycle stage.'),
    _StepData('Month 2', 'Policy Suite', 'Drafted core HR policies — attendance, leave, code of conduct, grievance policy. Got reviewed, approved, and circulated with signed acknowledgement.'),
    _StepData('Month 3–6', 'Lifecycle Ownership', 'Owned end-to-end recruitment, structured onboarding, and all exits — resignation, notice period, Full & Final settlement coordination.'),
  ],
};

class _StepData {
  final String label;
  final String title;
  final String description;
  const _StepData(this.label, this.title, this.description);
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

  List<_StepData>? _getStepsForCaseStudy(String tag) {
    for (final key in _caseStudySteps.keys) {
      if (tag.contains(key)) {
        return _caseStudySteps[key];
      }
    }
    return null;
  }

  Widget _buildStepsRoadmap(BuildContext context, String tag, bool isCompact, Responsive r) {
    final steps = _getStepsForCaseStudy(tag);
    if (steps == null || steps.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "THE FRAMEWORK".toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: isCompact ? 9 : 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppTheme.muted,
              ),
        ),
        SizedBox(height: isCompact ? 14 : 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isLast = index == steps.length - 1;

              return Row(
                children: [
                  _StepCard(step: step, index: index, compact: isCompact),
                  if (!isLast)
                    Container(
                      width: isCompact ? 20 : 32,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
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
                          SizedBox(height: isCompact ? 20 : 28),
                          _buildStepsRoadmap(context, cs.tag, isCompact, r),
                          SizedBox(height: isCompact ? 20 : 28),
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

class _StepCard extends StatelessWidget {
  final _StepData step;
  final int index;
  final bool compact;

  const _StepCard({
    required this.step,
    required this.index,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: compact ? 220 : 260,
      padding: EdgeInsets.all(compact ? 12 : 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.gradientStart.withValues(alpha: 0.08),
            AppTheme.gradientEnd.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.gradientStart.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              step.label,
              style: TextStyle(
                fontSize: compact ? 10 : 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: compact ? 6 : 8),
          Text(
            step.title,
            style: TextStyle(
              fontSize: compact ? 13 : 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.accent,
              height: 1.3,
            ),
          ),
          SizedBox(height: compact ? 8 : 10),
          Text(
            step.description,
            style: TextStyle(
              fontSize: compact ? 11 : 12,
              fontWeight: FontWeight.w400,
              color: AppTheme.accentLight,
              height: 1.5,
            ),
          ),
        ],
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
