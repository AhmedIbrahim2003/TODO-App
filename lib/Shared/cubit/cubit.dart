import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_2/Shared/cubit/states.dart';

import '../../screens/archivedTasks.dart';
import '../../screens/doneTasks.dart';
import '../../screens/newTasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> tasks = [];
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchivedTaskScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  Database? database;
  bool isBottomSheetOpened = false;
  var floatingActionButtonIcon = Icons.edit;

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) => print('table created'))
            .catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (database) {
        print('Database opened');

        getDataFromDatabase(database).then((value) {
          tasks = value;
          emit(AppGetDataFromDatabaseState());
        });
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future? insertIntoDatabase(
      {required String title,
      required String time,
      required String date}) async {
    return await database!
        .transaction((txn) => txn.rawInsert(
            'INSERT INTO tasks(title,date,time,status) VALUES ("$title", "$date", "$time", "new")'))
        .then((value) {
      print('$value Inseted done');
      emit(AppInsertIntoDatabaseState());

      getDataFromDatabase(database).then((value) {
        tasks = value;
        emit(AppGetDataFromDatabaseState());
      });
    }).catchError((error) {
      print("error in insertion $error");
    });
  }

  Future<List<Map>> getDataFromDatabase(db) async {
    return await db!.rawQuery('SELECT * FROM tasks');
  }

  void ChangeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetOpened = isShow;
    floatingActionButtonIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
