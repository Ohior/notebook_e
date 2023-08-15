import 'package:flutter/material.dart';
import 'package:notebook_e/database/local_database.dart';
import 'package:notebook_e/model/note_book.dart';
import 'package:notebook_e/widgets/edit_text_view.dart';
import 'package:intl/intl.dart';


class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.noteBook});

  final NoteBook? noteBook;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _detailTextController = TextEditingController();
  String _imagePath = '';

  get noteBook => widget.noteBook;

  @override
  Widget build(BuildContext context) {
    _titleTextController.text = (noteBook != null) ? noteBook!.title : '';
    _detailTextController.text = (noteBook != null) ? noteBook!.detail : '';
    _imagePath = (noteBook != null) ? noteBook!.imagePath : '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Book Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            EditTextCardView(
                textEditingController: _titleTextController,
                inputDecoration: const InputDecoration(
                    hintText: "Enter your Title",
                    border: OutlineInputBorder(),
                    label: Text("Title"))),
            const SizedBox(
              height: 20,
            ),
            EditTextCardViewExpanded(
                textEditingController: _detailTextController,
                inputDecoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    hintText: "Enter Note Details",
                    label: Text("Detail")))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_titleTextController.text.isNotEmpty &&
              _detailTextController.text.isNotEmpty) {
            if (noteBook != null) {
              updateNoteBook(context, noteBook!);
              debugPrint("Note updated");
            } else {
              addNoteBook(context);
              debugPrint("Note added");
            }
          } else {
            Navigator.pop(context);
            debugPrint("Note canceled");
          }
        },
        child: const Icon(Icons.save_as_outlined),
      ),
    );
  }

  Future<void> addNoteBook(BuildContext context) async {
    final num = await LocalDatabase.insertNoteBook(NoteBook(
        title: _titleTextController.text,
        detail: _detailTextController.text,
        imagePath: '',
        createdTime: getDataTime(),
        updatedTime: ''));
    debugPrint('Num is $num');
    if (context.mounted) Navigator.pop(context, true);
  }

  Future<void> updateNoteBook(BuildContext context, NoteBook noteBook) async {
    await LocalDatabase.insertNoteBook(NoteBook(
        id: noteBook.id,
        title: _titleTextController.text,
        detail: _detailTextController.text,
        imagePath: noteBook.imagePath,
        createdTime: noteBook.createdTime,
        updatedTime: getDataTime()));
    if (context.mounted) Navigator.pop(context, true);
  }


  String getDataTime() {
    DateTime now = DateTime.now();
    DateTime newTime = now.add(const Duration(hours: 1, minutes: 30));
    String formattedDateTime = DateFormat('MMM d, yyyy').format(newTime);
    // String formattedDateTime = DateFormat('MMM d, yyyy h:mm a').format(newTime);
    return formattedDateTime; // Output: Oct 7, 2021 1:30 AM
  }

}
