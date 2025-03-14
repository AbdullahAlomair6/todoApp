
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/cubit.dart';
//
// Widget defaulteFormFild({
//   required TextEditingController controller,
//   required TextInputType type,
//   Function? onSubmit,
//   bool isPassword = false,
//
//
// })=>TextFormField(
// controller: controller ,
// keyboardType: type,
// obscureText: isPassword,
// onFieldSubmitted: onSubmit,
// onChanged: ,
// onTap: ,
// validator: ,
//
//
//
//
// )
// add frfvaeraerferg
Widget buildTaskItem(Map model, context)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 45,
        child: Text('${model['time']}'),
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${model['title']}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            Text(
                '${model['date']}'
            ),
          ],
        ),
      ),
      SizedBox(
        width: 15,
      ),
      IconButton(
          onPressed: (){
            AppCubit.get(context).updateData(status: 'done', id: model['id']);
          },
          icon: Icon(Icons.check)
      ),
      IconButton(
          onPressed: (){
            AppCubit.get(context).updateData(status: 'archive', id: model['id']);
          },
          icon: Icon(Icons.archive)
      ),
    ],
  ),
);