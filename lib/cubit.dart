import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/states.dart';

import 'components/constants.dart';
import 'layout/home_layout.dart';
import 'modules/archived_tasks/archived_tasks_screen.dart';
import 'modules/new_tasks/new_tasks_screen.dart';


class AppCubit extends Cubit<AppStates> {

  AppCubit() : super (AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titles = [
    'new tasks',
    'new done',
    ' new archived'
  ];
  late Database database;
  int currentIndex = 0;
  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archivedTasks =[];
  bool isBottomSheetShown = false;
  IconData setIcons = Icons.edit;

  void changeIndex(int index) {
    currentIndex = index;

    emit(AppChangeBottomNavBarState());
  }

  void updateData({
    required String status,
    required int id
  })async
  {
   database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']
    ).then((value){
      getDataFromDatabase(database);
    emit(AppUpdateDatabaseState());

   });

  }

  void createDatabase()
  {
    //1.id integer primary key
    //2.title string
    //3.data string
    //4.time string
    //5.status string

    openDatabase(
        'todo.db',
        version: 1,
        onCreate:(database,version){
          print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value)
          {
            print('table created');
          }).catchError((error){
            print('Error when creating table ${error.toString()}');
          });

        },
        onOpen: (database){
          getDataFromDatabase(database);
          print('database open');
        }
    ).then((value){
      database=value;
      emit(AppCreateDatabaseState());

    });

  }
  Future insertToDatabase({
    required String titel,
    required String time,
    required String date
  }) async {
    try {
      // Start the transaction
      await database.transaction((txn) async {
        // Execute the raw insert command
        int result = await txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$titel", "$date", "$time", "new")',
        );

        // If insertion is successful, print the result
        print('$result inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }
      );
    } catch (error) {
      // If there's an error, print the error message
      print('Error when inserting: ${error.toString()}');
    }
  }

  void getDataFromDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];

    database.rawQuery('SELECT * FROM tasks').then((value){

      value.forEach((elemint){
         if(elemint['status']== 'new') {
           newTasks.add(elemint);
         }else if(elemint['status']== 'done') {
           doneTasks.add(elemint);
         }else{
           archivedTasks.add(elemint);
         }
       });
      emit(AppGetDatabaseState());
    });

  }


  void changeBottomSheetState({
    required bool isShow,
    required IconData icon})
  {
    isBottomSheetShown=isShow;
    setIcons= icon;
    emit(AppChangeBottomSheetState());
  }

}