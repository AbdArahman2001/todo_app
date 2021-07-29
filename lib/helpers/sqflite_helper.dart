import 'package:sqflite/sqflite.dart';
import 'package:todo_app/general.dart';

class SqFliteHelper {
  SqFliteHelper._();

  static final SqFliteHelper sqFliteHelper = SqFliteHelper._();
  late var rawVal;

  deleteMyDatabase() async {
    await deleteDatabase('todo.db').catchError(
        (error) => print('error occur when delete database: $error'));
  }

  Future<Database> createDataBase() async {
    General.general.database = await openDatabase('todo.db', version: 1,
        onCreate: (Database db, int version) async {
      print('created');
      await db
          .execute('CREATE TABLE tasks '
              '(id INTEGER PRIMARY KEY,'
              ' title TEXT, '
              'time TEXT, '
              'date TEXT,'
              ' status TEXT)')
          .then((value) => print('table created'))
          .catchError(
              (error) => print('an error occur when creating table: $error'));
    }, onConfigure: (Database database) {
      print('configured');
    }, onDowngrade: (database, oldVer, newVer) {
      print('downgraded');
    }, onOpen: (database) async{
      General.general.data = await getFromDatabase(database);
      print('opened');
    }, onUpgrade: (database, oldV, newV) {
      print('upgraded');
    });
    return General.general.database;
  }

  Future insertIntoDatabase(
      String title, String time, String date, String status) async
  {
    return await General.general.database.transaction(
      (Transaction txn) async{
       rawVal = await txn
            .rawInsert(
                'INSERT INTO tasks (title,time,date,status) VALUES ("$title","$time","$date","$status")')
            .then((value) {
          print(value);
        }).catchError((error) {
          print('error occurred when insert raw' + error.toString());
        });
        return rawVal;
      },
    ).then((_)async => General.general.data = await getFromDatabase(General.general.database));

  }

  Future getFromDatabase(Database _database)async{
    List<Map<String, Object?>> data = await _database.rawQuery('SELECT * FROM tasks');
    print(data);
    return data;
  }
}
