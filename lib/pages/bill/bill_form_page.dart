import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';
import 'package:split_bill/widgets/default_app_bar.dart';
import 'package:split_bill/widgets/default_date_time_picker.dart';
import 'package:split_bill/widgets/default_text_field.dart';

class BillFormPage extends StatefulWidget {
  const BillFormPage({super.key});

  @override
  State<BillFormPage> createState() => _BillFormPageState();
}

class _BillFormPageState extends State<BillFormPage> {
  final TextEditingController _titleCtrl = TextEditingController();
  final FocusNode _titleFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Split Bill',
      ),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          const DefaultDateTimePicker(),
          SizedBox(height: defaultMargin / 2),
          DefaultTextField(
            controller: _titleCtrl,
            focusNode: _titleFocus,
            labelText: 'Title',
            hintText: 'Enter title',
          ),
          SizedBox(height: defaultMargin / 2),
          const Divider(),
        ],
      ),
    );
  }
}
