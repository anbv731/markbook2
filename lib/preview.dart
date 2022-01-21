import 'package:flutter/material.dart';
import 'package:markbook2/model.dart';
import 'package:markbook2/services/DatabaseHandler.dart';

import 'package:provider/provider.dart';

class Preview extends StatelessWidget {
  Preview(
    this.upIndex,
  );

  List<Mark> marks = [];
  DatabaseHandler _handler = DatabaseHandler();

  int upIndex = -1;

  @override
  Widget build(BuildContext context) {
    ToDoListModel _toDoList = context.watch<ListOfToDoLists>().getList[upIndex];
    return FutureBuilder(
        future: _handler.queryListId(upIndex),
        builder: (BuildContext context, AsyncSnapshot<List<Mark>> snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/ToDoScreen',
                  arguments: upIndex,
                );
                context
                    .read<ListOfToDoLists>()
                    .addData(result as ToDoListModel);
              },
              child: Container(
                constraints: BoxConstraints(maxHeight: 90),
                padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 2),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(205, 186, 136, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: snapshot.data![index].getPriority
                              ? Icon(Icons.priority_high,
                                  color: Colors.red, size: 20)
                              : Icon(
                                  Icons.priority_high,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                        ),
                        Expanded(
                          child: Text(
                            snapshot.data![index]
                                .getNote,
                            style: snapshot.data![index].getDone
                                ? TextStyle(
                                    decoration: TextDecoration.lineThrough)
                                : null,
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset(1, 1),
                          child: snapshot.data![index].getDone
                              ? Icon(Icons.done, color: Colors.red, size: 20)
                              : Icon(
                                  Icons.done,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
