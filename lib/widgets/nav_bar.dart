import 'package:flutter/material.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final GlobalKey aboutKey;
  final GlobalKey caseStudiesKey;
  final GlobalKey systemsKey;
  final GlobalKey contactKey;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.aboutKey,
    required this.caseStudiesKey,
    required this.systemsKey,
    required this.contactKey,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isScrolled ? Colors.white : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: r.pagePadding.left,
        vertical: r.value(mobileSmall: 12.0, mobile: 14.0, tablet: 16.0),
      ),
      child: r.isMobileOrSmaller
          ? _buildMobileNav(context, r)
          : _buildDesktopNav(context, r),
    );
  }

  Widget _buildDesktopNav(BuildContext context, Responsive r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Logo(isScrolled: _isScrolled),
        Row(
          children: [
            _NavLink(
              label: "About",
              onTap: () => _scrollToSection(widget.aboutKey),
              isScrolled: _isScrolled,
            ),
            SizedBox(width: r.value(mobile: 20.0, tablet: 24.0, laptop: 32.0, desktop: 40.0)),
            _NavLink(
              label: "Case Studies",
              onTap: () => _scrollToSection(widget.caseStudiesKey),
              isScrolled: _isScrolled,
            ),
            SizedBox(width: r.value(mobile: 20.0, tablet: 24.0, laptop: 32.0, desktop: 40.0)),
            _NavLink(
              label: "Systems",
              onTap: () => _scrollToSection(widget.systemsKey),
              isScrolled: _isScrolled,
            ),
            SizedBox(width: r.value(mobile: 20.0, tablet: 24.0, laptop: 32.0, desktop: 40.0)),
            _NavLink(
              label: "Contact",
              onTap: () => _scrollToSection(widget.contactKey),
              isScrolled: _isScrolled,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context, Responsive r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Logo(isScrolled: _isScrolled, compact: true),
        _MobileMenuButton(
          isScrolled: _isScrolled,
          onAbout: () => _scrollToSection(widget.aboutKey),
          onCaseStudies: () => _scrollToSection(widget.caseStudiesKey),
          onSystems: () => _scrollToSection(widget.systemsKey),
          onContact: () => _scrollToSection(widget.contactKey),
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  final bool isScrolled;
  final bool compact;

  const _Logo({required this.isScrolled, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        "ZS",
        style: TextStyle(
          fontSize: compact ? 20 : 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isScrolled;

  const _NavLink({
    required this.label,
    required this.onTap,
    required this.isScrolled,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
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
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _hovering
                  ? AppTheme.gradientStart
                  : AppTheme.accent,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback onAbout;
  final VoidCallback onCaseStudies;
  final VoidCallback onSystems;
  final VoidCallback onContact;

  const _MobileMenuButton({
    required this.isScrolled,
    required this.onAbout,
    required this.onCaseStudies,
    required this.onSystems,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.menu,
        color: AppTheme.accent,
      ),
      onSelected: (value) {
        switch (value) {
          case 'about':
            onAbout();
            break;
          case 'case_studies':
            onCaseStudies();
            break;
          case 'systems':
            onSystems();
            break;
          case 'contact':
            onContact();
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'about', child: Text('About')),
        const PopupMenuItem(value: 'case_studies', child: Text('Case Studies')),
        const PopupMenuItem(value: 'systems', child: Text('Systems')),
        const PopupMenuItem(value: 'contact', child: Text('Contact')),
      ],
    );
  }
}
