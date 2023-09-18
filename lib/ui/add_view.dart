import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfirebase/models/todu_model.dart';
import 'package:crudfirebase/ui/read_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isselect = false;

  final title = TextEditingController();
  final name = TextEditingController();

  final forKey = GlobalKey<FormState>();

// Add
  Future<void> addDodo() async {
    final db = FirebaseFirestore.instance;
    final todo =
        ToDuModel(title: title.text, name: name.text, isselect: isselect);
    await db.collection("todus").add(todo.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: forKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                    hintText: "Tile", border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    hintText: "Name", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Name ";
                  }
                },
              ),
              CheckboxListTile(
                  title: Text("select"),
                  value: isselect,
                  onChanged: (v) {
                    setState(() {});
                    isselect = v ?? false;
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (forKey.currentState!.validate()) {
            showDialog(
                context: context,
                builder: (context) {
                  return const CupertinoAlertDialog(
                    title: Text("Kuto turunuz"),
                    content: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CupertinoActivityIndicator(
                        radius: 20,
                        color: Colors.blueAccent,
                      ),
                    )),
                  );
                });
            await addDodo();
            // ignore: use_build_context_synchronously
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ReadView()));
          }
        },
        child: const Text("+"),
      ),
    );
  }
}
