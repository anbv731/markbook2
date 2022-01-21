// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:markbook/marks_screen.dart';
// import 'package:markbook/model.dart';
// import 'package:provider/provider.dart';
//
// class Marker extends StatelessWidget {
//   StreamController _streamController = StreamController();
//
//   Stream get markUpdates => _streamController.stream;
//
//   void addNewToDoList() {
//     _streamController.add(newToDoList1);
//   }
//
//   ToDoListModel get getNewToDoList => newToDoList1;
//   final textController = TextEditingController();
//   ToDoListModel newToDoList1 = ToDoListModel();
//   MarkModel newMark = MarkModel();
//
//   @override
//   Widget build(BuildContext context) {
//     void SaveNewToDoList() {
//       context.read<ListOfToDoLists>().addData(newToDoList1);
//     }
//
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: Color.fromRGBO(210, 186, 136, 1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: TextField(
//             controller: textController,
//             onSubmitted: (newNote) {
//               MarkModel newMark = MarkModel();
//               newMark.changeNote(newNote);
//               newToDoList1.addData(newMark);
//               addNewToDoList();
//               //context.read<ListOfToDoLists>().addData(newToDoList)
//               textController.clear();
//             },
//           ),
//         ),
//         StreamBuilder(
//             stream: markUpdates,
//             builder: (context, snapShot) {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: newToDoList1.getData.length,
//                 //toDoList.getData.length,
//                 itemBuilder: (context, int index) {
//                   return Mark(newToDoList1.getData[index]);
//                 },
//               );
//             })
//       ],
//     );
//   }
// }
