import 'package:flutter/material.dart';
import 'content_service.dart';

class ContentProvider extends InheritedWidget {
  final PortfolioContent content;
  final bool isLoading;
  final String? error;

  const ContentProvider({
    super.key,
    required this.content,
    required this.isLoading,
    this.error,
    required super.child,
  });

  static ContentProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContentProvider>();
  }

  static ContentProvider of(BuildContext context) {
    final provider = maybeOf(context);
    assert(provider != null, 'No ContentProvider found in context');
    return provider!;
  }

  static PortfolioContent contentOf(BuildContext context) {
    return of(context).content;
  }

  @override
  bool updateShouldNotify(ContentProvider oldWidget) {
    return content != oldWidget.content ||
        isLoading != oldWidget.isLoading ||
        error != oldWidget.error;
  }
}

class ContentLoader extends StatefulWidget {
  final Widget child;
  final Widget? loadingWidget;

  const ContentLoader({
    super.key,
    required this.child,
    this.loadingWidget,
  });

  @override
  State<ContentLoader> createState() => _ContentLoaderState();
}

class _ContentLoaderState extends State<ContentLoader> {
  PortfolioContent _content = PortfolioContent.defaults();
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      final content = await ContentService.fetchContent();
      if (mounted) {
        setState(() {
          _content = content;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentProvider(
      content: _content,
      isLoading: _isLoading,
      error: _error,
      child: widget.child,
    );
  }
}

extension ContentExtension on BuildContext {
  PortfolioContent get content => ContentProvider.contentOf(this);
  ProfileData get profile => content.profile;
  List<MetricData> get metrics => content.metrics;
  List<CaseStudyData> get caseStudies => content.caseStudies;
  List<SystemData> get systems => content.systems;
  List<String> get skills => content.skills;
  bool get isContentLoading => ContentProvider.of(this).isLoading;
}
