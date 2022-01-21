import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markbook2/model.dart';

import 'package:provider/provider.dart';

class MarkTextField extends StatelessWidget {
  MarkTextField(this.upIndex, this.index);

  TextEditingController _textcontroller = TextEditingController();

  //Key key = GlobalKey();

  int upIndex = -1;

  int index = -1;

  @override
  Widget build(BuildContext context) {
    _textcontroller = TextEditingController(
        text: context
            .watch<ListOfToDoLists>()
            .getList[upIndex]
            .getData[index]
            .getNote);
    return Dismissible(
      background: Container(color: Colors.red),
      key: ValueKey(index),
      onDismissed: (DismissDirection direction) {
        context.read<ListOfToDoLists>().getList[upIndex].removeData(index);
        context.read<ListOfToDoLists>().notifyListeners();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => {
                context
                    .read<ListOfToDoLists>()
                    .getList[upIndex]
                    .getData[index]
                    .changePriority(),
                context.read<ListOfToDoLists>().notifyListeners(),
              },
              child: context
                      .watch<ListOfToDoLists>()
                      .getList[upIndex]
                      .getData[index]
                      .getPriority
                  ? Icon(Icons.priority_high, color: Colors.red, size: 30)
                  : Icon(
                      Icons.priority_high,
                      color: Colors.grey,
                      size: 30,
                    ),
            ),
          ),
          Expanded(
              child: TextFormField(
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _textcontroller,
            //initialValue: _textcontroller.text(),
            onFieldSubmitted: (newNote) {
              context
                  .read<ListOfToDoLists>()
                  .getList[upIndex]
                  .getData[index]
                  .changeNote(newNote);
              context.read<ListOfToDoLists>().notifyListeners();
            },
          )),
          Align(
            alignment: FractionalOffset(1, 1),
            child: GestureDetector(
              onTap: () => {
                context
                    .read<ListOfToDoLists>()
                    .getList[upIndex]
                    .getData[index]
                    .changeDone(),
                context.read<ListOfToDoLists>().notifyListeners()
              },
              child: context
                      .watch<ListOfToDoLists>()
                      .getList[upIndex]
                      .getData[index]
                      .getDone
                  ? Icon(Icons.done, color: Colors.red, size: 30)
                  : Icon(
                      Icons.done,
                      color: Colors.grey,
                      size: 30,
                    ),
            ),
          ),
          Icon(
            Icons.reorder,
            size: 30,
          )
        ],
      ),
    );
  }
}

class MarkField extends StatelessWidget {
  MarkField(this.index, this.upIndex, this.isEditable);

  bool isEditable;
  int upIndex = -1;

  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => isEditable
                ? {
                    context
                        .read<ListOfToDoLists>()
                        .getList[upIndex]
                        .getData[index]
                        .changePriority(),
                    context.read<ListOfToDoLists>().notifyListeners(),
                  }
                : {},
            child: context
                    .watch<ListOfToDoLists>()
                    .getList[upIndex]
                    .getData[index]
                    .getPriority
                ? Icon(Icons.priority_high, color: Colors.red, size: 20)
                : Icon(
                    Icons.priority_high,
                    color: Colors.grey,
                    size: 20,
                  ),
          ),
        ),
        Expanded(
          child: Text(
            context
                .watch<ListOfToDoLists>()
                .getList[upIndex]
                .getData[index]
                .getNote,
            style: context
                    .watch<ListOfToDoLists>()
                    .getList[upIndex]
                    .getData[index]
                    .getDone
                ? TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
        ),
        Align(
          alignment: FractionalOffset(1, 1),
          child: GestureDetector(
            onTap: () => isEditable
                ? {
                    context
                        .read<ListOfToDoLists>()
                        .getList[upIndex]
                        .getData[index]
                        .changeDone(),
                    context.read<ListOfToDoLists>().notifyListeners()
                  }
                : {},
            child: context
                    .watch<ListOfToDoLists>()
                    .getList[upIndex]
                    .getData[index]
                    .getDone
                ? Icon(Icons.done, color: Colors.red, size: 20)
                : Icon(
                    Icons.done,
                    color: Colors.grey,
                    size: 20,
                  ),
          ),
        ),
      ],
    ));
  }
}
