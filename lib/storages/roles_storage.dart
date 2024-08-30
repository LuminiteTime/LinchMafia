import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linch_mafia_test/screens/roles_screen.dart';

class RoleStorage {
  static const String _rolesKey = 'roles';

  Future<void> saveRoles(List<Role> roles) async {
    final prefs = await SharedPreferences.getInstance();
    final rolesMap =
        roles.map((role) => {'name': role.name, 'count': role.count}).toList();
    await prefs.setString(_rolesKey, jsonEncode(rolesMap));
  }

  Future<List<Role>> loadRoles() async {
    final prefs = await SharedPreferences.getInstance();
    final rolesString = prefs.getString(_rolesKey);
    if (rolesString != null) {
      final List<dynamic> rolesList = jsonDecode(rolesString);
      return rolesList
          .map((roleMap) => Role(roleMap['name'], roleMap['count']))
          .toList();
    }
    return [
      Role('Mafia', 1),
      Role('Detective', 0),
      Role('Doctor', 0),
      Role('Citizen', 2),
    ];
  }
}
