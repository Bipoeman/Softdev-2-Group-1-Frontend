import "package:flutter/material.dart";

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(000000).withOpacity(0.8),
      child: ListView(
        children: [UserAccountsDrawerHeader(accountName: accountName)],
      ),
    );
  }
}
