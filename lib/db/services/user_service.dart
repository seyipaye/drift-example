import '../app_database.dart';
import '../db_provider.dart';
import 'package:drift/drift.dart';

class UserService {
  final AppDatabase _db = DBProvider.instance.database;

  Future<int> insertUser(String name, String email) {
    return _db.into(_db.users).insert(
          UsersCompanion(
            name: Value(name),
            email: Value(email),
          ),
        );
  }

  Future<List<User>> fetchAllUsers() {
    return _db.select(_db.users).get();
  }

  Future<bool> updateUser(User user) {
    return _db.update(_db.users).replace(user);
  }

  Future<int> deleteUser(int id) {
    return (_db.delete(_db.users)..where((tbl) => tbl.id.equals(id))).go();
  }
}
