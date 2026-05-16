import 'package:flutter/material.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';
import 'package:zubia_portfolio/services/content_provider.dart';
import 'package:zubia_portfolio/services/content_service.dart';
import 'package:zubia_portfolio/services/url_helper.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final skills = context.skills;

    // Don't show section if no skills
    if (skills.isEmpty) return const SizedBox.shrink();

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
          Text(
            "Core Expertise".toUpperCase(),
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
          ),
          SizedBox(height: r.value(mobileSmall: 24.0, mobile: 28.0, tablet: 32.0)),
          Wrap(
            spacing: r.value(mobileSmall: 8.0, mobile: 10.0, tablet: 10.0),
            runSpacing: r.value(mobileSmall: 8.0, mobile: 10.0, tablet: 10.0),
            children: skills
                .map((skill) => _SkillChip(label: skill, compact: r.isMobileSmall))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  final bool compact;

  const _SkillChip({required this.label, this.compact = false});

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
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 12 : 14,
            vertical: widget.compact ? 6 : 8,
          ),
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
                          fontSize: widget.compact ? 11 : 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )
              : Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: widget.compact ? 11 : 13,
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
    final r = context.responsive;
    final profile = context.profile;

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            r.isMobileSmall
                ? "Let's talk about what you need to build."
                : "Let's talk about\nwhat you need to build.",
            textAlign: TextAlign.center,
            style: AppTheme.displaySmall(context)?.copyWith(
                  color: Colors.white,
                  fontSize: r.value(
                    mobileSmall: 24.0,
                    mobile: 28.0,
                    tablet: 32.0,
                    laptop: 36.0,
                    desktop: 36.0,
                  ),
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
          ),
          SizedBox(height: r.value(mobileSmall: 12.0, mobile: 14.0, tablet: 16.0)),
          Text(
            r.isMobileSmall
                ? "Open to HR Operations and HR Executive roles in startups and growing organizations."
                : "Open to HR Operations and HR Executive roles\nin startups and growing organizations.",
            textAlign: TextAlign.center,
            style: AppTheme.bodyMedium(context)?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: r.value(
                    mobileSmall: 13.0,
                    mobile: 14.0,
                    tablet: 15.0,
                    desktop: 15.0,
                  ),
                  height: 1.6,
                ),
          ),
          SizedBox(height: r.value(mobileSmall: 28.0, mobile: 32.0, tablet: 40.0)),
          _buildContactButtons(context, r, profile),
          SizedBox(height: r.value(mobileSmall: 40.0, mobile: 48.0, tablet: 60.0)),
          Divider(color: Colors.white.withValues(alpha: 0.15)),
          SizedBox(height: r.value(mobileSmall: 18.0, mobile: 20.0, tablet: 24.0)),
          Text(
            "© ${DateTime.now().year} ${profile.name}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: r.value(mobileSmall: 11.0, mobile: 12.0, tablet: 12.0),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButtons(BuildContext context, Responsive r, ProfileData profile) {
    if (r.isMobileSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GetInTouchDropdown(
            profile: profile,
            compact: true,
          ),
          const SizedBox(height: 10),
          _ContactButton(
            label: "LinkedIn Profile",
            onTap: () => UrlHelper.openLinkedIn(profile.linkedinUrl),
            isOutline: true,
            compact: true,
          ),
        ],
      );
    }

    return Wrap(
      spacing: r.value(mobile: 10.0, tablet: 12.0),
      runSpacing: r.value(mobile: 10.0, tablet: 12.0),
      children: [
        _GetInTouchDropdown(
          profile: profile,
          compact: r.isMobile,
        ),
        _ContactButton(
          label: "LinkedIn Profile",
          onTap: () => UrlHelper.openLinkedIn(profile.linkedinUrl),
          isOutline: true,
          compact: r.isMobile,
        ),
      ],
    );
  }
}

class _GetInTouchDropdown extends StatefulWidget {
  final ProfileData profile;
  final bool compact;

  const _GetInTouchDropdown({
    required this.profile,
    this.compact = false,
  });

  @override
  State<_GetInTouchDropdown> createState() => _GetInTouchDropdownState();
}

class _GetInTouchDropdownState extends State<_GetInTouchDropdown> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'whatsapp') {
          UrlHelper.openWhatsApp(widget.profile.phone);
        } else if (value == 'email') {
          UrlHelper.openEmail(widget.profile.email);
        }
      },
      offset: const Offset(0, -100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(0xFF1A1A2E),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'whatsapp',
          child: Row(
            children: [
              Image.asset('assets/whatsapp.png', width: 20, height: 20),
              const SizedBox(width: 12),
              Text(
                'WhatsApp',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: widget.compact ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'email',
          child: Row(
            children: [
              Image.asset('assets/gmail.png', width: 20, height: 20),
              const SizedBox(width: 12),
              Text(
                'Gmail',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: widget.compact ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ],
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 20 : 28,
            vertical: widget.compact ? 14 : 16,
          ),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.gradientStart.withValues(alpha: _hovering ? 0.5 : 0.3),
                blurRadius: _hovering ? 24 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Get in Touch",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontSize: widget.compact ? 13 : 14,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutline;
  final bool compact;

  const _ContactButton({
    required this.label,
    required this.onTap,
    required this.isOutline,
    this.compact = false,
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
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 20 : 28,
            vertical: widget.compact ? 14 : 16,
          ),
          decoration: BoxDecoration(
            gradient: widget.isOutline ? null : AppTheme.primaryGradient,
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
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontSize: widget.compact ? 13 : 14,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
