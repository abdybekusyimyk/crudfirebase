import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isselect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Tile", border: OutlineInputBorder()),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Name", border: OutlineInputBorder()),
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
        onPressed: () {},
        child: const Text("+"),
      ),
    );
  }
}
