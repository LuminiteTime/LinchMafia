import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linch_mafia_test/notifiers/roles_notifier.dart';
import 'package:linch_mafia_test/screens/roles_screen.dart';
import 'package:linch_mafia_test/theme/bg_painter.dart';
import 'package:linch_mafia_test/widgets/home_appbar.dart';

class DistributionCardScreen extends ConsumerStatefulWidget {
  const DistributionCardScreen({super.key});

  @override
  _DistributionCardScreenState createState() => _DistributionCardScreenState();
}

class _DistributionCardScreenState
    extends ConsumerState<DistributionCardScreen> {
  late FlipCardController _controller;
  Role? _currentRole;
  bool _allRolesChosen = false;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
  }

  void _flipCard() {
    if (_controller.state?.isFront == true) {
      _chooseRandomRole();
    } else {
      _decrementRoleCount();
    }
    if (_allRolesChosen) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All roles have been chosen!')),
      );
    }
    _controller.flipcard();
  }

  List _getAvailableRoles() {
    final roles = ref.read(rolesNotifierProvider);
    final availableRoles = roles.where((role) => role.count > 0).toList();
    if (availableRoles.isEmpty) {
      setState(() {
        _allRolesChosen = true;
      });
      return [];
    }
    return availableRoles;
  }

  void _chooseRandomRole() {
    final availableRoles = _getAvailableRoles();
    if (availableRoles.isEmpty) {
      return;
    }
    setState(() {
      _currentRole = (availableRoles..shuffle()).first;
    });
  }

  void _decrementRoleCount() {
    if (_currentRole != null) {
      final index = ref.read(rolesNotifierProvider).indexOf(_currentRole!);
      ref
          .read(rolesNotifierProvider.notifier)
          .decrementDistributionRoleCount(index);
      setState(() {
        if (_getAvailableRoles().isEmpty) {
          _allRolesChosen = true;
        }
        _currentRole = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: "Choose your role!",
        ref: ref,
      ),
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: FlipCard(
            controller: _controller,
            frontWidget: _buildCard(
              child: const Center(
                child: Text(
                  '?',
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            backWidget: _buildCard(
              child: Center(
                child: Text(
                  _currentRole?.name ?? '',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            rotateSide: RotateSide.left,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _allRolesChosen ? null : _flipCard,
        child: const Icon(Icons.flip),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.black,
      child: Container(
        width: 300,
        height: 400,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.red, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: child,
      ),
    );
  }
}
