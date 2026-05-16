import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';
import 'package:zubia_portfolio/services/content_provider.dart';
import 'package:zubia_portfolio/services/content_service.dart';
import 'package:zubia_portfolio/services/url_helper.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final profile = context.profile;
    final hasImage = profile.profileImageUrl.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: r.pagePadding.left,
        right: r.pagePadding.right,
        top: r.value(
          mobileSmall: 60.0,
          mobile: 72.0,
          tablet: 100.0,
          laptop: 120.0,
          desktop: 120.0,
        ),
        bottom: r.value(
          mobileSmall: 48.0,
          mobile: 56.0,
          tablet: 80.0,
          laptop: 100.0,
          desktop: 100.0,
        ),
      ),
      child: hasImage ? _buildWithImage(context, r, profile) : _buildTextOnly(context, r, profile),
    );
  }

  Widget _buildWithImage(BuildContext context, Responsive r, ProfileData profile) {
    // Stack vertically on mobile, side by side on larger screens
    if (r.isTabletOrSmaller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image first on mobile
          _ProfileImage(responsive: r, imageUrl: profile.profileImageUrl),
          SizedBox(height: r.value(mobileSmall: 32.0, mobile: 40.0, tablet: 48.0)),
          // Then content
          _HeroContent(responsive: r, profile: profile),
        ],
      );
    }

    // Side by side on desktop/laptop
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text on left
        Expanded(
          flex: 3,
          child: _HeroContent(responsive: r, profile: profile),
        ),
        SizedBox(width: r.value(mobile: 32.0, tablet: 40.0, laptop: 48.0, desktop: 64.0)),
        // Image on right
        Expanded(
          flex: 2,
          child: _ProfileImage(responsive: r, imageUrl: profile.profileImageUrl),
        ),
      ],
    );
  }

  Widget _buildTextOnly(BuildContext context, Responsive r, ProfileData profile) {
    return _HeroContent(responsive: r, profile: profile);
  }
}

class _ProfileImage extends StatelessWidget {
  final Responsive responsive;
  final String imageUrl;

  const _ProfileImage({required this.responsive, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final r = responsive;

    final imageSize = r.value(
      mobileSmall: r.width - (r.pagePadding.left * 2),
      mobile: r.width - (r.pagePadding.left * 2),
      tablet: 320.0,
      laptop: double.infinity,
      desktop: double.infinity,
    );

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: r.value(
            mobileSmall: 280.0,
            mobile: 320.0,
            tablet: 320.0,
            laptop: 360.0,
            desktop: 400.0,
          ),
          maxHeight: r.value(
            mobileSmall: 320.0,
            mobile: 360.0,
            tablet: 380.0,
            laptop: 420.0,
            desktop: 480.0,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            r.value(mobileSmall: 16.0, mobile: 20.0, tablet: 24.0),
          ),
          gradient: AppTheme.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppTheme.gradientStart.withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            r.value(mobileSmall: 12.0, mobile: 16.0, tablet: 20.0),
          ),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: imageSize,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: imageSize,
                height: imageSize,
                color: AppTheme.surface,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    strokeWidth: 2,
                    color: AppTheme.gradientStart,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: imageSize,
                height: imageSize,
                color: AppTheme.surface,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 64,
                      color: AppTheme.muted.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Image not found',
                      style: TextStyle(
                        color: AppTheme.muted.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          delay: 200.ms,
          duration: 600.ms,
          curve: Curves.easeOut,
        );
  }
}

class _HeroContent extends StatelessWidget {
  final Responsive responsive;
  final ProfileData profile;

  const _HeroContent({required this.responsive, required this.profile});

  @override
  Widget build(BuildContext context) {
    final r = responsive;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: r.value(mobileSmall: 10.0, mobile: 12.0, tablet: 12.0),
            vertical: r.value(mobileSmall: 5.0, mobile: 6.0, tablet: 6.0),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.border),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            profile.title.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  letterSpacing: 1.5,
                  fontSize: r.value(
                    mobileSmall: 9.0,
                    mobile: 10.0,
                    tablet: 11.0,
                    desktop: 11.0,
                  ),
                  color: AppTheme.muted,
                ),
          ),
        ).animate().fadeIn(duration: 400.ms),

        SizedBox(height: r.value(mobileSmall: 20.0, mobile: 24.0, tablet: 28.0)),

        // Name with gradient accent
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            profile.name,
            style: AppTheme.displayLarge(context)?.copyWith(color: Colors.white),
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(
              begin: 0.1,
              end: 0,
              delay: 100.ms,
              duration: 500.ms,
            ),

        SizedBox(height: r.value(mobileSmall: 16.0, mobile: 20.0, tablet: 24.0)),

        // Tagline
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: r.value(
              mobileSmall: double.infinity,
              mobile: double.infinity,
              tablet: 540.0,
              laptop: 500.0,
              desktop: 520.0,
            ),
          ),
          child: Text(
            profile.tagline,
            style: AppTheme.bodyLarge(context)?.copyWith(
                  fontSize: r.value(
                    mobileSmall: 15.0,
                    mobile: 16.0,
                    tablet: 18.0,
                    laptop: 18.0,
                    desktop: 20.0,
                  ),
                  color: AppTheme.accentLight,
                  height: 1.6,
                ),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

        SizedBox(height: r.value(mobileSmall: 32.0, mobile: 36.0, tablet: 44.0)),

        // CTAs
        _ResponsiveButtons(responsive: r, profile: profile),
      ],
    );
  }
}

class _ResponsiveButtons extends StatelessWidget {
  final Responsive responsive;
  final ProfileData profile;

  const _ResponsiveButtons({required this.responsive, required this.profile});

  @override
  Widget build(BuildContext context) {
    final r = responsive;

    // On very small screens, stack buttons vertically
    if (r.isMobileSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PrimaryButton(
            label: "View LinkedIn",
            onTap: () => UrlHelper.openLinkedIn(profile.linkedinUrl),
            compact: true,
          ),
          const SizedBox(height: 10),
          _SecondaryButton(
            label: "Download Resume",
            onTap: () => UrlHelper.openResume(profile.resumeUrl),
            compact: true,
          ),
          const SizedBox(height: 10),
          _GetInTouchDropdown(
            profile: profile,
            compact: true,
          ),
        ],
      ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
    }

    return Wrap(
      spacing: r.value(mobile: 10.0, tablet: 12.0),
      runSpacing: r.value(mobile: 10.0, tablet: 12.0),
      children: [
        _PrimaryButton(
          label: "View LinkedIn",
          onTap: () => UrlHelper.openLinkedIn(profile.linkedinUrl),
          compact: r.isMobile,
        ),
        _SecondaryButton(
          label: "Download Resume",
          onTap: () => UrlHelper.openResume(profile.resumeUrl),
          compact: r.isMobile,
        ),
        _GetInTouchDropdown(
          profile: profile,
          compact: r.isMobile,
        ),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool compact;

  const _PrimaryButton({
    required this.label,
    required this.onTap,
    this.compact = false,
  });

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
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 20 : 28,
            vertical: widget.compact ? 14 : 16,
          ),
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

class _GetInTouchDropdown extends StatelessWidget {
  final ProfileData profile;
  final bool compact;

  const _GetInTouchDropdown({
    required this.profile,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'whatsapp') {
          UrlHelper.openWhatsApp(profile.phone);
        } else if (value == 'email') {
          UrlHelper.openEmail(profile.email);
        }
      },
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
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
                  color: AppTheme.accent,
                  fontSize: compact ? 13 : 14,
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
                  color: AppTheme.accent,
                  fontSize: compact ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 18 : 24,
          vertical: compact ? 12 : 14,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Get in Touch",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: compact ? 13 : 14,
                  ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.keyboard_arrow_down, color: AppTheme.accent, size: 18),
          ],
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool compact;

  const _SecondaryButton({
    required this.label,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 18 : 24,
          vertical: compact ? 12 : 14,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: compact ? 13 : 14,
              ),
        ),
      ),
    );
  }
}
