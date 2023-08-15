import 'package:flutter/material.dart';
import 'package:notebook_e/database/local_database.dart';
import 'package:notebook_e/form_Screen.dart';
import 'package:notebook_e/widgets/text_view.dart';

import 'model/note_book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NoteBook> _listOfNoteBook = [];

  void _refreshNoteBook() async {
    final data = await LocalDatabase.getAllNoteBook();
    setState(() {
      _listOfNoteBook = data;
      print("Refresh Note books are ${_listOfNoteBook.length}");
    });
  }

  @override
  void initState() {
    _refreshNoteBook();
    print("Note books are ${_listOfNoteBook.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_refreshNoteBook();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _listOfNoteBook.length,
          itemBuilder: (context, index) {
            return TextViewCard(
                title: Text(_listOfNoteBook[index].title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                subtitle1: Text(_listOfNoteBook[index].detail, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                subtitle2: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Created At : ${_listOfNoteBook[index].createdTime}"),
                    Text("Updated At : ${_listOfNoteBook[index].updatedTime}"),
                  ],
                ),
                onPressed: () {
                  debugPrint('OnPressed clicked');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormScreen(noteBook: _listOfNoteBook[index])));
                },
                deleteOnPressed: () async {
                  debugPrint('DeleteOnPressed clicked');
                  await LocalDatabase.deleteNoteBook(_listOfNoteBook[index]);
                  _refreshNoteBook();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("${_listOfNoteBook[index].title} Deleted")));
                  }
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool refresh = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FormScreen(noteBook: null)));
          if(refresh){
            _refreshNoteBook();
          }
        },
        tooltip: 'Note Book',
        child: const Icon(Icons.add_card),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
