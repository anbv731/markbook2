import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:markbook2/new_to_do_screen.dart';
import 'package:markbook2/preview.dart';
import 'package:markbook2/services/DatabaseHandler.dart';
import 'package:markbook2/to_do_screen.dart';
import 'package:provider/provider.dart';
import 'model.dart';

void main() {
  // runApp(
  //   const MaterialApp(
  //     title: 'Returning Data',
  //     home: HomeScreen(),
  //   ),
  // );
  runApp(ChangeNotifierProvider(
    create: (context) => ListOfToDoLists(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  DatabaseHandler handler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/ToDoScreen': (context) => ToDoScreen(),
        '/newToDoScreenElse': (context) => NewToDoScreen(),
      },
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  ToDoListModel newToDoList = ToDoListModel();
  bool marker = true;
  DatabaseHandler _handler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Preview Screen'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/newToDoScreenElse');
            },
            icon: Icon(Icons.add)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {}
          //     onPressed: () async {
          //   final result = await Navigator.pushNamed(
          //     context,
          //     '/newToDoScreen',
          //     arguments: Arguments(newToDoList, marker),
          //   );
          //   newToDoList = result as ToDoListModel;
          //   context.read<ListOfToDoLists>().addData(newToDoList);
          //   int a = newToDoList.getData.length;
          //   print('$a');
          //}
          ),
      body: FutureBuilder(
        future: _handler.retrieveMarks(),
        builder: (BuildContext context, AsyncSnapshot<List<Mark>> snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount:  snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(color: Colors.red),
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) {
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Preview(index)),
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.fit(1);
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
