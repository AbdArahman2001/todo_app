import 'package:flutter/material.dart';
import 'package:todo_app/general.dart';
import 'package:todo_app/widgets/single_task.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
 late List data ;

  @override
  void initState() {
    data = General.general.data;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (ctx, index) => SingleTask(
              title: data[index]['title'],
              time: data[index]['time'],
              date: data[index]['date'],
              status: true,),
          separatorBuilder: (ctx, index) => Divider(),
          itemCount: data.length),
    );
  }
}
