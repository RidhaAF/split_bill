import 'package:flutter/material.dart';
import 'package:split_bill/utils/functions/functions.dart';

class BillItem {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController qtyCtrl = TextEditingController(text: '1');
  TextEditingController totalPriceCtrl = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode qtyFocus = FocusNode();
  FocusNode totalPriceFocus = FocusNode();

  int calculateTotalPrice() {
    int price = int.tryParse(digitOnly(priceCtrl.text)) ?? 0;
    int qty = int.tryParse(digitOnly(qtyCtrl.text)) ?? 1;
    int total = price * qty;
    totalPriceCtrl.text = total.toString();

    return total;
  }
}
