import 'package:flutter/material.dart';
import 'package:todo_app/general.dart';
import 'package:todo_app/helpers/sqflite_helper.dart';
import 'package:todo_app/widgets/defaultTextFormFeild.dart';
import 'package:intl/intl.dart';

class ArchivedScreen extends StatefulWidget {
  @override
  _ArchivedScreenState createState() => _ArchivedScreenState();
}

class _ArchivedScreenState extends State<ArchivedScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShown = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Theme.of(context).buttonColor,
        onPressed: () async{
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
             await  SqFliteHelper.sqFliteHelper.insertIntoDatabase(
                  titleController.text,
                  timeController.text,
                  dateController.text,
                  'new').then((value) {
               Navigator.of(context).pop();
               titleController.clear();
               timeController.clear();
               dateController.clear();
               setState(() {
                 isBottomSheetShown = false;
               });
             });

            }
          } else {
            if (scaffoldKey.currentState != null) {
              showCustomBottomSheet();
              setState(() {
                isBottomSheetShown = true;
              });
            }
          }
        },
        tooltip: 'Increment',
        child: Icon(isBottomSheetShown ? Icons.add : Icons.edit),
      ),
    );
  }

  String? formValidator(value) {
    if (value.toString().length == 0)
      return 'required field';
    else
      return null;
  }

  void showCustomBottomSheet() {
    scaffoldKey.currentState!.showBottomSheet(
      (ctx) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultTextFormField(
                  controller: titleController,
                  title: 'Task Title',
                  validate: formValidator,
                  icon: Icons.title,
                ),
                DefaultTextFormField(
                  readOnly: true,
                  controller: timeController,
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      if (value != null) {
                        timeController.text = value.format(context);
                      }
                    });
                  },
                  title: 'Task Time',
                  validate: formValidator,
                  icon: Icons.watch_later_outlined,
                ),
                DefaultTextFormField(
                  readOnly: true,
                  controller: dateController,
                  onTap: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(
                          DateTime.now().year + 1,
                          DateTime.now().month,
                          DateTime.now().day,
                        )).then((value) {
                      if (value != null) {
                        dateController.text = DateFormat.yMMMd().format(value);
                      }
                    });
                  },
                  title: 'Task Date',
                  validate: formValidator,
                  icon: Icons.date_range,
                ),
              ],
            ),
          ),
        ),
      ),
      elevation: 12,
    ).closed.then((value) {
      setState(() {
        isBottomSheetShown = false;
      });
    });
  }
}
