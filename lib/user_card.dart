import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class UserCard extends StatelessWidget {
  final String userName;
  final int viewCount;
  final VoidCallback onExpand;

  const UserCard({
    super.key,
    required this.userName,
    required this.viewCount,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      onClosed: (_) => onExpand(), // Updates state on close
      transitionDuration: const Duration(milliseconds: 600),
      closedElevation: 2,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      openBuilder: (context, _) => UserDetailView(userName: userName),
      closedBuilder: (context, openContainer) => GestureDetector(
        onTap: openContainer,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Views: $viewCount • AI Student"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}

class UserDetailView extends StatelessWidget {
  final String userName;
  const UserDetailView({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$userName's Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.indigo),
            const SizedBox(height: 20),
            const Text(
              "Education: BSEAI at AUK",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
