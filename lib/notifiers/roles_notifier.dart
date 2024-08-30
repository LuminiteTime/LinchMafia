import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linch_mafia_test/screens/roles_screen.dart';
import 'package:linch_mafia_test/storages/roles_storage.dart';

class RolesNotifier extends StateNotifier<List<Role>> {
  final RoleStorage _roleStorage;

  RolesNotifier(this._roleStorage) : super([]) {
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    state = await _roleStorage.loadRoles();
  }

  void incrementRoleCount(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) Role(state[i].name, state[i].count + 1) else state[i]
    ];
    saveRoles();
  }

  void decrementRoleCount(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Role(
              state[i].name,
              state[i].name == 'Mafia'
                  ? state[i].count > 1
                      ? state[i].count - 1
                      : 1
                  : state[i].count > 0
                      ? state[i].count - 1
                      : 0)
        else
          state[i]
    ];
    saveRoles();
  }

  void decrementDistributionRoleCount(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Role(state[i].name, state[i].count > 0 ? state[i].count - 1 : 0)
        else
          state[i]
    ];
    saveRoles();
  }

  void resetRoles() {
    state = [for (int i = 0; i < state.length; i++) Role(state[i].name, 0)];
    state[0].count = 1;
    saveRoles();
  }

  Future<void> saveRoles() async {
    await _roleStorage.saveRoles(state);
  }
}

final rolesNotifierProvider =
    StateNotifierProvider<RolesNotifier, List<Role>>((ref) {
  return RolesNotifier(RoleStorage());
});
