import 'package:flutter/material.dart';

class EditTextCardView extends StatelessWidget {
  const EditTextCardView({super.key,
    required this.textEditingController,
    required this.inputDecoration,
    this.maxChar,
    this.label,
    this.maxLines = 1,
    this.minLines = 1,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputType = TextInputType.text,
  });
  final TextEditingController textEditingController;
  final InputDecoration inputDecoration;
  final int maxLines;
  final int minLines;
  final int? maxChar;
  final TextInputType textInputType;
  final Widget? label;
  final TextAlignVertical textAlignVertical;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(3),
      elevation: 3,
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        controller: textEditingController,
        decoration: inputDecoration,
        maxLines: maxLines,
        maxLength: maxChar,
        keyboardType: textInputType,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class EditTextCardViewExpanded extends StatelessWidget {
  const EditTextCardViewExpanded({super.key,
    required this.textEditingController,
    required this.inputDecoration,
    this.label,
    this.minLines = 1,
    this.textAlignVertical = TextAlignVertical.center,
    this.textInputType = TextInputType.text,
  });
  final TextAlignVertical textAlignVertical;
  final TextEditingController textEditingController;
  final InputDecoration inputDecoration;
  final int minLines;
  final TextInputType textInputType;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(3),
        elevation: 3,
        child: TextField(
          textAlignVertical: TextAlignVertical.top,
          controller: textEditingController,
          decoration: inputDecoration,
          maxLines: null,
          expands: true,
          keyboardType: textInputType,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
