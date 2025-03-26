import 'app_database.dart';

class DBProvider {
  static final DBProvider _instance = DBProvider._internal();
  late final AppDatabase _db;

  // Private constructor
  DBProvider._internal() {
    _db = AppDatabase();
  }

  // Singleton accessor
  static DBProvider get instance => _instance;

  // Getter for the Drift database
  AppDatabase get database => _db;
}
