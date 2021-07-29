import 'package:sqflite/sqflite.dart';

class General{
  General._();
  static final General general = General._();
  List data = [];
 late Database database ;
}