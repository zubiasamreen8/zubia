class PortfolioData {
  static const String name = "Zubia Samreen";
  static const String title = "HR Operations Specialist";
  static const String tagline =
      "Startups scale when their people-ops work.\nI build the HR systems that make that happen.";
  static const String resumeUrl =
      "https://drive.google.com/file/d/1QxR8gs6LSpK_4qo78UI6Xp-n47M7z8Y3/view";
  static const String linkedinUrl =
      "https://www.linkedin.com/in/zubia-samreen-2a6644243/";
  static const String email = "zubiasamreen8@gmail.com";
  static const String phone = "+918700758622";
  static const String profileImageUrl = "assets/profile.jpg";

  static const List<Map<String, String>> metrics = [
    {"value": "3+", "label": "Years Building\nHR Systems"},
    {"value": "500+", "label": "Hires\nFacilitated"},
    {"value": "20%", "label": "Faster\nTime-to-Fill"},
    {"value": "25%", "label": "Engagement\nScore Lift"},
    {"value": "20–25", "label": "Hires/Month\nat Peak"},
  ];

  static const List<CaseStudy> caseStudies = [
    CaseStudy(
      tag: "Recruitment Operations",
      problem: "TribizIndia was losing weeks every time a role opened.",
      situation:
          "When I joined TribizIndia, there was no structured hiring process. Each department handled recruitment differently, roles stayed open for 35+ days on average, and leadership had no visibility into the pipeline.",
      action:
          "I designed a centralized recruitment framework — standardized JDs, a structured sourcing funnel, stage-wise interview process, and a live tracking dashboard. I also hired and mentored a team of 4–5 recruiters to execute this at scale.",
      result:
          "Time-to-fill dropped from 35 days to 28 days (20% reduction). The team consistently hired 20–25 people per month across departments without compromising on cultural fit.",
      impact: "Business was never blocked on headcount again.",
    ),
    CaseStudy(
      tag: "Employee Engagement",
      problem:
          "Low engagement was quietly increasing attrition risk at TribizIndia.",
      situation:
          "Employee satisfaction had no formal measurement. Grievances reached management late, and there was no structured channel between staff and leadership.",
      action:
          "Launched structured employee engagement programs, established a formal grievance mediation process, and conducted regular D&I and policy awareness sessions. Served as the active liaison between 100+ employees and senior leadership.",
      result:
          "Employee satisfaction scores improved by 25%. Attrition risk reduced. The work environment became measurably more positive and inclusive.",
      impact:
          "Leadership gained real-time visibility into employee sentiment for the first time.",
    ),
    CaseStudy(
      tag: "HR Ops from Zero",
      problem: "SSG Skills Arena had no HR infrastructure when I joined.",
      situation:
          "SSG was an early-stage company with no formal HR policies, inconsistent documentation, and no payroll coordination system in place.",
      action:
          "Built HR from the ground up — drafted and implemented core HR policies, created standardized offer letter formats, built attendance tracking systems in Excel, and coordinated payroll data through the Petpooja platform.",
      result:
          "Complete HR operational foundation built in under 6 months. Zero payroll errors through the period. Every employee had accurate, compliant documentation from day one.",
      impact: "The company moved from HR chaos to HR clarity — ready to scale.",
    ),
  ];

  static const List<SystemBuilt> systems = [
    SystemBuilt(
      title: "Recruitment Pipeline Framework",
      subtitle: "TribizIndia, 2023–2025",
      businessProblem: "Eliminated hiring blind spots for leadership",
      description:
          "End-to-end sourcing-to-onboarding workflow used across 3 departments. Includes JD templates, sourcing checklist, interview stage guide, and offer process.",
    ),
    SystemBuilt(
      title: "Payroll Coordination System",
      subtitle: "SSG Skills Arena, 2025–2026",
      businessProblem: "Zero salary errors for 6+ consecutive months",
      description:
          "Excel-based attendance and payroll data tracker integrated with Petpooja platform. Ensured timely, accurate salary processing with full audit trail.",
    ),
    SystemBuilt(
      title: "Onboarding & Exit Framework",
      subtitle: "TribizIndia, 2023–2025",
      businessProblem: "New hires productive faster, exits handled cleanly",
      description:
          "Structured onboarding flow covering documentation, induction, policy briefing, and role onboarding. Exit process covering F&F settlement, termination docs, and knowledge transfer.",
    ),
    SystemBuilt(
      title: "HR Policy Documentation Suite",
      subtitle: "SSG Skills Arena, 2025–2026",
      businessProblem: "Gave the organization a compliance backbone",
      description:
          "Core HR policies drafted from scratch — attendance, leave, code of conduct, offer letter formats — aligned with organizational and legal requirements.",
    ),
  ];

  static const List<String> skills = [
    "End-to-End Recruitment",
    "HR Operations",
    "Employee Lifecycle Management",
    "Payroll Coordination",
    "HR Policy Design",
    "Employee Relations",
    "Performance Management",
    "Training & Development",
    "Workforce Planning",
    "HRMS Technology",
    "MS Excel",
    "Stakeholder Management",
  ];
}

class CaseStudy {
  final String tag;
  final String problem;
  final String situation;
  final String action;
  final String result;
  final String impact;

  const CaseStudy({
    required this.tag,
    required this.problem,
    required this.situation,
    required this.action,
    required this.result,
    required this.impact,
  });
}

class SystemBuilt {
  final String title;
  final String subtitle;
  final String businessProblem;
  final String description;

  const SystemBuilt({
    required this.title,
    this.subtitle = '',
    required this.businessProblem,
    required this.description,
  });
}
