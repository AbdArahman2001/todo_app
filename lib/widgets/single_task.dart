import 'package:flutter/material.dart';

class SingleTask extends StatefulWidget {
  final String title;
  final String time;
  final String date;
  bool status;

  SingleTask(
      {required this.title,
      required this.time,
      required this.date,
      required this.status});

  @override
  _SingleTaskState createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: CircleAvatar(
              // backgroundColor: Colors.blue.shade900,
              radius: 34,
              child: Text(
                widget.time,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          Expanded(child:Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Text(widget.date,style: TextStyle(fontSize:14,color: Colors.grey )),
            ],
          ) ),
          Expanded(child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(value: widget.status, onChanged: (value){
                  setState(() {
                    widget.status = value!;
                  });
                },
                  fillColor:MaterialStateProperty.resolveWith((states) => Colors.green),
                ),
                IconButton(icon: Icon(Icons.archive,color: Colors.grey,),onPressed: (){},),
            ],
          )),
        ],
      ),
    );
  }
}
/*
* Container(
      child:ListTile(
        horizontalTitleGap: 0,
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade900,
          radius: 60,
          child: Text(widget.time,style: TextStyle(fontSize: 12),),
        ),
        title: Text(widget.title),
        subtitle:  Text(widget.date),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(value: widget.status, onChanged: (value){
              setState(() {
                widget.status = value!;
              });
            },
            fillColor:MaterialStateProperty.resolveWith((states) => Colors.green),
            ),
            IconButton(icon: Icon(Icons.archive),onPressed: (){},)
          ],
        ),
      ) ,
    )*/
