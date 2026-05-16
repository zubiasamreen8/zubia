import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import '../data/portfolio_data.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: AppTheme.pagePadding(context).left,
        right: AppTheme.pagePadding(context).right,
        top: isMobile ? 80 : 120,
        bottom: isMobile ? 64 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.border),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              PortfolioData.title.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    letterSpacing: 1.5,
                    fontSize: 11,
                    color: AppTheme.muted,
                  ),
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 28),

          // Name with gradient accent
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              PortfolioData.name,
              style: (isMobile
                      ? Theme.of(context).textTheme.displayMedium
                      : Theme.of(context).textTheme.displayLarge)
                  ?.copyWith(color: Colors.white),
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(
                begin: 0.1,
                end: 0,
                delay: 100.ms,
                duration: 500.ms,
              ),

          const SizedBox(height: 24),

          // Tagline
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              PortfolioData.tagline,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: isMobile ? 17 : 20,
                    color: AppTheme.accentLight,
                    height: 1.6,
                  ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

          const SizedBox(height: 44),

          // CTAs
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _PrimaryButton(
                label: "View LinkedIn",
                onTap: () => launchUrl(Uri.parse(PortfolioData.linkedinUrl)),
              ),
              _SecondaryButton(
                label: "Download Resume",
                onTap: () => launchUrl(Uri.parse(PortfolioData.resumeUrl)),
              ),
              _SecondaryButton(
                label: "Get in Touch",
                onTap: () =>
                    launchUrl(Uri.parse("mailto:${PortfolioData.email}")),
              ),
            ],
          ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppTheme.gradientStart.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppTheme.gradientStart.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
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

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SecondaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}
