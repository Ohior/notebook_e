import 'package:flutter/material.dart';

class TextViewCard extends StatelessWidget {
  const TextViewCard({
    super.key,
    required this.title,
    this.subtitle1,
    required this.onPressed,
    required this.deleteOnPressed,
    required this.subtitle2,
  });

  final Widget title;
  final Widget? subtitle1;
  final Widget subtitle2;
  final Function onPressed;
  final Function deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(6),
        elevation: 3,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          ListTile(
            title: title,
            subtitle: subtitle1,
            onTap: () => onPressed(),
            trailing: IconButton(
                onPressed: () => deleteOnPressed(),
                icon: const Icon(Icons.delete_forever_rounded)),
          ),
          subtitle2
        ]));
  }
}
