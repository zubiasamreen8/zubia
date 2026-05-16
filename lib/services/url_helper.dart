import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> openLinkedIn(String linkedinUrl) async {
    if (kIsWeb) {
      await launchUrl(Uri.parse(linkedinUrl), mode: LaunchMode.externalApplication);
    } else {
      final username = _extractLinkedInUsername(linkedinUrl);
      final appUri = Uri.parse('linkedin://profile/$username');
      final webUri = Uri.parse(linkedinUrl);

      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri);
      } else {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    }
  }

  static String _extractLinkedInUsername(String url) {
    final uri = Uri.parse(url);
    final path = uri.path;
    if (path.startsWith('/in/')) {
      return path.substring(4).replaceAll('/', '');
    }
    return path.replaceAll('/', '');
  }

  static Future<void> openEmail(String email) async {
    const subject = "Hey, let's connect";
    final encodedSubject = Uri.encodeComponent(subject);

    if (kIsWeb) {
      final gmailUrl = 'https://mail.google.com/mail/?view=cm&fs=1&to=$email&su=$encodedSubject';
      await launchUrl(Uri.parse(gmailUrl), mode: LaunchMode.externalApplication);
    } else {
      final mailtoUri = Uri.parse('mailto:$email?subject=$encodedSubject');
      await launchUrl(mailtoUri);
    }
  }

  static Future<void> openResume(String resumeUrl) async {
    await launchUrl(Uri.parse(resumeUrl), mode: LaunchMode.externalApplication);
  }
}
