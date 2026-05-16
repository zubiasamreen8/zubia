import 'package:flutter/material.dart';
import 'package:zubia_portfolio/sections/case_studies_section.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';

class HowIWorkSection extends StatelessWidget {
  const HowIWorkSection({super.key});

  static const List<_WorkCard> _cards = [
    _WorkCard(
      title: "I build before I manage",
      description:
          "Most HR professionals inherit systems and maintain them. I've spent 3 years building systems that didn't exist — from JD templates to payroll trackers to grievance frameworks. I'm most useful in environments where HR needs to be created, not just administered.",
    ),
    _WorkCard(
      title: "I speak in business outcomes",
      description:
          "HR work is invisible until something breaks. I make it visible — by measuring what matters, reporting to leadership in their language (headcount velocity, attrition risk, time-to-fill), and tying every HR initiative to a business result.",
    ),
    _WorkCard(
      title: "I work best in startups",
      description:
          "Not because large companies are bad — but because in a startup, HR decisions directly affect whether the company can grow. That urgency suits how I think. I've operated with full autonomy, zero playbook, and a mandate to figure it out. I know what that feels like and I'm good at it.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
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
          const SectionLabel(label: "How I Work"),
          SizedBox(height: r.value(mobileSmall: 10.0, mobile: 12.0, tablet: 12.0)),
          Text(
            "What you get when you hire me.",
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
          _buildCards(context, r),
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context, Responsive r) {
    if (r.isMobileOrSmaller) {
      return Column(
        children: _cards
            .map((card) => Padding(
                  padding: EdgeInsets.only(bottom: r.value(mobileSmall: 12.0, mobile: 14.0)),
                  child: _WorkCardWidget(card: card, compact: r.isMobileSmall),
                ))
            .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _cards
          .map((card) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: card == _cards.last ? 0 : 16),
                  child: _WorkCardWidget(card: card),
                ),
              ))
          .toList(),
    );
  }
}

class _WorkCard {
  final String title;
  final String description;

  const _WorkCard({required this.title, required this.description});
}

class _WorkCardWidget extends StatefulWidget {
  final _WorkCard card;
  final bool compact;

  const _WorkCardWidget({required this.card, this.compact = false});

  @override
  State<_WorkCardWidget> createState() => _WorkCardWidgetState();
}

class _WorkCardWidgetState extends State<_WorkCardWidget> {
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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(
            widget.compact ? 20 : r.value(mobile: 24.0, tablet: 28.0, laptop: 32.0, desktop: 32.0),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: _hovering ? null : Border.all(color: AppTheme.border),
            borderRadius: BorderRadius.circular(_hovering ? 10 : 12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.card.title,
                style: AppTheme.headlineMedium(context)?.copyWith(
                      fontSize: widget.compact ? 16 : r.value(mobile: 17.0, tablet: 18.0, laptop: 18.0, desktop: 18.0),
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(height: widget.compact ? 12 : 16),
              Text(
                widget.card.description,
                style: AppTheme.bodyMedium(context)?.copyWith(
                      fontSize: widget.compact ? 13 : r.value(mobile: 14.0, tablet: 14.0, laptop: 15.0, desktop: 15.0),
                      height: 1.7,
                      color: AppTheme.accentLight,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
