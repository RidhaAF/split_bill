import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_bill/pages/bill/widgets/bill_item.dart';
import 'package:split_bill/utils/constants/constants.dart';
import 'package:split_bill/utils/constants/strings.dart';
import 'package:split_bill/utils/functions/functions.dart';
import 'package:split_bill/widgets/default_app_bar.dart';
import 'package:split_bill/widgets/default_button.dart';
import 'package:split_bill/widgets/default_date_time_picker.dart';
import 'package:split_bill/widgets/default_list_tile.dart';
import 'package:split_bill/widgets/default_snack_bar.dart';
import 'package:split_bill/widgets/default_text_field.dart';

class BillFormPage extends StatefulWidget {
  const BillFormPage({Key? key}) : super(key: key);

  @override
  State<BillFormPage> createState() => _BillFormPageState();
}

class _BillFormPageState extends State<BillFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateTimeCtrl = TextEditingController();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _serviceCtrl = TextEditingController();
  final TextEditingController _taxCtrl = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _serviceFocus = FocusNode();
  final FocusNode _taxFocus = FocusNode();
  final List<BillItem> _billItems = [];
  int _subtotal = 0;
  int _total = 0;

  void _addBillItem() {
    setState(() {
      _billItems.add(BillItem());
    });
  }

  void _removeBillItem(BillItem item) {
    setState(() {
      _billItems.remove(item);
    });
  }

  void _initBillItem() {
    _addBillItem();
  }

  void _handleConfirmButton() {
    if (_serviceCtrl.text.isEmpty) {
      _serviceCtrl.text = '0';
    }
    if (_taxCtrl.text.isEmpty) {
      _taxCtrl.text = '0';
    }

    if (_formKey.currentState!.validate()) {
      context.push(
        '/bill/choose-friends',
        extra: {
          'summary': {
            'date': _dateTimeCtrl.text,
            'title': _titleCtrl.text,
            'items': _billItems,
            'subtotal': _subtotal.toString(),
            'service': digitOnly(_serviceCtrl.text),
            'tax': digitOnly(_taxCtrl.text),
            'total': _total.toString(),
          }
        },
      );
    } else {
      DefaultSnackBar.show(context, requiredFields);
    }
  }

  @override
  void initState() {
    super.initState();
    _initBillItem();
  }

  @override
  Widget build(BuildContext context) {
    _subtotal = calculateSubtotal(_billItems);
    _total = calculateTotal(
      _billItems,
      service: _serviceCtrl.text,
      tax: _taxCtrl.text,
    );

    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Split Bill',
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
            DefaultDateTimePicker(dateTimeCtrl: _dateTimeCtrl),
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
                  _subtotal.toString(),
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
                  _total.toString(),
                ),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: bold,
                    ),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(height: defaultMargin),
            DefaultButton(
              onPressed: () => _handleConfirmButton(),
              text: 'Confirm',
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
      onPressed: () => _addBillItem(),
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
            if (_billItems.length > 1) _removeItemButton(item),
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

  Widget _removeItemButton(BillItem item) {
    return IconButton(
      onPressed: () => _removeBillItem(item),
      tooltip: 'Remove item',
      enableFeedback: true,
      icon: const Icon(Icons.remove_circle_rounded),
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
        inputFormatters: digitsOnlyCurrencyInputFormatters(),
        onChanged: (value) {
          item.calculateTotalPrice();
          setState(() {});
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Price is required';
          } else if (int.tryParse(digitOnly(value)) == null) {
            return 'Price must be a number';
          } else if (int.tryParse(digitOnly(value))! <= 0) {
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
        inputFormatters: digitsOnlyCurrencyInputFormatters(),
        onChanged: (value) {
          calculateTotal(
            _billItems,
            service: value,
            tax: _taxCtrl.text,
          );
          setState(() {});
        },
        validator: (value) {
          if (value == null || int.tryParse(digitOnly(value)) == null) {
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
        inputFormatters: digitsOnlyCurrencyInputFormatters(),
        onChanged: (value) {
          calculateTotal(
            _billItems,
            service: _serviceCtrl.text,
            tax: value,
          );
          setState(() {});
        },
        validator: (value) {
          if (value == null || int.tryParse(digitOnly(value)) == null) {
            return 'Tax must be a number';
          }
          return null;
        },
      ),
    );
  }
}
