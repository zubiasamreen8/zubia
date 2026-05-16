import 'package:http/http.dart' as http;
import 'package:zubia_portfolio/data/portfolio_data.dart';

class ContentService {
  static const String sheetId = '1zyLSb27TS0U5giS-RKZEMJxdz2kPjxbSyHeE8Qpmvco';

  static const String _metricsSheet = 'Metrics';
  static const String _caseStudiesSheet = 'CaseStudies';
  static const String _systemsSheet = 'Systems';
  static const String _skillsSheet = 'Skills';

  static Future<PortfolioContent> fetchContent() async {
    final defaults = PortfolioContent.defaults();

    if (sheetId == 'YOUR_GOOGLE_SHEET_ID_HERE') {
      return defaults;
    }

    try {
      final results = await Future.wait([
        _fetchSheet(_metricsSheet).catchError((_) => <List<String>>[]),
        _fetchSheet(_caseStudiesSheet).catchError((_) => <List<String>>[]),
        _fetchSheet(_systemsSheet).catchError((_) => <List<String>>[]),
        _fetchSheet(_skillsSheet).catchError((_) => <List<String>>[]),
      ]);

      final metrics = _parseMetrics(results[0]);
      final caseStudies = _parseCaseStudies(results[1]);
      final systems = _parseSystems(results[2], defaults.systems);
      final skills = _parseSkills(results[3]);

      return PortfolioContent(
        profile: defaults.profile,
        metrics: metrics.isNotEmpty ? metrics : defaults.metrics,
        caseStudies: caseStudies.isNotEmpty ? caseStudies : defaults.caseStudies,
        systems: systems.isNotEmpty ? systems : defaults.systems,
        skills: skills.isNotEmpty ? skills : defaults.skills,
      );
    } catch (e) {
      print('Error fetching content: $e');
      return defaults;
    }
  }

  static Future<List<List<String>>> _fetchSheet(String sheetName) async {
    final url =
        'https://docs.google.com/spreadsheets/d/$sheetId/gviz/tq?tqx=out:csv&sheet=$sheetName';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch $sheetName: ${response.statusCode}');
    }

    return _parseCsv(response.body);
  }

  static List<List<String>> _parseCsv(String content) {
    final lines = <List<String>>[];
    final rows = content.split('\n');

    for (final row in rows) {
      if (row.trim().isEmpty) continue;
      lines.add(_parseCsvRow(row));
    }

    return lines;
  }

  static List<String> _parseCsvRow(String row) {
    final cells = <String>[];
    var current = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < row.length; i++) {
      final char = row[i];

      if (char == '"') {
        if (inQuotes && i + 1 < row.length && row[i + 1] == '"') {
          current.write('"');
          i++;
        } else {
          inQuotes = !inQuotes;
        }
      } else if (char == ',' && !inQuotes) {
        cells.add(current.toString().trim());
        current = StringBuffer();
      } else {
        current.write(char);
      }
    }
    cells.add(current.toString().trim());

    return cells;
  }

  static List<MetricData> _parseMetrics(List<List<String>> data) {
    final metrics = <MetricData>[];

    for (final row in data.skip(1)) {
      if (row.length >= 2 && row[0].isNotEmpty) {
        metrics.add(MetricData(
          value: row[0],
          label: row[1].replaceAll('\\n', '\n'),
        ));
      }
    }

    return metrics;
  }

  static List<CaseStudyData> _parseCaseStudies(List<List<String>> data) {
    final caseStudies = <CaseStudyData>[];

    for (final row in data.skip(1)) {
      if (row.length >= 6 && row[0].isNotEmpty) {
        caseStudies.add(CaseStudyData(
          tag: row[0],
          problem: row[1],
          situation: row[2],
          action: row[3],
          result: row[4],
          impact: row[5],
        ));
      }
    }

    return caseStudies;
  }

  static List<SystemData> _parseSystems(
      List<List<String>> data, List<SystemData> defaults) {
    final systems = <SystemData>[];

    for (final row in data.skip(1)) {
      if (row.length >= 3 && row[0].isNotEmpty) {
        systems.add(SystemData(
          title: row[0],
          businessProblem: row[1],
          description: row[2],
        ));
      }
    }

    return systems;
  }

  static List<String> _parseSkills(List<List<String>> data) {
    final skills = <String>[];

    for (final row in data.skip(1)) {
      if (row.isNotEmpty && row[0].isNotEmpty) {
        skills.add(row[0]);
      }
    }

    return skills;
  }
}

class PortfolioContent {
  final ProfileData profile;
  final List<MetricData> metrics;
  final List<CaseStudyData> caseStudies;
  final List<SystemData> systems;
  final List<String> skills;

  const PortfolioContent({
    required this.profile,
    required this.metrics,
    required this.caseStudies,
    required this.systems,
    required this.skills,
  });

  factory PortfolioContent.defaults() => PortfolioContent(
        profile: ProfileData(
          name: PortfolioData.name,
          title: PortfolioData.title,
          tagline: PortfolioData.tagline,
          email: PortfolioData.email,
          linkedinUrl: PortfolioData.linkedinUrl,
          resumeUrl: PortfolioData.resumeUrl,
          profileImageUrl: PortfolioData.profileImageUrl,
        ),
        metrics: PortfolioData.metrics
            .map((m) => MetricData(value: m['value']!, label: m['label']!))
            .toList(),
        caseStudies: PortfolioData.caseStudies
            .map((cs) => CaseStudyData(
                  tag: cs.tag,
                  problem: cs.problem,
                  situation: cs.situation,
                  action: cs.action,
                  result: cs.result,
                  impact: cs.impact,
                ))
            .toList(),
        systems: PortfolioData.systems
            .map((s) => SystemData(
                  title: s.title,
                  businessProblem: s.businessProblem,
                  description: s.description,
                ))
            .toList(),
        skills: PortfolioData.skills,
      );
}

class ProfileData {
  final String name;
  final String title;
  final String tagline;
  final String email;
  final String linkedinUrl;
  final String resumeUrl;
  final String profileImageUrl;

  const ProfileData({
    required this.name,
    required this.title,
    required this.tagline,
    required this.email,
    required this.linkedinUrl,
    required this.resumeUrl,
    required this.profileImageUrl,
  });
}

class MetricData {
  final String value;
  final String label;

  const MetricData({required this.value, required this.label});
}

class CaseStudyData {
  final String tag;
  final String problem;
  final String situation;
  final String action;
  final String result;
  final String impact;

  const CaseStudyData({
    required this.tag,
    required this.problem,
    required this.situation,
    required this.action,
    required this.result,
    required this.impact,
  });
}

class SystemData {
  final String title;
  final String businessProblem;
  final String description;

  const SystemData({
    required this.title,
    required this.businessProblem,
    required this.description,
  });
}
