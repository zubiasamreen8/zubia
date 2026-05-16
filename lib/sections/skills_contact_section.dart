import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import '../data/portfolio_data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
          Text(
            "Core Expertise".toUpperCase(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  letterSpacing: 1.5,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.muted,
                ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: PortfolioData.skills
                .map((skill) => _SkillChip(label: skill))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: _hovering ? AppTheme.primaryGradient : null,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: _hovering ? null : Border.all(color: AppTheme.border),
            borderRadius: BorderRadius.circular(100),
          ),
          child: _hovering
              ? ShaderMask(
                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )
              : Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppTheme.accentLight,
                        fontWeight: FontWeight.w500,
                      ),
                ),
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppTheme.pagePadding(context);
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
            Color(0xFF0F3460),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: padding.left,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's talk about\nwhat you need to build.",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            "Open to HR Operations and HR Executive roles\nin startups and growing organizations.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 15,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ContactButton(
                label: PortfolioData.email,
                onTap: () => launchUrl(
                  Uri.parse("mailto:${PortfolioData.email}"),
                ),
                isOutline: false,
              ),
              _ContactButton(
                label: "LinkedIn Profile",
                onTap: () => launchUrl(
                  Uri.parse(PortfolioData.linkedinUrl),
                ),
                isOutline: true,
              ),
            ],
          ),
          const SizedBox(height: 60),
          Divider(color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 24),
          Text(
            "© ${DateTime.now().year} ${PortfolioData.name}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutline;

  const _ContactButton({
    required this.label,
    required this.onTap,
    required this.isOutline,
  });

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.isOutline
                ? null
                : AppTheme.primaryGradient,
            border: widget.isOutline
                ? Border.all(
                    color: _hovering
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.3),
                  )
                : null,
            borderRadius: BorderRadius.circular(8),
            boxShadow: widget.isOutline
                ? null
                : [
                    BoxShadow(
                      color: AppTheme.gradientStart.withValues(alpha: _hovering ? 0.5 : 0.3),
                      blurRadius: _hovering ? 24 : 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
