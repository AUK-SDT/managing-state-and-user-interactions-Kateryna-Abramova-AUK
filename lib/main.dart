import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

const String userName = "Kateryna Abramova";

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
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int profileViews = 0;
  final List<String> followedCompanies = [];

  void incrementViews() {
    setState(() {
      profileViews++;
    });
  }

  String getProfileViews() {
    return profileViews.toString();
  }

  void toggleFollow(String name) {
    setState(() {
      if (followedCompanies.contains(name)) {
        followedCompanies.remove(name);
      } else {
        followedCompanies.add(name);
      }
    });
  }

  Future<void> startLinkedIn(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      //mention different view options in app/outside
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text("Career Portal"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: .start, // changed align to left
          children: [
            UserCard(viewCount: profileViews, onExpand: incrementViews),

            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Companies List",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            const Divider(),

            Column(
              // crossAxisAlignment: .end,
              children: [
                companyCard(
                  'Blackstone',
                  'assets/images/blackstone_logo.png',
                  'https://linkedin.com/company/blackstonegroup/',
                ),
                companyCard(
                  'BlackRock',
                  'assets/images/blackrock_logo.png',
                  'https://linkedin.com/company/blackrock/',
                ),
                companyCard(
                  'JPMorgan',
                  'assets/images/jpmorgan_logo.png',
                  'https://linkedin.com/company/j-p-morgan/',
                ),
                companyCard(
                  'Citadel',
                  'assets/images/citadel_logo.png',
                  'https://linkedin.com/company/citadel-llc/',
                ),
                companyCard(
                  'Goldman Sachs',
                  'assets/images/goldman_sachs.png',
                  'https://linkedin.com/company/goldman-sachs/',
                ),
                companyCard(
                  'McKinsey',
                  'assets/images/mckinsey_logo.png',
                  'https://linkedin.com/company/mckinsey-&-company/',
                ),
              ],
            ),

            const Divider(),
            Text(
              "Interested in: '${followedCompanies.length}' companies.",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget companyCard(String name, String path, String url) {
    bool isFollowing = followedCompanies.contains(name);

    return GestureDetector(
      onTap: () => startLinkedIn(url),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          spacing: 5,
          crossAxisAlignment: .start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Image.asset(path, height: 45, width: 90),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Same description text build for every company - '${name}' is the same",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => toggleFollow(name),
              style: TextButton.styleFrom(
                foregroundColor: isFollowing ? Colors.green : Colors.indigo,
              ),
              child: Text(isFollowing ? "Interested" : "+"),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final int viewCount;
  final VoidCallback onExpand;

  const UserCard({super.key, required this.viewCount, required this.onExpand});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 600),
      closedElevation: 2,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      closedColor: Theme.of(context).cardColor,

      // shows when the card is expanded
      openBuilder: (context, action) => const UserDetailView(),
      // normal state of the card
      closedBuilder: (context, openContainer) => InkWell(
        onTap: openContainer, // animation
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.person, color: Colors.white, size: 35),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text("Software Engineering & AI Student"),
                    Text(
                      "Full bio",
                      style: TextStyle(color: Colors.indigo, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(userName + "'s Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 60, backgroundColor: Colors.indigo),
            const SizedBox(height: 20),
            const Text(
              userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 40),
            const Text(
              "Education: BSEAI at American University Kyiv\n"
              "Experience: Student Council, IT Fest Organizer\n\n"
              "Love cats.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
