import 'package:flutter/material.dart';

void showChatAttachmentBottomSheet(
  BuildContext context, {
  required void Function() onImagePick,
  required void Function() onFilePick,
}) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) => SafeArea(
      child: SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onImagePick();
                },
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    Text('Image'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onFilePick();
                },
                child: const Row(
                  children: [
                    Icon(Icons.attach_file),
                    Text('File'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
