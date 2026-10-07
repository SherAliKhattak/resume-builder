import '../../features/job_description/domain/models/analyzed_keyword.dart';
import 'text_normalizer.dart';

class SkillEntry {
  const SkillEntry({
    required this.term,
    required this.category,
    this.synonyms = const [],
  });

  final String term;
  final KeywordCategory category;
  final List<String> synonyms;

  String get canonical => TextNormalizer.normalize(term);
}

class SkillLexicon {
  SkillLexicon(List<SkillEntry> entries) : entries = List.unmodifiable(entries) {
    for (final entry in this.entries) {
      _index[entry.canonical] = entry;
      for (final synonym in entry.synonyms) {
        _index[TextNormalizer.normalize(synonym)] = entry;
      }
    }
    phrases = [
      for (final key in _index.keys)
        if (key.isNotEmpty) key,
    ]..sort((a, b) => b.length.compareTo(a.length));
  }

  factory SkillLexicon.standard() => _standard ??= SkillLexicon(kSkillEntries);

  factory SkillLexicon.fromJson(List<dynamic> raw) {
    return SkillLexicon([
      for (final item in raw)
        if (item is Map<String, dynamic>)
          SkillEntry(
            term: '${item['term'] ?? ''}',
            category: _category('${item['category'] ?? ''}'),
            synonyms: [
              for (final synonym in (item['synonyms'] as List? ?? const []))
                '$synonym',
            ],
          ),
    ]);
  }

  static SkillLexicon? _standard;

  final List<SkillEntry> entries;
  final _index = <String, SkillEntry>{};
  late final List<String> phrases;

  Set<String> get allTerms => _index.keys.toSet();

  SkillEntry? find(String term) => _index[TextNormalizer.normalize(term)];

  static KeywordCategory _category(String raw) {
    switch (raw) {
      case 'hardSkill':
        return KeywordCategory.hardSkill;
      case 'tool':
        return KeywordCategory.tool;
      case 'softSkill':
        return KeywordCategory.softSkill;
      case 'certification':
        return KeywordCategory.certification;
      default:
        return KeywordCategory.other;
    }
  }
}

const kSkillEntries = <SkillEntry>[
  SkillEntry(term: 'Python', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Java', category: KeywordCategory.hardSkill),
  SkillEntry(
    term: 'JavaScript',
    category: KeywordCategory.hardSkill,
    synonyms: ['js', 'ecmascript'],
  ),
  SkillEntry(
    term: 'TypeScript',
    category: KeywordCategory.hardSkill,
    synonyms: ['ts'],
  ),
  SkillEntry(term: 'Dart', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Flutter', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Kotlin', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Swift', category: KeywordCategory.hardSkill),
  SkillEntry(
    term: 'Go',
    category: KeywordCategory.hardSkill,
    synonyms: ['golang'],
  ),
  SkillEntry(term: 'Rust', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'C++', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'C#', category: KeywordCategory.hardSkill, synonyms: ['csharp']),
  SkillEntry(term: 'Ruby', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'PHP', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Scala', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'R', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'SQL', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'HTML', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'CSS', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'React', category: KeywordCategory.hardSkill),
  SkillEntry(
    term: 'React Native',
    category: KeywordCategory.hardSkill,
    synonyms: ['react-native'],
  ),
  SkillEntry(term: 'Angular', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Vue', category: KeywordCategory.hardSkill, synonyms: ['vue.js', 'vuejs']),
  SkillEntry(term: 'Svelte', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Next.js', category: KeywordCategory.hardSkill, synonyms: ['nextjs']),
  SkillEntry(term: 'Node.js', category: KeywordCategory.hardSkill, synonyms: ['nodejs', 'node']),
  SkillEntry(term: 'Express', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Django', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Flask', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'FastAPI', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Spring', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Spring Boot', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Android', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'iOS', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'SwiftUI', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Jetpack Compose', category: KeywordCategory.hardSkill),
  SkillEntry(
    term: 'State Management',
    category: KeywordCategory.hardSkill,
    synonyms: ['state-management'],
  ),
  SkillEntry(term: 'BLoC', category: KeywordCategory.hardSkill, synonyms: ['bloc', 'flutter bloc']),
  SkillEntry(term: 'Provider', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Riverpod', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Redux', category: KeywordCategory.hardSkill),
  SkillEntry(
    term: 'REST API',
    category: KeywordCategory.hardSkill,
    synonyms: ['rest', 'restful', 'rest apis'],
  ),
  SkillEntry(term: 'GraphQL', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'gRPC', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Microservices', category: KeywordCategory.hardSkill),
  SkillEntry(
    term: 'Clean Architecture',
    category: KeywordCategory.hardSkill,
  ),
  SkillEntry(term: 'System Design', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Object Oriented', category: KeywordCategory.hardSkill, synonyms: ['oop']),
  SkillEntry(term: 'Functional Programming', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'TDD', category: KeywordCategory.hardSkill, synonyms: ['test driven development']),
  SkillEntry(term: 'Unit Testing', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Widget Testing', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Offline First', category: KeywordCategory.hardSkill, synonyms: ['offline-first']),
  SkillEntry(
    term: 'CI/CD',
    category: KeywordCategory.hardSkill,
    synonyms: ['continuous integration', 'continuous delivery', 'cicd'],
  ),
  SkillEntry(term: 'DevOps', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'SRE', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Agile', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Scrum', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Kanban', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Machine Learning', category: KeywordCategory.hardSkill, synonyms: ['ml']),
  SkillEntry(term: 'Deep Learning', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'NLP', category: KeywordCategory.hardSkill, synonyms: ['natural language processing']),
  SkillEntry(term: 'Computer Vision', category: KeywordCategory.hardSkill),
  SkillEntry(
    term: 'Data Analysis',
    category: KeywordCategory.hardSkill,
    synonyms: ['data analytics', 'analysing data', 'analyzing data'],
  ),
  SkillEntry(term: 'Data Science', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Statistics', category: KeywordCategory.hardSkill, synonyms: ['statistical analysis']),
  SkillEntry(term: 'ETL', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Data Modeling', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Data Visualization', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'A/B Testing', category: KeywordCategory.hardSkill, synonyms: ['ab testing']),
  SkillEntry(term: 'Pandas', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'NumPy', category: KeywordCategory.hardSkill, synonyms: ['numpy']),
  SkillEntry(term: 'TensorFlow', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'PyTorch', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Scikit-learn', category: KeywordCategory.hardSkill, synonyms: ['sklearn']),
  SkillEntry(term: 'Spark', category: KeywordCategory.hardSkill, synonyms: ['apache spark']),
  SkillEntry(term: 'Hadoop', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Airflow', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'dbt', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'UX', category: KeywordCategory.hardSkill, synonyms: ['user experience']),
  SkillEntry(term: 'UI', category: KeywordCategory.hardSkill, synonyms: ['user interface']),
  SkillEntry(term: 'User Research', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Wireframing', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Prototyping', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Accessibility', category: KeywordCategory.hardSkill, synonyms: ['a11y']),
  SkillEntry(term: 'Information Architecture', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'SEO', category: KeywordCategory.hardSkill, synonyms: ['search engine optimization']),
  SkillEntry(term: 'Content Strategy', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Copywriting', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Digital Marketing', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Email Marketing', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Paid Ads', category: KeywordCategory.hardSkill, synonyms: ['ppc', 'paid media']),
  SkillEntry(term: 'Social Media', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Campaign Management', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Brand Strategy', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Content Marketing', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Google Ads', category: KeywordCategory.tool),
  SkillEntry(term: 'Meta Ads', category: KeywordCategory.tool, synonyms: ['facebook ads']),
  SkillEntry(term: 'Customer Success', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Sales', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Negotiation', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Account Management', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Finance', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Accounting', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Forecasting', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Budgeting', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Financial Modeling', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Product Management', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Project Management', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'OAuth', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'JWT', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Penetration Testing', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Network Security', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'IAM', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Security', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Observability', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'LLM', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Prompt Engineering', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'RAG', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'LangChain', category: KeywordCategory.hardSkill),
  SkillEntry(term: 'Git', category: KeywordCategory.tool),
  SkillEntry(term: 'Docker', category: KeywordCategory.tool),
  SkillEntry(
    term: 'Kubernetes',
    category: KeywordCategory.tool,
    synonyms: ['k8s'],
  ),
  SkillEntry(term: 'Terraform', category: KeywordCategory.tool),
  SkillEntry(term: 'AWS', category: KeywordCategory.tool, synonyms: ['amazon web services']),
  SkillEntry(term: 'Azure', category: KeywordCategory.tool),
  SkillEntry(term: 'GCP', category: KeywordCategory.tool, synonyms: ['google cloud']),
  SkillEntry(term: 'Linux', category: KeywordCategory.tool),
  SkillEntry(term: 'Unix', category: KeywordCategory.tool),
  SkillEntry(term: 'Bash', category: KeywordCategory.tool),
  SkillEntry(term: 'PostgreSQL', category: KeywordCategory.tool, synonyms: ['postgres']),
  SkillEntry(term: 'MySQL', category: KeywordCategory.tool),
  SkillEntry(term: 'MongoDB', category: KeywordCategory.tool),
  SkillEntry(term: 'Redis', category: KeywordCategory.tool),
  SkillEntry(term: 'SQLite', category: KeywordCategory.tool),
  SkillEntry(term: 'Firebase', category: KeywordCategory.tool),
  SkillEntry(term: 'Supabase', category: KeywordCategory.tool),
  SkillEntry(term: 'Elasticsearch', category: KeywordCategory.tool),
  SkillEntry(term: 'Kafka', category: KeywordCategory.tool),
  SkillEntry(term: 'RabbitMQ', category: KeywordCategory.tool),
  SkillEntry(term: 'Webpack', category: KeywordCategory.tool),
  SkillEntry(term: 'Vite', category: KeywordCategory.tool),
  SkillEntry(term: 'Tailwind', category: KeywordCategory.tool),
  SkillEntry(term: 'Sass', category: KeywordCategory.tool),
  SkillEntry(term: 'JUnit', category: KeywordCategory.tool),
  SkillEntry(term: 'Pytest', category: KeywordCategory.tool),
  SkillEntry(term: 'Jest', category: KeywordCategory.tool),
  SkillEntry(term: 'Cypress', category: KeywordCategory.tool),
  SkillEntry(term: 'Selenium', category: KeywordCategory.tool),
  SkillEntry(term: 'Playwright', category: KeywordCategory.tool),
  SkillEntry(term: 'Figma', category: KeywordCategory.tool),
  SkillEntry(term: 'Sketch', category: KeywordCategory.tool),
  SkillEntry(term: 'Adobe XD', category: KeywordCategory.tool),
  SkillEntry(term: 'Photoshop', category: KeywordCategory.tool),
  SkillEntry(term: 'Illustrator', category: KeywordCategory.tool),
  SkillEntry(term: 'Jira', category: KeywordCategory.tool),
  SkillEntry(term: 'Confluence', category: KeywordCategory.tool),
  SkillEntry(term: 'Tableau', category: KeywordCategory.tool),
  SkillEntry(term: 'Power BI', category: KeywordCategory.tool, synonyms: ['powerbi']),
  SkillEntry(term: 'Excel', category: KeywordCategory.tool, synonyms: ['microsoft excel']),
  SkillEntry(term: 'Looker', category: KeywordCategory.tool),
  SkillEntry(term: 'Google Analytics', category: KeywordCategory.tool, synonyms: ['ga4']),
  SkillEntry(term: 'HubSpot', category: KeywordCategory.tool),
  SkillEntry(term: 'Salesforce', category: KeywordCategory.tool),
  SkillEntry(term: 'CRM', category: KeywordCategory.tool),
  SkillEntry(term: 'Prometheus', category: KeywordCategory.tool),
  SkillEntry(term: 'Grafana', category: KeywordCategory.tool),
  SkillEntry(term: 'OpenAI', category: KeywordCategory.tool),
  SkillEntry(term: 'Snowflake', category: KeywordCategory.tool),
  SkillEntry(term: 'BigQuery', category: KeywordCategory.tool),
  SkillEntry(term: 'Leadership', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Mentoring', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Communication', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Stakeholder Management', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Problem Solving', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Critical Thinking', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Collaboration', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Time Management', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Presentation', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Public Speaking', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Writing', category: KeywordCategory.softSkill),
  SkillEntry(term: 'Research', category: KeywordCategory.softSkill),
  SkillEntry(
    term: 'AWS Certified',
    category: KeywordCategory.certification,
    synonyms: ['aws certification'],
  ),
  SkillEntry(term: 'PMP', category: KeywordCategory.certification),
  SkillEntry(term: 'Scrum Master', category: KeywordCategory.certification, synonyms: ['csm']),
  SkillEntry(term: 'Google Analytics Individual Qualification', category: KeywordCategory.certification, synonyms: ['gaiq']),
];
