import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper getInstance = DbHelper._();

  static final String TABLE_REGISTER = "Register";
  static final String COLUMN_REGISTER_SRNO = "sr_no";
  static final String COLUMN_REGISTER_NAME = "name";
  static final String COLUMN_REGISTER_MOBILE = "mobile_no";
  static final String COLUMN_REGISTER_ADDRESS = "address";
  static final String COLUMN_REGISTER_MEET_NAME = "meet_name";
  static final String COLUMN_REGISTER_DATETIME = "date_time";
  static final String COLUMN_REGISTER_IMAGE = "image_path";

  Database? myDB;

  Future<Database> getDB() async {
    log("Get db called------");
    final db = myDB ?? await openDB();
    return db;
  }

  Future<Database> openDB() async {
    final AppPath = await getDatabasesPath();
    String dbpath = join(AppPath, "callDB.db");
    return await openDatabase(dbpath, version: 2,
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE $TABLE_REGISTER ("
                  "$COLUMN_REGISTER_SRNO INTEGER PRIMARY KEY AUTOINCREMENT,"
                  "$COLUMN_REGISTER_NAME TEXT,"
                  "$COLUMN_REGISTER_MOBILE TEXT,"
                  "$COLUMN_REGISTER_ADDRESS TEXT,"
                  "$COLUMN_REGISTER_MEET_NAME TEXT,"
                  "$COLUMN_REGISTER_DATETIME TEXT,"
                  "purpose TEXT,"
                  "$COLUMN_REGISTER_IMAGE TEXT)"
          );
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute("ALTER TABLE $TABLE_REGISTER ADD COLUMN purpose TEXT;");
          }
        }
    );
  }

  Future<bool> addRegister({
    required String Mname,
    required String Maddress,
    required String Mmobile_no,
    required String Mmeet_name,
    required String Mdatetime,
    required String Mpurpose,
    required String MimagePath,
  }) async {
    var db = await getDB();
    try {
      final result = await db.insert(
        TABLE_REGISTER,
        {
          COLUMN_REGISTER_NAME: Mname,
          COLUMN_REGISTER_MOBILE: Mmobile_no,
          COLUMN_REGISTER_ADDRESS: Maddress,
          COLUMN_REGISTER_MEET_NAME: Mmeet_name,
          COLUMN_REGISTER_DATETIME: Mdatetime,
          "purpose": Mpurpose,
          COLUMN_REGISTER_IMAGE: MimagePath,
        },
      );

      if (result == 0) {
        log("Insertion failed");
        return false;
      }
      return true;
    } catch (e) {
      log("Insertion error: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getAllRegister() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_REGISTER);
    log("Fetched Data: $mData");
    return mData;
  }
}
