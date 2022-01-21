import 'package:flutter/material.dart';
import 'package:markbook2/marks_screen.dart';
import 'package:markbook2/model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    int upIndex = -1;
    upIndex = ModalRoute.of(context)!.settings.arguments as int;
    // ToDoListModel _list=ToDoListModel();
    // _list=context
    //     .read<ListOfToDoLists>()
    //     .getList[upIndex];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.done))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newToDoScreenElse',
              arguments: upIndex);
        },
        child: Icon(Icons.edit),
      ),
      body: ReorderableListView.builder(
        //shrinkWrap: true,
        itemCount:

            context.watch<ListOfToDoLists>().getList[upIndex].getData.length,
        itemBuilder: (context, index) {
          return
              //   Card(
              //   key: ValueKey(_list.getData[index].getNote),
              //
              //   color: Colors.amberAccent,
              //   child: Text(_list.getData[index].getNote),
              // );
          //     ListTile(
          //       key: UniqueKey(),
          //       title:
                Container(key: ValueKey(index),
                  child: MarkTextField(
            upIndex,
            index,

             ),
                );
        },
        onReorder: (oldIndex, newIndex) {
          setState(
            () {
              if (newIndex > oldIndex) {
                newIndex = newIndex - 1;
              }

              context
                  .read<ListOfToDoLists>()
                  .getList[upIndex]
                  .insertData(oldIndex, newIndex);
              context
                  .read<ListOfToDoLists>().notifyListeners();
            },
          );
        },
      ),
    );
  }
}
