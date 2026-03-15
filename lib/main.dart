import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'company_model.dart';
import 'user_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'ScheherazadeNew',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CompanyEntity> companies = [
    FinanceCompany(
      name: 'Blackstone',
      logoPath: 'assets/images/blackstone_logo.png',
      linkedInUrl: 'https://linkedin.com/company/blackstonegroup/',
    ),
    FinanceCompany(
      name: 'JPMorgan',
      logoPath: 'assets/images/jpmorgan_logo.png',
      linkedInUrl: 'https://linkedin.com/company/j-p-morgan/',
    ),
    FinanceCompany(
      name: 'Citadel',
      logoPath: 'assets/images/citadel_logo.png',
      linkedInUrl: 'https://linkedin.com/company/citadel-llc/',
    ),
    FinanceCompany(
      name: 'Goldman Sachs',
      logoPath: 'assets/images/goldman_sachs.png',
      linkedInUrl: 'https://linkedin.com/company/goldman-sachs/',
    ),
    FinanceCompany(
      name: 'BlackRock',
      logoPath: 'assets/images/blackrock_logo.png',
      linkedInUrl: 'https://linkedin.com/company/blackrock/',
    ),
    ConsultingCompany(
      name: 'McKinsey',
      logoPath: 'assets/images/mckinsey_logo.png',
      linkedInUrl: 'https://linkedin.com/company/mckinsey-&-company/',
    ),
  ];

  int profileViews = 0;
  final List<String> followedCompanies = [];

  void incrementViews() => setState(() => profileViews++);

  void toggleFollow(String name) {
    setState(() {
      followedCompanies.contains(name)
          ? followedCompanies.remove(name)
          : followedCompanies.add(name);
    });
  }

  Future<void> startLinkedIn(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Career Portal"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserCard(
              userName: "Kateryna Abramova",
              viewCount: profileViews,
              onExpand: incrementViews,
            ),
            const SizedBox(height: 32),
            const Text(
              "Companies List",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Divider(),

            // UI Implementation for OOP List
            ...companies.map((company) => _buildCompanyRow(company)).toList(),

            const Divider(),
            Text(
              "Interested in: '${followedCompanies.length}' companies.",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyRow(CompanyEntity company) {
    bool isFollowing = followedCompanies.contains(company.name);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => startLinkedIn(company.linkedInUrl),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(
                company.logoPath,
                height: 45,
                width: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  company.getCategory(),
                  style: const TextStyle(fontSize: 11, color: Colors.indigo),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => toggleFollow(company.name),
            style: TextButton.styleFrom(
              foregroundColor: isFollowing ? Colors.green : Colors.indigo,
            ),
            child: Text(isFollowing ? "Interested" : "+"),
          ),
        ],
      ),
    );
  }
}
