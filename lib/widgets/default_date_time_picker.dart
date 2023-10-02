import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:split_bill/utils/functions/functions.dart';
import 'package:split_bill/widgets/default_text_field.dart';

class DefaultDateTimePicker extends StatefulWidget {
  final TextEditingController dateTimeCtrl;
  const DefaultDateTimePicker({
    super.key,
    required this.dateTimeCtrl,
  });

  @override
  State<DefaultDateTimePicker> createState() => _DefaultDateTimePickerState();
}

class _DefaultDateTimePickerState extends State<DefaultDateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showOmniDateTimePicker(
      context: context,
      is24HourMode: true,
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        widget.dateTimeCtrl.text = dateTimeFormatter(selectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.dateTimeCtrl.text = dateTimeFormatter(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      controller: widget.dateTimeCtrl,
      labelText: 'Date & Time',
      hintText: 'Pick a date and time',
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}
