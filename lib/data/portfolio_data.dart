import '../models/project.dart';
import '../models/experience.dart';
import '../models/about_card.dart';
import '../models/social_link.dart';
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
  static const String twitter = 'https://twitter.com/dHx0FBQuWHZKBke';
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
      title: "AI Expense Tracker",
      description:
          "A web application for tracking personal finance with AI integration for smart categorization and budget insights.",
      imageUrl: AppAssets.expenseTrackerUrl,
      technologies: ["React.js", "Node.js", "MongoDB", "AI/ML", "Chart.js"],
      liveUrl: "https://expense-tracker-phi-wine.vercel.app/",
      category: "Web Application",
    ),
    const Project(
      title: "Klimatee - Weather App",
      description:
          "A modern weather application that shows weather of different locations including your current location with beautiful UI.",
      imageUrl: AppAssets.weatherAppUrl,
      technologies: ["React.js", "Weather API", "Geolocation", "CSS3"],
      liveUrl: "https://klimatee.vercel.app/",
      category: "Web Application",
    ),
    const Project(
      title: "Car Slayer - NFT Game",
      description:
          "A blockchain-based NFT game where players can buy, sell, and trade car NFTs using cryptocurrency.",
      imageUrl: AppAssets.carSlayerUrl,
      technologies: ["Solidity", "Web3", "React.js", "NFT", "Ethers.js"],
      liveUrl: "https://car-slayer.vercel.app/",
      category: "Blockchain Game",
    ),
    const Project(
      title: "Stakify - DeFi Protocol",
      description:
          "A decentralized application that allows users to stake tokens and earn rewards on the Polygon blockchain.",
      imageUrl: AppAssets.stakifyUrl,
      technologies: ["Solidity", "Web3", "React.js", "Polygon", "DeFi"],
      liveUrl: "https://stakify-rose.vercel.app/",
      category: "DeFi Protocol",
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

  // ===== SOCIAL MEDIA DATA =====
  static const List<SocialLink> socialLinks = [
    SocialLink(
      name: "WhatsApp",
      url: whatsapp,
      icon: "whatsapp",
      username: "+91 9714907429",
    ),
    SocialLink(
      name: "Discord",
      url: discord,
      icon: "discord",
      username: "ahemadabbas#1234",
    ),
    SocialLink(
      name: "Telegram",
      url: telegram,
      icon: "telegram",
      username: "@ahemadabbas",
    ),
    SocialLink(
      name: "LinkedIn",
      url: linkedin,
      icon: "linkedin",
      username: "ahemadabbasvagh",
    ),
    SocialLink(
      name: "Twitter",
      url: twitter,
      icon: "twitter",
      username: "@ahemadabbasvagh",
    ),
    SocialLink(
      name: "Instagram",
      url: instagram,
      icon: "instagram",
      username: "@ahemadabbasvagh",
    ),
  ];
}
