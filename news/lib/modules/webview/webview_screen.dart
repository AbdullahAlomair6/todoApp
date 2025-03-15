import 'package:flutter/material.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WebviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, NewsStates state) {
          // Handle state changes if needed
        },
        builder: (BuildContext context, NewsStates state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('WebView Example'),
            ),
            body: Column() // WebView added here
          );
        },
      ),
    );
  }
}