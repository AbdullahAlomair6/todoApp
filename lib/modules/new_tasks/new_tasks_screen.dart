import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit.dart';
import 'package:todo_app/states.dart';

import '../../components/constants.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/components/components.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state)
      {
        var tasks = AppCubit.get(context).newTasks;
        return ListView.separated(
          itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
          separatorBuilder: (context,index)=>Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[200],
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
