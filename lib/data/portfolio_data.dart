import '../models/project.dart';
import '../models/experience.dart';
import '../models/about_card.dart';
import '../constants/assets.dart';
import '../constants/strings.dart';

class PortfolioData {
  // ===== PERSONAL INFORMATION =====
  // Using AppStrings instead of duplicating
  static const String name = AppStrings.heroName;
  static const String title =
      'Senior Software Engineer | Forward Deployed Engineering · Python · JavaScript · SQL · AI-Native Platforms';
  static const String subtitle = AppStrings.heroSubtitle;
  static const String tagline =
      "Driving complex implementations from discovery to launch";
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
  static const String portfolioUrl =
      'https://abbasv0786.github.io/portfolio/#/ahemadabbas-vagh';

  static const String portfolioName = 'AhemadAbbas A Vagh';
  static const String footerDescription =
      'Passionate engineer driving complex implementations and building production-ready solutions. Let\'s build something amazing together.';

  static const String footerCopyright =
      '© 2026 AhemadAbbas Vagh. All rights reserved.';

  // ===== TECHNICAL SKILLS =====
  // Skills are managed directly in AboutController's techCategories

  // ===== CV DATA =====
  static const String cvProfessionalSummary =
      "Senior Software Engineer with 8+ years of experience driving end-to-end implementation delivery for complex AI-native platforms. Proven track record leading technical discovery, scoping complex integrations, debugging deep integration issues, and shipping production code in Python, JavaScript, and SQL. Experienced architecting implementation approaches optimized for product strengths, managing concurrent customer timelines, and collaborating cross-functionally with Product, Engineering, Customer Success, and Product Marketing. Strong communicator who translates ambiguous requirements into actionable stories, influences roadmap priorities through structured data-driven feedback, and mentors engineering teams on delivery best practices. Hands-on coder with deep expertise across multiple product domains, including fintech, insurance, and enterprise SaaS.";

  static const List<String> cvSkills = [
    'Languages & Frameworks: Python, JavaScript/TypeScript, SQL, Dart/Flutter, FastAPI, React, Node.js',
    'AI & Integration: LangChain, LangGraph, RAG Pipelines, Azure AI Search, Azure Document Intelligence, Agentic AI Workflows, Conversational AI, Vector Search',
    'Databases & Storage: PostgreSQL, SQL Server, MongoDB, Firestore, SQLite, Pinecone (Vector DB), Azure Blob Storage',
    'API & Integration: RESTful APIs, GraphQL, Retrofit/Dio, WebSockets, OAuth 2.0/JWT, Swagger/OpenAPI, Interceptor-Driven Auth & Error Handling',
    'Testing & Quality: Unit Tests, Widget Tests, Integration Tests, Golden Tests (UI Regression), pytest, Mockito, TDD, RAGAS Evaluation',
    'Cloud & DevOps: Azure, GCP, AWS, Docker, Kubernetes, GitHub Actions, CI/CD Pipelines, Fastlane, Firebase',
    'Implementation & Delivery: Technical Discovery, Requirements Scoping, Customer Timeline Management, Escalation Management, Launch Readiness, Delivery Playbooks',
    'Leadership & Communication: Cross-Functional Coordination, Stakeholder Management, Technical Mentorship, Data-Driven Roadmap Influence, Client-Facing Presentations, Agile/Scrum',
  ];

  static const List<String> cvAccomplishments = [
    'Drove planning, scoping, and delivery of complex AI-powered implementations — anticipating blockers, managing customer timelines, escalating issues, and ensuring launch readiness across cross-functional teams.',
    'Served as technical escalation point for integration and custom implementation issues — debugging deep integration problems and designing robust solutions tailored to client-specific constraints.',
    'Led technical discovery calls with customers — translating ambiguous requirements into clearly scoped stories and building trust with customer stakeholders through transparent, proactive communication.',
    'Proposed and influenced architectural decisions — designing implementation approaches optimized for product strengths and recommending process/feature improvements based on real-world deployment learnings.',
    'Built and maintained delivery playbooks, onboarding processes, and internal training materials — mentoring junior engineers and driving continuous improvement in engineering practices.',
    'Communicated technical findings and recommendations clearly to customers and internal stakeholders — influencing roadmap priorities through structured, data-driven feedback.',
    'Shipped production integration code in Python, JavaScript, and SQL across customer implementations and internal tooling — maintaining high code quality with automated testing and CI/CD pipelines.',
    'Developed RAG pipelines and agentic AI workflows using LangChain/LangGraph — enabling intelligent document processing and conversational AI capabilities for enterprise customers.',
    'Built cross-platform applications shipped to App Store and Google Play across healthcare, fintech, travel, and enterprise verticals with 5-star ratings and 10,000+ installs.',
    'Implemented CI/CD pipelines with GitHub Actions and Fastlane for automated builds, test regression checks, and zero-touch deployments with rollout strategies.',
  ];

  static const List<String> cvEducationAndCerts = [
    "Bachelor's Degree in Information Technology, Ganpat University (April - 2018)",
    "Certified iOS Developer, Codal System PVT LTD",
    "Certified Flutter Developer, Udemy",
    "Certified React Native Developer, Ecosmob PVT LTD"
  ];

  static const Map<String, String> cvExperienceSummaries = {
    "Independent Software Engineer":
        "Drove end-to-end delivery of complex AI and software implementations — leading technical discovery, scoping integrations, debugging deep issues in Python/JavaScript/SQL, and shipping production-ready code. Built RAG pipelines, agentic AI workflows, and FastAPI services. Communicated directly with clients, managed timelines, and created internal delivery playbooks and mentorship programs.",
    "Ecosmob Technologies":
        "Led delivery of enterprise software products across mobile, web, and backend — serving as technical escalation point for integration issues, debugging complex systems, and designing robust solutions. Built production code in Python, JavaScript, and TypeScript. Coordinated cross-functionally with Product, QA, and DevOps teams. Mentored junior engineers and drove code review standards.",
    "Green Apex Technolabs":
        "Developed cross-platform applications — architecting reusable component libraries, integrating secure REST APIs, implementing automated deployment pipelines, and contributing to engineering standards and delivery process improvements across client projects.",
    "Codal System Pvt Ltd":
        "Built enterprise applications across healthcare, fintech, and e-commerce — handling complex integrations, REST API orchestration, database design (SQL Server, PostgreSQL), and third-party system connections. Established automated testing frameworks and developer tooling that improved team velocity and code quality.",
  };

  // ===== EXPERIENCE DATA =====
  static const List<Experience> experiences = [
    Experience(
      company: "Independent Software Engineer",
      position: "Senior Software Engineer / Forward Deployed Engineer",
      duration: "Jul 2023 - Present",
      description: """
- Drove planning, scoping, and delivery of complex AI-powered implementations — anticipating blockers, managing customer timelines, escalating issues, and ensuring launch readiness across functions.
- Served as technical escalation point for integration and custom implementation issues — debugging deep integration problems in Python, JavaScript, and SQL, and designing robust solutions tailored to client-specific constraints.
- Led technical discovery calls with customers — translating ambiguous requirements into scoped stories and building trust with customer stakeholders through transparent, proactive communication.
- Developed RAG pipelines using LangChain, Azure AI Search, and Azure OpenAI — enabling intelligent document Q&A and conversational AI over enterprise knowledge bases.
- Built intelligent document processing pipelines with Azure Document Intelligence — automating structured data extraction from invoices, contracts, and reports.
- Implemented LangGraph-based agentic workflows for complex multi-step AI tasks with LangSmith observability and RAGAS-based quality evaluation.
- Developed FastAPI backend services with Swagger/OpenAPI documentation, Pydantic validation, async endpoints, and pytest test coverage.
- Created and owned delivery playbooks, onboarding processes, and internal training — driving continuous improvement and mentoring junior engineers.
""",
      technologies: [
        "Python",
        "JavaScript",
        "SQL",
        "LangChain",
        "LangGraph",
        "LangSmith",
        "Azure AI Search",
        "Azure Document Intelligence",
        "FastAPI",
        "GPT-4o",
        "RAGAS",
        "Docker",
        "GCP",
        "Azure",
        "GitHub Actions",
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
- Led delivery of enterprise software products — serving as technical escalation point for integration and implementation issues, debugging complex problems across backend and frontend systems.
- Built production code in Python, JavaScript, TypeScript, and Dart — implementing REST API services, cross-platform applications, and real-time WebSocket features for enterprise SaaS products.
- Developed LangChain-based chatbot and automation workflows — integrating external APIs and delivering conversational AI capabilities into enterprise products.
- Coordinated cross-functionally with Product, QA, DevOps, and Customer Success teams — managing concurrent implementation timelines and ensuring launch readiness.
- Implemented CI/CD pipelines with GitHub Actions and automated testing frameworks (pytest, Jest) — establishing quality gates and code review standards.
- Mentored junior engineers on architecture best practices, clean code patterns, and delivery workflows — conducting thorough code reviews and pair programming sessions.
- Led client-facing solution walkthroughs and technical demos — communicating technical tradeoffs clearly and incorporating client feedback into iterative improvements.
""",
      technologies: [
        "Python",
        "JavaScript",
        "TypeScript",
        "SQL",
        "FastAPI",
        "LangChain",
        "Flutter",
        "React Native",
        "REST APIs",
        "Firebase",
        "CI/CD",
        "GitHub Actions",
        "Docker",
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
- Built scalable full-stack application architectures with clean layered patterns, REST API integrations, and cloud-native backend services using Firebase and AWS.
- Developed reusable project templates and component libraries for cross-platform applications — improving code reuse and consistency across client projects.
- Implemented automated deployment pipelines for iOS and Android platforms — including Docker containerization and release management for App Store and Google Play.
- Collaborated cross-functionally with product teams on enterprise solutions — contributing to engineering standards, code review practices, and delivery process improvements.
""",
      technologies: [
        "Flutter",
        "Dart",
        "JavaScript",
        "iOS",
        "Swift",
        "Firebase",
        "Docker",
        "REST APIs",
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
- Developed enterprise applications with REST API orchestration, database schema design (SQL Server, PostgreSQL), and third-party system integrations across healthcare, fintech, and e-commerce verticals.
- Debugged complex integration issues across multiple systems — designing robust solutions tailored to client-specific constraints and business requirements.
- Built foundational developer tooling including project templates, coding standards documentation, and automated testing frameworks that improved team velocity and software quality.
- Managed full application lifecycle from architecture and development through containerized deployment and post-launch monitoring.
""",
      technologies: [
        "iOS",
        "Swift",
        "JavaScript",
        "SQL",
        "Objective-C",
        "REST APIs",
        "PostgreSQL",
        "Firebase",
        "Cocoapods",
      ],
      companyUrl: "https://codal.com/",
      location: "Office",
      type: "Full-time",
    ),
  ];

  // ===== PROJECTS DATA =====
  static final List<Project> projects = [
    const Project(
      title: "RAG ChatBot",
      description:
          "RAG ChatBot is an intelligent document analysis and conversational AI application that transforms how users interact with information. Built with Streamlit and powered by advanced language models, it enables users to upload PDFs, analyze YouTube videos, and extract insights from web content through natural conversation. The application features a modern UI with navigation-based architecture, real-time chat functionality, vector database storage using Pinecone, and multi-modal content processing. Users can clear chat history, automatically refresh databases on new uploads, and engage with their documents through an intuitive Q&A interface powered by Google's Gemini and OpenAI models.",
      imageUrl: AppAssets.ragChatBotUrl,
      technologies: [
        "Python",
        "Streamlit",
        "LangChain",
        "Pinecone Vector Database",
        "OpenAI API",
        "Google Gemini API",
        "Together AI",
      ],
      liveUrl: 'https://ragchatbot-ai.streamlit.app/',
      category: "AI/ML",
    ),
    const Project(
      title: "Movie Suggester AI",
      description:
          "Movie Suggester AI is an intelligent chat-based application that provides personalized movie and TV show recommendations. Users engage in natural conversations with an AI assistant that analyzes their preferences, mood, and interests to suggest the perfect content to watch. The app features a modern, responsive interface with real-time streaming responses, comprehensive movie details from IMDB integration, and support for multiple content types including movies, series, and general entertainment guidance.",
      imageUrl: AppAssets.movieSuggesterUrl,
      technologies: [
        "React",
        "TypeScript",
        "FastAPI",
        "Python",
        "OpenAI API",
      ],
      liveUrl: 'https://movie-suggester-ai.netlify.app/',
      category: "AI/ML",
    ),
    const Project(
      title: "Tragofone",
      description:
          "A powerful, custom-built, white-label softphone with auto-provisioning. Enables your workforce to work remotely with easy voice calling and text messaging using your business VoIP phone number on mobile. Features include seamless communication across networks and devices, acting as your complete VoIP SIP Softphone solution.",
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
    const Project(
      title: "SSP",
      description:
          "An application designed to assist NGOs in supporting private schools (School Shiksha Parivar). It manages user roles, school details, and a comprehensive complaint resolution system to help address RTE (Right to Education) and other operational challenges faced by small schools.",
      imageUrl: AppAssets.sspUrl,
      technologies: ["Flutter", "Dart", "Firebase", "Rest APIs"],
      androidUrl:
          "https://play.google.com/store/apps/details?id=com.flutter.app.ssp",
      category: "Flutter",
    ),
    const Project(
      title: "Dr Batra's Healthcare",
      description:
          "Designed for patient convenience, this app connects users with doctors efficiently. Key features include video consultations, a message board for queries, appointment scheduling, medical record management, visit feedback, direct escalation to senior doctors, and an online product store. It also facilitates patient referrals and special offers.",
      imageUrl: AppAssets.drBatraUrl,
      technologies: [
        "Android",
        "iOS",
        "Flutter",
        "Rest APIs"
      ], // Inferred from context/link
      androidUrl: "https://play.google.com/store/search?q=dr%20batra&c=apps",
      category: "Mobile",
    ),
    const Project(
      title: "Woof – Pet Safety",
      description:
          "Woof is the #1 app for Pet Parents' peace of mind – designed to rescue your pet if something unexpectedly happens to you (eg car accident, heart attack, etc.).The Woof app was created by pet parents whose biggest fear is their pet being stranded alone at home for days (or worse) with no one to care for them if an unexpected tragedy occurred.",
      imageUrl: AppAssets.woofUrl,
      technologies: [
        "Flutter",
        "Dart",
        "Firebase",
        "Firestore",
        "Rest APIs",
        "Geofencing",
        "Push Notifications",
        "Geolocation",
        "Maps"
      ],
      iOSUrl: "https://apps.apple.com/us/app/woof-pet-safety/id1613059890",
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
