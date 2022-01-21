import 'package:flutter/material.dart';

import 'package:markbook2/marks_screen.dart';
import 'package:markbook2/model.dart';
import 'package:markbook2/services/DatabaseHandler.dart';
import 'package:provider/provider.dart';

class NewToDoScreen extends StatelessWidget {
  final ValueNotifier<bool> a = ValueNotifier<bool>(true);
  final textController = TextEditingController();
  DatabaseHandler _handler =DatabaseHandler();
  Mark _mark=Mark();
  List<ListModel> _lists= [ListModel()];
  int lastId=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(210, 186, 136, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController,
                  onSubmitted: (newNote) async {
                    if (a.value == true)  {
                      lastId=await _handler.insertList(_lists);
                      a.value = false;
                    };
                     _mark.changeListId(lastId);
                     _mark.changeNote(newNote);
                     await _handler.insertMark([_mark]);
                     textController.clear();
                    
                  },
                ),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: a,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return a.value
                        ? SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _handler.queryListId(lastId)
                            //toDoList.getData.length,
                            itemBuilder: (context, int index) {
                              return Mark(
                                  index,
                                  context
                                          .read<ListOfToDoLists>()
                                          .getList
                                          .length -
                                      1,
                                  true);
                            },
                          );
                  })
            ],
          ),
        ],
      ),
    );
  }
}
