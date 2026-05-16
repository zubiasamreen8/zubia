import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import 'package:zubia_portfolio/widgets/responsive.dart';
import 'package:zubia_portfolio/services/content_provider.dart';
import 'package:zubia_portfolio/services/content_service.dart';

class MetricsSection extends StatefulWidget {
  const MetricsSection({super.key});

  @override
  State<MetricsSection> createState() => _MetricsSectionState();
}

class _MetricsSectionState extends State<MetricsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final metrics = context.metrics;

    // Don't show section if no metrics
    if (metrics.isEmpty) return const SizedBox.shrink();

    return VisibilityDetector(
      key: const Key('metrics'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppTheme.subtleGradient,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: r.pagePadding.left,
          vertical: r.value(
            mobileSmall: 40.0,
            mobile: 48.0,
            tablet: 56.0,
            laptop: 60.0,
            desktop: 60.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Business Outcomes",
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
            _buildMetricsGrid(context, r, metrics),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context, Responsive r, List<MetricData> metrics) {
    // For very small screens, show single column
    if (r.isMobileSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < metrics.length; i++) ...[
            _MetricTile(
              metric: metrics[i],
              visible: _visible,
              delay: i * 80,
              compact: true,
            ),
            if (i < metrics.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(height: 1, color: AppTheme.border),
              ),
          ],
        ],
      );
    }

    // For mobile, show 2x2 grid
    if (r.isMobile) {
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        children: [
          for (int i = 0; i < metrics.length; i++)
            SizedBox(
              width: (r.width - r.pagePadding.left - r.pagePadding.right - 24) / 2,
              child: _MetricTile(
                metric: metrics[i],
                visible: _visible,
                delay: i * 80,
                compact: true,
              ),
            ),
        ],
      );
    }

    // For tablet, show 2x2 grid with more spacing
    if (r.isTablet) {
      return Wrap(
        spacing: 40,
        runSpacing: 32,
        children: [
          for (int i = 0; i < metrics.length; i++)
            SizedBox(
              width: (r.width - r.pagePadding.left - r.pagePadding.right - 40) / 2,
              child: _MetricTile(
                metric: metrics[i],
                visible: _visible,
                delay: i * 80,
              ),
            ),
        ],
      );
    }

    // Desktop: horizontal row with dividers
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0; i < metrics.length; i++) ...[
          if (i > 0)
            Container(
              width: 1,
              height: 60,
              color: AppTheme.border,
              margin: EdgeInsets.symmetric(
                horizontal: r.value(mobile: 24.0, tablet: 28.0, laptop: 32.0, desktop: 40.0),
              ),
            ),
          _MetricTile(
            metric: metrics[i],
            visible: _visible,
            delay: i * 80,
          ),
        ]
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  final MetricData metric;
  final bool visible;
  final int delay;
  final bool compact;

  const _MetricTile({
    required this.metric,
    required this.visible,
    required this.delay,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500 + delay),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, 0.2),
        duration: Duration(milliseconds: 500 + delay),
        curve: Curves.easeOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                metric.value,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: compact
                          ? r.value(mobileSmall: 28.0, mobile: 32.0)
                          : r.value(mobile: 32.0, tablet: 34.0, laptop: 36.0, desktop: 38.0),
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(height: compact ? 4 : 6),
            Text(
              metric.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    fontSize: compact
                        ? r.value(mobileSmall: 11.0, mobile: 12.0)
                        : r.value(mobile: 12.0, tablet: 12.0, laptop: 13.0, desktop: 13.0),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
