import 'package:flutter/material.dart';
import 'package:split_bill/pages/bill/widgets/bill_item.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _serviceCtrl = TextEditingController();
  final TextEditingController _taxCtrl = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _serviceFocus = FocusNode();
  final FocusNode _taxFocus = FocusNode();
  final List<BillItem> _billItems = [];

  void _initBillItem() {
    setState(() {
      _billItems.add(BillItem());
    });
  }

  @override
  void initState() {
    super.initState();
    _initBillItem();
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
              children: _billItems.map((item) => _itemsForm(item)).toList(),
            ),
            _addItemButton(),
            SizedBox(height: defaultMargin * 2),
            _listTileContent(
              title: 'Subtotal',
              trailing: Text(
                moneyFormatter(
                  calculateSubtotal(_billItems).toString(),
                ),
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
                moneyFormatter(
                  calculateTotal(
                    _billItems,
                    service: _serviceCtrl.text,
                    tax: _taxCtrl.text,
                  ).toString(),
                ),
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
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Title is required';
        }
        return null;
      },
    );
  }

  Widget _addItemButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _billItems.add(BillItem());
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

  Widget _itemsForm(BillItem item) {
    return Column(
      children: [
        Row(
          children: [
            _itemNameForm(item),
            if (_billItems.length > 1) _deleteItemButton(item),
          ],
        ),
        SizedBox(height: defaultMargin / 2),
        Row(
          children: [
            _itemPriceForm(item),
            SizedBox(width: defaultMargin / 2),
            _itemQtyForm(item),
            SizedBox(width: defaultMargin / 2),
            _itemTotalPriceForm(item),
          ],
        ),
        SizedBox(height: defaultMargin / 2),
        const Divider(),
        SizedBox(height: defaultMargin / 2),
      ],
    );
  }

  Widget _itemNameForm(BillItem item) {
    return Expanded(
      child: DefaultTextField(
        controller: item.nameCtrl,
        focusNode: item.nameFocus,
        labelText: 'Item Name',
        hintText: 'Enter item name',
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Item name is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _deleteItemButton(BillItem item) {
    return IconButton(
      onPressed: () {
        setState(() {
          _billItems.remove(item);
        });
      },
      tooltip: 'Delete item',
      enableFeedback: true,
      icon: const Icon(Icons.delete_rounded),
    );
  }

  Widget _itemPriceForm(BillItem item) {
    return Expanded(
      flex: 5,
      child: DefaultTextField(
        controller: item.priceCtrl,
        focusNode: item.priceFocus,
        labelText: 'Price',
        hintText: 'Enter price',
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          item.calculateTotalPrice();
          setState(() {});
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Price is required';
          } else if (int.tryParse(value) == null) {
            return 'Price must be a number';
          } else if (int.tryParse(value)! <= 0) {
            return 'Price must be greater than 0';
          }
          return null;
        },
      ),
    );
  }

  Widget _itemQtyForm(BillItem item) {
    return Expanded(
      flex: 2,
      child: DefaultTextField(
        controller: item.qtyCtrl,
        focusNode: item.qtyFocus,
        labelText: 'Qty',
        hintText: 'Qty',
        suffixText: 'X',
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          item.calculateTotalPrice();
          setState(() {});
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Qty is required';
          } else if (int.tryParse(value) == null) {
            return 'Qty must be a number';
          } else if (int.tryParse(value)! <= 0) {
            return 'Qty must be greater than 0';
          }
          return null;
        },
      ),
    );
  }

  Widget _itemTotalPriceForm(BillItem item) {
    return Expanded(
      flex: 5,
      child: Text(
        moneyFormatter(
          item.calculateTotalPrice().toString(),
        ),
        textAlign: TextAlign.end,
        textScaleFactor: 1.0,
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
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.end,
        onChanged: (value) {
          calculateTotal(
            _billItems,
            service: value,
            tax: _taxCtrl.text,
          );
          setState(() {});
        },
        validator: (value) {
          if (value == null || int.tryParse(value) == null) {
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
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.end,
        onChanged: (value) {
          calculateTotal(
            _billItems,
            service: _serviceCtrl.text,
            tax: value,
          );
          setState(() {});
        },
        validator: (value) {
          if (value == null || int.tryParse(value) == null) {
            return 'Tax must be a number';
          }
          return null;
        },
      ),
    );
  }
}
