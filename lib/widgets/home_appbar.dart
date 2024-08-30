import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linch_mafia_test/notifiers/roles_notifier.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final WidgetRef ref;

  const HomeAppBar({
    super.key,
    required this.title,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/");
          ref.read(rolesNotifierProvider.notifier).resetRoles();
        },
        color: Colors.grey[400],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
