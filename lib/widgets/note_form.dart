import 'package:flutter/material.dart';
import 'package:notepad/widgets/color_picker.dart';


class NoteForm extends StatelessWidget {
  const NoteForm({super.key,required this.titleController,required this.descriptionController,required this.selectedColor,
    required this.onPress,required this.onColorChange});
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Color selectedColor;
  final Function() onPress;
  final Function(Color) onColorChange;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,
          top: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Select note color'),
              ColorPickerWidget(selectedColor: selectedColor,onColorChange: onColorChange)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: onPress,
              child: const Text('save note')),
        ],
      ),
    );
  }
}
