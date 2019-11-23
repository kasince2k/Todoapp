import 'package:app1/models/globals.dart';
import 'package:app1/models/widgets/intray_todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:app1/models/classes/task.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList=[];
  @override
  void initState(){
    super.initState();
    taskList=getList();
  }
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      child: _buildReorderable(context)
      /* child: ReorderableListView(
        padding: EdgeInsets.only(top: 300),
        children: todoitems,
        onReorder: _onReorder,
      ), */
    );
  }

  Widget _buildListTile(BuildContext context,Task item){
    return ListTile(
      key: Key(item.taskid),
      title: IntrayTodo(title: item.title,),
    );
  }

  Widget _buildReorderable(BuildContext context){
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
        padding: EdgeInsets.only(top: 300.0),
        children: taskList.map((Task item) => _buildListTile(context, item)).toList(),
        onReorder: (oldIndex,newIndex){
          setState(() {
            if(newIndex>oldIndex){
              newIndex-=1;
            }
            Task item =taskList[oldIndex];
            taskList.remove(item);
            taskList.insert(newIndex, item);
          });
        },
      ),
    );
  }

List<Task> getList(){
  for(int i=0;i<10;i++){
  taskList.add(Task("ToDo:"+i.toString(),false,i.toString()));
  }
  return taskList;
  }
}