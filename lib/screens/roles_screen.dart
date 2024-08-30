// lib/screens/roles_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linch_mafia_test/theme/bg_painter.dart';
import 'package:linch_mafia_test/notifiers/roles_notifier.dart';
import 'package:linch_mafia_test/widgets/home_appbar.dart';
import 'package:linch_mafia_test/widgets/standard_button.dart';

class Role {
  final String name;
  int count;

  Role(
    this.name,
    this.count,
  );
}

class RolesScreen extends ConsumerWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roles = ref.watch(rolesNotifierProvider);

    return Scaffold(
      appBar: HomeAppBar(
        title: "Roles",
        ref: ref,
      ),
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const FlutterLogo(size: 100),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: roles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              roles[index].name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => ref
                                      .read(rolesNotifierProvider.notifier)
                                      .decrementRoleCount(index),
                                ),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    roles[index].count.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  onPressed: () => ref
                                      .read(rolesNotifierProvider.notifier)
                                      .incrementRoleCount(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MStandardButton(
                      onPressed: () async {
                        ref.read(rolesNotifierProvider.notifier).resetRoles();
                      },
                      text: 'Reset',
                    ),
                    MStandardButton(
                      onPressed: () async {
                        await ref
                            .read(rolesNotifierProvider.notifier)
                            .saveRoles();
                        Navigator.pushNamed(
                          context,
                          '/distribution',
                        );
                      },
                      text: 'Confirm',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
