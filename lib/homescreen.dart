import 'package:flutter/material.dart';
import 'package:notesapp_database/notes_model.dart';

import 'dbhelper.dart';
import 'uihelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  late DbHelper mydb;
  List<NotesModel> arrNotes = [];
  @override
  void initState() {
    super.initState();
    mydb = DbHelper.db;
    getNotes();
  }

  void getNotes() async {
    arrNotes = await mydb.fetchNotes();
    setState(() {});
  }

  void addNotes(String title, String desc) async {
    bool check =
        await mydb.addNotes(NotesModel(title: title, description: desc));
    if (check) {
      arrNotes = await mydb.fetchNotes();
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text("${arrNotes[index].noteid.toString()}"),
            ),
            title: Text("${arrNotes[index].title.toString()}"),
            subtitle: Text("${arrNotes[index].description.toString()}"),
          );
        },
        itemCount: arrNotes.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _bottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 700,
          width: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiHelper.CustomTextField(
                  titleController, "Add Title", Icons.title),
              UiHelper.CustomTextField(
                  descController, "Add Title", Icons.description),
              SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    addNotes(titleController.text.toString(),
                        descController.text.toString());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text("Add Data"),
                ),
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
    );
  }
}
