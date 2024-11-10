import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit.dart';
import 'package:todo_app/states.dart';

import '../components/constants.dart';
import '../modules/archived_tasks/archived_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';


class HomeLayout extends StatelessWidget {


  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


// @override
//   void initState() {
//     super.initState();
//     createDatabase();
//   }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState)
          {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                 cubit.titles[cubit.currentIndex]
              ),
            ),
           body: /*cubit.newTasks.length ==0 ? Center(child: CircularProgressIndicator()) :*/cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: (){
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                        titel: titleController.text,
                        time:timeController.text ,
                        date: dateController.text);
                    // insertToDatabase(
                    //   titel: titleController.text,
                    //   time: timeController.text,
                    //   date: dateController.text,
                    // ).then((value){
                    //   Navigator.pop(context);
                    //   getDataFromDatabase(database).then((value){
                    //
                    //     tasks = value;
                    //     print(tasks);
                    //     isBottomSheetShown = false;
                    //   });
                    // });
                  }

                }else{
                  scaffoldKey.currentState?.showBottomSheet((context)=>
                      Container(
                        color: Colors.blueGrey[100],
                        // padding: EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  validator:(value){
                                    if(value!.isEmpty){
                                      return "title must be empty";
                                    }},
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'task titel',
                                      prefix: Icon(Icons.title)
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  onTap:(){
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()
                                    ).then((value){
                                      timeController.text = value!.format(context);
                                      print(value?.format(context));
                                    });
                                  } ,
                                  validator:(value){
                                    if(value!.isEmpty){
                                      return "time must be empty";
                                    }},
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'task time ',
                                      prefix: Icon(Icons.watch_later_outlined)
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap:(){
                                    showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2026-03-01')
                                    ).then(( value){
                                      dateController.text = DateFormat.yMMMd().format(value as DateTime);
                                      print(DateFormat.yMMMd().format(value as DateTime));
                                    });
                                  } ,
                                  validator:(value){
                                    if(value!.isEmpty){
                                      return "date must be empty";
                                    }},
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'task date ',
                                      prefix: Icon(Icons.date_range)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) ).closed.then((value){
                    cubit.changeBottomSheetState(isShow: false,icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true,icon: Icons.add);
                }
              },
              child: Icon(color: Colors.black,
                cubit.setIcons,
              ),),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeIndex(index);
                },
                items:[
                  BottomNavigationBarItem(icon: Icon(Icons.toc),label: 'Tasks',),
                  BottomNavigationBarItem(icon: Icon(Icons.done),label: 'Done'),
                  BottomNavigationBarItem(icon: Icon(Icons.archive),label: 'Archived')
                ]
            ),

          );
        },

      ),
    );
  }




}