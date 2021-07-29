import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/helpers/sqflite_helper.dart';
import 'archived_tasks_screen.dart';
import 'done_tasks_screen.dart';
import 'tasks_screen.dart';

class HomeScreen extends StatelessWidget {
  int _currentIndex = 0;
  final screens = [TasksScreen(), DoneScreen(), ArchivedScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => TasksCubit(),
      child: BlocConsumer<TasksCubit, TasksStates>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            TasksCubit cubit = TasksCubit.initializeObject(ctx);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("tasks").tr(),
                leading: IconButton(
                  onPressed: () {
                    SwitchTheme(
                      data: SwitchThemeData(),
                      child: Text('switch'),
                    );
                  },
                  icon: Icon(
                    Icons.light_mode,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: ()=>cubit.changeLocal(context),
                      icon: Icon(Icons.translate))
                ],
              ),
              body: screens[cubit.pageIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.pageIndex,
                onTap: cubit.changePageIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'tasks'.tr()),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline),
                      label: 'done'.tr()),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined),
                      label: 'archived'.tr()),
                ],
              ),
            );
          }),
    );
  }
}
