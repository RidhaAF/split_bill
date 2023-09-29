import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';
import 'package:split_bill/utils/functions/functions.dart';
import 'package:split_bill/widgets/default_app_bar.dart';
import 'package:split_bill/widgets/default_date_time_picker.dart';
import 'package:split_bill/widgets/default_list_tile.dart';
import 'package:split_bill/widgets/default_text_field.dart';

class BillFormPage extends StatefulWidget {
  const BillFormPage({super.key});

  @override
  State<BillFormPage> createState() => _BillFormPageState();
}

class _BillFormPageState extends State<BillFormPage> {
  final GlobalKey _formKey = GlobalKey();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _serviceCtrl = TextEditingController();
  final TextEditingController _taxCtrl = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _serviceFocus = FocusNode();
  final FocusNode _taxFocus = FocusNode();
  final int _subtotal = 0;
  final int _total = 0;
  final List<Widget> _formItems = [];

  void _initFormItem() {
    _formItems.add(
      _itemsForm(
        uniqueKey: UniqueKey(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initFormItem();
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
            _titleForm(),
            SizedBox(height: defaultMargin * 2),
            Column(
              children: _formItems,
            ),
            _addItemButton(),
            SizedBox(height: defaultMargin * 2),
            _listTileContent(
              title: 'Subtotal',
              trailing: Text(
                moneyFormatter(_subtotal.toString()),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(height: defaultMargin / 2),
            _listTileContent(
              title: 'Service',
              trailing: _serviceForm(),
            ),
            SizedBox(height: defaultMargin / 2),
            _listTileContent(
              title: 'Tax',
              trailing: _taxForm(),
            ),
            SizedBox(height: defaultMargin / 2),
            _listTileContent(
              title: 'Total',
              trailing: Text(
                moneyFormatter(_total.toString()),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: bold,
                    ),
                textScaleFactor: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleForm() {
    return DefaultTextField(
      controller: _titleCtrl,
      focusNode: _titleFocus,
      labelText: 'Title',
      hintText: 'Enter title',
    );
  }

  Widget _addItemButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _formItems.add(
            _itemsForm(
              uniqueKey: UniqueKey(),
            ),
          );
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_circle_rounded),
          SizedBox(width: defaultMargin / 2),
          const Text(
            'Add item',
            textScaleFactor: 1.0,
          ),
        ],
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
            _itemNameForm(
              controller: itemNameCtrl,
              focusNode: itemNameFocus,
            ),
            if (_formItems.isNotEmpty)
              _deleteItemButton(
                uniqueKey: uniqueKey,
              ),
          ],
        ),
        SizedBox(height: defaultMargin / 2),
        Row(
          children: [
            _itemPriceForm(
              controller: itemPriceCtrl,
              focusNode: itemPriceFocus,
              itemQtyCtrl: itemQtyCtrl,
              itemTotalPriceCtrl: itemTotalPriceCtrl,
            ),
            SizedBox(width: defaultMargin / 2),
            _itemQtyForm(
              controller: itemQtyCtrl,
              focusNode: itemQtyFocus,
              itemPriceCtrl: itemPriceCtrl,
              itemTotalPriceCtrl: itemTotalPriceCtrl,
            ),
            SizedBox(width: defaultMargin / 2),
            _itemTotalPriceForm(
              controller: itemTotalPriceCtrl,
              focusNode: itemTotalPriceFocus,
            ),
          ],
        ),
        SizedBox(height: defaultMargin / 2),
        const Divider(),
        SizedBox(height: defaultMargin / 2),
      ],
    );
  }

  Widget _itemNameForm({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Expanded(
      child: DefaultTextField(
        controller: controller,
        focusNode: focusNode,
        labelText: 'Item Name',
        hintText: 'Enter item name',
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Item name is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _deleteItemButton({required UniqueKey uniqueKey}) {
    return IconButton(
      onPressed: () {
        setState(() {
          _formItems.removeWhere((e) => e.key == uniqueKey);
        });
      },
      tooltip: 'Delete item',
      enableFeedback: true,
      icon: const Icon(Icons.delete_rounded),
    );
  }

  Widget _itemPriceForm({
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextEditingController itemQtyCtrl,
    required TextEditingController itemTotalPriceCtrl,
  }) {
    return Expanded(
      flex: 5,
      child: DefaultTextField(
        controller: controller,
        focusNode: focusNode,
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'Price is required';
          } else if (int.tryParse(value) == 0) {
            return 'Price must be greater than 0';
          } else if (int.tryParse(value) == null) {
            return 'Price must be a number';
          }
          return null;
        },
      ),
    );
  }

  Widget _itemQtyForm({
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextEditingController itemPriceCtrl,
    required TextEditingController itemTotalPriceCtrl,
  }) {
    return Expanded(
      flex: 2,
      child: DefaultTextField(
        controller: controller,
        focusNode: focusNode,
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
        validator: (value) {
          if (value!.isEmpty) {
            return 'Qty is required';
          } else if (int.tryParse(value) == 0) {
            return 'Qty must be greater than 0';
          } else if (int.tryParse(value) == null) {
            return 'Qty must be a number';
          }
          return null;
        },
      ),
    );
  }

  Widget _itemTotalPriceForm({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Expanded(
      flex: 5,
      child: DefaultTextField(
        controller: controller,
        focusNode: focusNode,
        labelText: 'Total Price',
        hintText: 'Total price',
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        readOnly: true,
        textAlign: TextAlign.end,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Total price is required';
          } else if (int.tryParse(value) == 0) {
            return 'Total price must be greater than 0';
          } else if (int.tryParse(value) == null) {
            return 'Total price must be a number';
          }
          return null;
        },
      ),
    );
  }

  Widget _listTileContent({required String title, Widget? trailing}) {
    return DefaultListTile(
      title: Text(
        title,
        textScaleFactor: 1.0,
      ),
      trailing: trailing,
    );
  }

  Widget _serviceForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: DefaultTextField(
        controller: _serviceCtrl,
        focusNode: _serviceFocus,
        labelText: 'Service',
        hintText: 'Enter service',
        keyboardType: TextInputType.number,
        textAlign: TextAlign.end,
        validator: (value) {
          if (int.tryParse(value) == null) {
            return 'Service must be a number';
          }
          return null;
        },
      ),
    );
  }

  Widget _taxForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: DefaultTextField(
        controller: _taxCtrl,
        focusNode: _taxFocus,
        labelText: 'Tax',
        hintText: 'Enter tax',
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.end,
        validator: (value) {
          if (int.tryParse(value) == null) {
            return 'Tax must be a number';
          }
          return null;
        },
      ),
    );
  }
}
