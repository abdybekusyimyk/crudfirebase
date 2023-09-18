import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/models/todu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadView extends StatefulWidget {
  ReadView({Key? key}) : super(key: key);

  @override
  State<ReadView> createState() => _ReadViewState();
}

class _ReadViewState extends State<ReadView> {
  //! readTodo
  Stream<QuerySnapshot>? readTodos() {
    final db = FirebaseFirestore.instance;
    return db.collection("todus").snapshots();
  }

  //! undateDodo
  Future<void> updateTodo(ToDuModel todo) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection('todus')
        .doc(todo.id)
        .update({'isselect': !todo.isselect});
  }

  Future<void> deleteTodo(ToDuModel todo) async {
    final db = FirebaseFirestore.instance;
    await db.collection('todus').doc(todo.id).delete();
  }

  @override
  void initState() {
    super.initState();
    readTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: readTodos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          //! ToDuModel di list ailatyk okshoit
          final List<ToDuModel> todosList = snapshot.data!.docs
              .map((e) => ToDuModel.fromMap(e.data() as Map<String, dynamic>)
                ..id = e.id)
              .toList();

          return ListView.builder(
              itemCount: todosList.length,
              itemBuilder: (context, intex) {
                final todo = todosList[intex];
                return Card(
                  child: ListTile(
                    title: Text(todo.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: todo.isselect,
                          onChanged: (value) async {
                            await updateTodo(todo);
                          },
                        ),
                        IconButton(
                            onPressed: () async {
                              await deleteTodo(todo);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                    subtitle: Text(todo.name),
                  ),
                );
              });
        } else {
          return const Center(
            child: Text("Some Error "),
          );
        }
      },
    ));
  }
}
