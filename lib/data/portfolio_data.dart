import '../models/project.dart';
import '../models/experience.dart';
import '../models/about_card.dart';
import '../constants/assets.dart';
import '../constants/strings.dart';

class PortfolioData {
  // ===== PERSONAL INFORMATION =====
  // Using AppStrings instead of duplicating
  static const String name = AppStrings.heroName;
  static const String title = AppStrings.heroTitle;
  static const String subtitle = AppStrings.heroSubtitle;
  static const String tagline =
      "Transforming concepts into seamless user experiences";
  static const String description = AppStrings.heroDescription;
  static const String location = 'Remote, Worldwide';
  static const String availability = "Available for new opportunities";

  // ===== CONTACT INFORMATION =====
  static const String email = 'abbasv0786@gmail.com';
  static const String phone = '+919714907429';
  static const String whatsapp = '+919714907429';
  static const String discord = 'abbasv786';
  static const String telegram = '@AbbasV0786';
  static const String linkedin =
      'https://www.linkedin.com/in/ahemadabbas-vagh-b9a080171';
  static const String twitter = 'https://twitter.com/AhemadAbbasVagh';
  static const String instagram = 'https://www.instagram.com/ahemadabbasvagh';

  static const String portfolioName = 'AhemadAbbas A Vagh';
  static const String footerDescription =
      'Passionate developer creating innovative digital solutions. Let\'s build something amazing together.';

  static const String footerCopyright =
      '© 2025 AhemadAbbas Vagh. All rights reserved.';

  // ===== TECHNICAL SKILLS =====
  // Skills are managed directly in AboutController's techCategories

  // ===== EXPERIENCE DATA =====
  static const List<Experience> experiences = [
    Experience(
      company: "Independent Software Engineer",
      position: "Senior Software Engineer",
      duration: "Jul 2023 - Present",
      description: """
- Leading the design and development of cross-platform mobile applications using Flutter and Dart, delivering custom, high-performance solutions for clients across various industries.
- Building and maintaining scalable backend services with Node.js and MongoDB, ensuring seamless integration between mobile apps and cloud infrastructure.
- Engineering intelligent, AI-powered features using Python, PyTorch, and Firebase, including on-device inference and personalized user experiences.
- Implementing Generative AI capabilities using OpenAI APIs, LangChain, and LLMs, including RAG pipelines, fine-tuned models, and AI-driven chat interfaces.
- Automating workflows and data pipelines using n8n to support AI operations and mobile tasks.
- Managing release processes for the App Store and Google Play, ensuring smooth deployment and version control.
""",
      technologies: [
        "Flutter",
        "Dart",
        "iOS",
        "Swift",
        "Firebase",
        "Node.js",
        "MongoDB",
        "TypeScript",
        "Python",
        "PyTorch",
        "OpenAI APIs",
        "LangChain",
        "Generative AI",
        "Fine-tuning",
        "LLM",
        "RAG",
        "N8N",
      ],
      companyUrl: "",
      location: "Remote",
      type: "Full-time",
    ),
    Experience(
      company: "Ecosmob Technologies",
      position: "Senior Software Engineer",
      duration: "Aug 2021 - Jul 2023",
      description: """
- Led the development and maintenance of cross-platform mobile applications using Flutter, Dart, React Native, Cordova, and Ionic, delivering tailored solutions for clients in multiple industries.
- Engineered and optimized native iOS applications with Swift and Objective-C, incorporating advanced features such as VOIP, geolocation tracking, and social media integration.
- Worked in a collaborative, agile environment with designers, developers, and project managers to ensure high-quality app delivery within deadlines and budget constraints.
- Participated in code reviews, contributing to the continuous improvement of code quality, architecture, and team knowledge sharing.
- Oversaw the app deployment lifecycle, including release management for the App Store and Google Play, ensuring smooth launches and timely updates.
""",
      technologies: [
        "Flutter",
        "Dart",
        "Cordova",
        "React Native",
        "iOS",
        "Swift",
        "VOIP",
        "Objective-C",
        "Ionic",
        "Firebase",
      ],
      companyUrl: "https://www.ecosmob.com/",
      location: "Remote",
      type: "Full-time",
    ),
    Experience(
      company: "Green Apex Technolabs",
      position: "Software Engineer",
      duration: "Nov 2020 - Aug 2021",
      description: """
- Developed and maintained cross-platform mobile applications for clients in a variety of industries, focusing on performance, usability, and scalability.
- Contributed to the design and implementation of key features, including geolocation tracking and social media integration.
- Collaborated with a team of developers to ensure timely delivery of high-quality applications within project scope and budget.
- Participated in code reviews to maintain code quality and shared best practices with team members.
- Managed the deployment and release process for both iOS and Android platforms, including submission to the App Store and Google Play.
""",
      technologies: [
        "Flutter",
        "Dart",
        "iOS",
        "Swift",
        "Unity",
        "Firebase",
      ],
      companyUrl: "https://www.green-apex.com/",
      location: "Hybrid",
      type: "Full-time",
    ),
    Experience(
      company: "Codal System Pvt Ltd",
      position: "Software Engineer",
      duration: "Jan 2018 - Nov 2020",
      description: """
- Developed and maintained high-performance iOS applications for clients across diverse industries, ensuring optimal functionality and user experience.
- Collaborated closely with UI/UX designers and project managers to deliver feature-rich mobile solutions on time and within budget.
- Contributed to the full app lifecycle, from concept and development to deployment and post-launch support.
""",
      technologies: [
        "iOS",
        "Swift",
        "Objective-C",
        "Cocoapods",
        "Firebase",
      ],
      companyUrl: "https://codal.com/",
      location: "Office",
      type: "Full-time",
    ),
  ];

  // ===== PROJECTS DATA =====
  static final List<Project> projects = [
    const Project(
      title: "Diar24",
      description:
          "Diar24 is the ultimate app for managing your real estate needs—renting, selling, or co-owning properties. Customize your app easily, share listings across platforms, and manage your properties on the go with complete security. Accessible on both smartphones and websites, Diar24 is your pocket marketplace for exceptional deals in Tunisia.",
      imageUrl: AppAssets.diar24Url,
      technologies: ["Flutter", "Dart", "Firebase", "Firestore", "Rest APIs"],
      androidUrl:
          "https://play.google.com/store/apps/details?id=com.diar24.app",
      category: "Flutter",
    ),
    const Project(
      title: "Grand Prix Tours",
      description:
          "The Grand Prix Tours app keeps your entire trip organized in one place. Access your travel program, trip details, accommodation info, tips, and real-time messages from your tour guide—all at your fingertips.",
      imageUrl: AppAssets.gptUrl,
      technologies: ["Flutter", "Dart", "Firebase", "Rest APIs"],
      androidUrl:
          "https://play.google.com/store/apps/details?id=com.gptour.app",
      iOSUrl: "https://apps.apple.com/us/app/grand-prix-tours/id6661033279",
      category: "Flutter",
    ),
    const Project(
      title: "LK Fiber",
      description:
          "The LK Fiber App simplifies agreements and tasks for Fiber Internet (FTTH). Complete agreements, capture signatures, document installations with photos and map drawings, and generate PDFs. Syncs seamlessly with the LK Web portal (portal.lkfiber.dk) and works online or offline. Requires an LK Fiber agreement.",
      imageUrl: AppAssets.lkUrl,
      technologies: ["Flutter", "Dart", "Firebase", "Rest APIs"],
      iOSUrl: "https://apps.apple.com/in/app/lk-flows/id1639915971",
      androidUrl:
          "https://play.google.com/store/apps/details?id=com.app.lkfiber&hl=en_IN",
      category: "flutter",
    ),
    const Project(
      title: "Kbook - Korean book",
      description:
          "A Korean language learning app that features over 1000 short webtoon-style comics created by amateur authors. KBOOK supports aspiring writers by providing a publishing platform and was selected as one of the top 3 nationwide apps in 2023, receiving government support and partnering with 120 authors. Promotes Korean language and culture through creative content.",
      imageUrl: AppAssets.kbookUrl,
      technologies: ["iOS", "Swift", "Cocoapods", "Rest APIs"],
      iOSUrl: "https://apps.apple.com/us/app/kbook-korean-book/id1643541530",
      category: "iOS",
    ),
    const Project(
      title: "Tragofone",
      description:
          "Empower your workforce to work remotely with Tragofone – a powerful, custom-built, white-label softphone with auto-provisioning. Your daily quick business communication at a go, Tragofone mobile dialer app allows you to use your business VOIP phone number on your mobile phone. Tragofone helps you to communicate anywhere, no matter what network or device you have it on.",
      imageUrl: AppAssets.tragofoneUrl,
      technologies: [
        "iOS",
        "android",
        "React Native",
        "JavaScript",
        "VOIP",
        "Rest APIs"
      ],
      androidUrl:
          "https://play.google.com/store/apps/details?id=com.tragofone.app&hl=en_IN",
      category: "react native",
    ),
  ];

  // ===== ABOUT SECTION DATA =====
  static const List<AboutCard> aboutCards = [
    AboutCard(
      title: AppStrings.aboutCard1Title,
      description: AppStrings.aboutCard1Description,
      icon: "🤝",
    ),
    AboutCard(
      title: AppStrings.aboutCard2Title,
      description: AppStrings.aboutCard2Description,
      icon: "🌍",
    ),
    AboutCard(
      title: AppStrings.aboutCard3Title,
      description: AppStrings.aboutCard3Description,
      icon: "📈",
    ),
    AboutCard(
      title: AppStrings.aboutCard4Title,
      description: AppStrings.aboutCard4Description,
      icon: "💻",
    ),
  ];

  // ===== APPROACH SECTION DATA =====
  static const List<Map<String, String>> approachPhasesData = [
    {
      "title": AppStrings.approachPhase1Title,
      "description": AppStrings.approachPhase1Description,
      "icon": "📋",
      "duration": "1-2 weeks",
    },
    {
      "title": AppStrings.approachPhase2Title,
      "description": AppStrings.approachPhase2Description,
      "icon": "⚡",
      "duration": "2-8 weeks",
    },
    {
      "title": AppStrings.approachPhase3Title,
      "description": AppStrings.approachPhase3Description,
      "icon": "🚀",
      "duration": "1-2 weeks",
    },
  ];
}
