import 'package:flutter/material.dart';
class DoneScreen extends StatefulWidget {
  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Theme.of(context).buttonColor,
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

    );
  }
}
