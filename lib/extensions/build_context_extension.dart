import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showSnackBarWithUndo(VoidCallback undoCallback, String snackBarMessage) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(snackBarMessage),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => undoCallback(),
        ),
      ),
    );
  }
}
