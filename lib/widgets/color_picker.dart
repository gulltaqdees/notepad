import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key,required this.selectedColor,required this.onColorChange});
  final Color selectedColor;
  final ValueChanged<Color> onColorChange;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pick a color'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                        pickerColor: selectedColor,
                        onColorChanged:(color){
                          onColorChange(color);
                          Navigator.of(context).pop();
                        }
                        ),
                  ),
                );
              });
        },
        icon: Icon(
          Icons.color_lens_outlined,
          color: selectedColor,
        ));
  }
}
