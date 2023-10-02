import 'package:flutter/material.dart';
import 'package:split_bill/pages/bill/widgets/bill_item.dart';
import 'package:split_bill/pages/bill/widgets/friend_avatar.dart';
import 'package:split_bill/pages/bill/widgets/friend_circle_avatar.dart';
import 'package:split_bill/utils/constants/constants.dart';
import 'package:split_bill/utils/functions/functions.dart';
import 'package:split_bill/widgets/default_app_bar.dart';
import 'package:split_bill/widgets/default_list_tile.dart';

class AddItemPage extends StatefulWidget {
  final Map summary;
  final List<FriendAvatar> friends;
  const AddItemPage({
    Key? key,
    required this.summary,
    required this.friends,
  }) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final List<FriendCircleAvatar> _friends = [];
  late Map _summary;
  late List<BillItem> _billItems;

  void _initFriendAvatars() {
    _friends.clear();
    _friends.add(
      const FriendCircleAvatar(
        name: 'You',
        isFriend: false,
      ),
    );
    _friends.addAll(
      widget.friends.map(
        (e) => FriendCircleAvatar(
          name: e.nameCtrl.text,
          isFriend: false,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initFriendAvatars();
    _summary = widget.summary;
    _billItems = _summary['items'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Add Item',
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: defaultMargin),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _assignInfo(),
              SizedBox(height: defaultMargin),
              _avatars(),
              SizedBox(height: defaultMargin * 2),
              _billItemsContent(),
              SizedBox(height: defaultMargin * 2),
              _summaryContent(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _assignInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Text(
        'Assign items after tapping a friend',
        style: TextStyle(
          color: greyColor,
          fontSize: caption1FS,
        ),
        textScaleFactor: 1.0,
      ),
    );
  }

  Widget _avatars() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          children: _friends
              .map((friend) => Padding(
                    padding: EdgeInsets.only(right: defaultMargin / 2),
                    child: friend,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _billItemsContent() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      separatorBuilder: (context, index) => Divider(
        height: defaultMargin * 2,
      ),
      itemCount: _billItems.length,
      itemBuilder: (context, i) {
        final BillItem item = _billItems[i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.nameCtrl.text,
              style: TextStyle(
                fontSize: bodyFS,
              ),
              textScaleFactor: 1.0,
            ),
            SizedBox(height: defaultMargin / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.priceCtrl.text,
                  textScaleFactor: 1.0,
                ),
                Text(
                  'x${item.qtyCtrl.text}',
                  textScaleFactor: 1.0,
                ),
                Text(
                  moneyFormatter(item.totalPriceCtrl.text),
                  textScaleFactor: 1.0,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _listTileContent({
    required String title,
    String? trailing,
    bool isBold = false,
  }) {
    return DefaultListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: semiBold,
        ),
        textScaleFactor: 1.0,
      ),
      trailing: Text(
        trailing ?? '',
        style: isBold
            ? TextStyle(
                fontSize: bodyFS,
                fontWeight: bold,
              )
            : null,
        textScaleFactor: 1.0,
      ),
    );
  }

  Widget _summaryContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          _listTileContent(
            title: 'Subtotal',
            trailing: moneyFormatter(_summary['subtotal']),
          ),
          _listTileContent(
            title: 'Service',
            trailing: moneyFormatter(_summary['service']),
          ),
          _listTileContent(
            title: 'Tax',
            trailing: moneyFormatter(_summary['tax']),
          ),
          _listTileContent(
            title: 'Total',
            trailing: moneyFormatter(_summary['total']),
            isBold: true,
          ),
        ],
      ),
    );
  }
}
