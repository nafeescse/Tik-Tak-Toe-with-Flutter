import 'package:flutter/material.dart';
class CustomDialog extends StatelessWidget {
  const CustomDialog(
      this.title,
      this.content,
      this.callback,
      [this.actionText =  "reset"]);

  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(title),
      actions: [
        ElevatedButton(onPressed: callback, child: Text(actionText))
      ],
    );
  }
}
