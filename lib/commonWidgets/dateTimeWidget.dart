import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DateTimeWidget extends StatelessWidget {
  final TextEditingController controllerdate;
  String labelName;
  DateTimeWidget(
      {Key? key, required this.controllerdate, required this.labelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerdate,
      decoration: InputDecoration(labelText: labelName),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          controllerdate.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        } else {}
      },
    );
  }
}
