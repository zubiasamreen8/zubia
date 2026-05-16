import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zubia_portfolio/widgets/app_theme.dart';
import '../data/portfolio_data.dart';

class MetricsSection extends StatefulWidget {
  const MetricsSection({super.key});

  @override
  State<MetricsSection> createState() => _MetricsSectionState();
}

class _MetricsSectionState extends State<MetricsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

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
          horizontal: AppTheme.pagePadding(context).left,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Business Outcomes",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    letterSpacing: 1.5,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.muted,
                  ),
            ),
            const SizedBox(height: 32),
            isMobile ? _mobileGrid(context) : _desktopRow(context),
          ],
        ),
      ),
    );
  }

  Widget _desktopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0; i < PortfolioData.metrics.length; i++) ...[
          if (i > 0)
            Container(
              width: 1,
              height: 60,
              color: AppTheme.border,
              margin: const EdgeInsets.symmetric(horizontal: 40),
            ),
          _MetricTile(
            metric: PortfolioData.metrics[i],
            visible: _visible,
            delay: i * 80,
          ),
        ]
      ],
    );
  }

  Widget _mobileGrid(BuildContext context) {
    return Wrap(
      spacing: 32,
      runSpacing: 32,
      children: [
        for (int i = 0; i < PortfolioData.metrics.length; i++)
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            child: _MetricTile(
              metric: PortfolioData.metrics[i],
              visible: _visible,
              delay: i * 80,
            ),
          ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  final Map<String, String> metric;
  final bool visible;
  final int delay;

  const _MetricTile({
    required this.metric,
    required this.visible,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
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
                metric["value"]!,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              metric["label"]!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
