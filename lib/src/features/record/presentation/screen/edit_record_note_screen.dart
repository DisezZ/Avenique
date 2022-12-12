import 'package:flutter/material.dart';

class EditRecordNoteScreen extends StatefulWidget {
  const EditRecordNoteScreen({super.key, required this.initialNote});

  final String initialNote;

  static Route<String?> route(BuildContext context, String initialNote) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EditRecordNoteScreen(
        initialNote: initialNote,
      ),
    );
  }

  @override
  State<EditRecordNoteScreen> createState() => _EditRecordNoteScreenState();
}

class _EditRecordNoteScreenState extends State<EditRecordNoteScreen> {
  String _note = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.of(context).pop(_note);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Form(
            key: _formKey,
            child: TextFormField(
              initialValue: widget.initialNote,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: 'Enter your note about record here'),
              onSaved: (newValue) => _note = newValue ?? _note,
            ),
          ),
          Expanded(child: Container()),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       _formKey.currentState!.save();
          //       Navigator.of(context).pop(_note);
          //     }
          //   },
          //   child: Text('DONE'),
          // ),
        ],
      ),
    );
  }
}
