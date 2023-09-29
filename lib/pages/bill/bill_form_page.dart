import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';
import 'package:split_bill/utils/functions/functions.dart';
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
  final GlobalKey _formKey = GlobalKey();
  final List<Widget> _formItems = [];

  @override
  void initState() {
    super.initState();
    _formItems.add(
      _itemsForm(
        uniqueKey: UniqueKey(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Split Bill',
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
            SizedBox(height: defaultMargin * 2),
            Column(
              children: _formItems,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formItems.add(
                    _itemsForm(
                      uniqueKey: UniqueKey(),
                    ),
                  );
                });
              },
              child: const Text('+ Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemsForm({required UniqueKey uniqueKey}) {
    final TextEditingController itemNameCtrl = TextEditingController();
    final TextEditingController itemPriceCtrl = TextEditingController();
    final TextEditingController itemQtyCtrl = TextEditingController(text: '1');
    final TextEditingController itemTotalPriceCtrl = TextEditingController();
    final FocusNode itemNameFocus = FocusNode();
    final FocusNode itemPriceFocus = FocusNode();
    final FocusNode itemQtyFocus = FocusNode();
    final FocusNode itemTotalPriceFocus = FocusNode();

    return Column(
      key: uniqueKey,
      children: [
        Row(
          children: [
            Expanded(
              child: DefaultTextField(
                controller: itemNameCtrl,
                focusNode: itemNameFocus,
                labelText: 'Item Name',
                hintText: 'Enter item name',
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(width: defaultMargin / 2),
            if (_formItems.isNotEmpty)
              IconButton(
                onPressed: () {
                  setState(() {
                    _formItems.removeWhere((e) => e.key == uniqueKey);
                  });
                },
                tooltip: 'Delete item',
                enableFeedback: true,
                icon: const Icon(Icons.delete_rounded),
              ),
          ],
        ),
        SizedBox(height: defaultMargin / 2),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: DefaultTextField(
                controller: itemPriceCtrl,
                focusNode: itemPriceFocus,
                labelText: 'Price',
                hintText: 'Enter price',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  final String qty = itemQtyCtrl.text;
                  final String price = value;

                  itemTotalPriceCtrl.text = moneyFormatter(
                    countItemTotalPrice(
                      qty: qty,
                      price: price,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: defaultMargin / 2),
            Expanded(
              flex: 2,
              child: DefaultTextField(
                controller: itemQtyCtrl,
                focusNode: itemQtyFocus,
                labelText: 'Qty',
                hintText: 'Qty',
                suffixText: 'X',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  final String qty = value;
                  final String price = itemPriceCtrl.text;

                  itemTotalPriceCtrl.text = moneyFormatter(
                    countItemTotalPrice(
                      qty: qty,
                      price: price,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: defaultMargin / 2),
            Expanded(
              flex: 5,
              child: DefaultTextField(
                controller: itemTotalPriceCtrl,
                focusNode: itemTotalPriceFocus,
                labelText: 'Total Price',
                hintText: 'Total price',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                readOnly: true,
              ),
            ),
          ],
        ),
        SizedBox(height: defaultMargin / 2),
        const Divider(),
        SizedBox(height: defaultMargin / 2),
      ],
    );
  }
}
