
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/cubit/cubit.dart';

import '../modules/webview/webview_screen.dart';


Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
    navigateTo(context,WebviewScreen());
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${article['urlToImage']}')
              )
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);

Widget defaultSeparator()=>Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  child: Container(
    height: 2,
    color: Colors.grey[200],
  ),
);


Widget articleBuilder(list,context)=>ConditionalBuilder(
    condition: list.length > 0,  //state is! NewsGetBusinessLoadingState,
    fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.teal,)),
    builder: (context)=>ListView.separated(
      //addSemanticIndexes: true,
      physics: BouncingScrollPhysics(), // This controls the scroll behavior
      itemBuilder: (context, index) => buildArticleItem(list[index],context), // How each item is built
      itemCount: 10, // Total number of items to display
      separatorBuilder: (context, index) {
        return defaultSeparator(); // Custom separator between items
      },
    )

);


void navigateTo(context,widget )=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget
    )
);