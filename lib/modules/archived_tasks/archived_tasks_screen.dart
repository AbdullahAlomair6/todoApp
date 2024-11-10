
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';

import '../../components/components.dart';
import '../../cubit.dart';
import '../../states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state)
      {
        var tasks = AppCubit.get(context).archivedTasks;
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
