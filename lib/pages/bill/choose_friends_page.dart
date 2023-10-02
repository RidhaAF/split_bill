import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_bill/pages/bill/widgets/friend_avatar.dart';
import 'package:split_bill/pages/bill/widgets/friend_circle_avatar.dart';
import 'package:split_bill/utils/constants/constants.dart';
import 'package:split_bill/utils/constants/strings.dart';
import 'package:split_bill/widgets/default_app_bar.dart';
import 'package:split_bill/widgets/default_button.dart';
import 'package:split_bill/widgets/default_snack_bar.dart';

class ChooseFriendsPage extends StatefulWidget {
  final Map summary;
  const ChooseFriendsPage({
    Key? key,
    required this.summary,
  }) : super(key: key);

  @override
  State<ChooseFriendsPage> createState() => _ChooseFriendsPageState();
}

class _ChooseFriendsPageState extends State<ChooseFriendsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<FriendAvatar> _friends = [];

  void _addFriend() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _friends.add(FriendAvatar());
        _friends.last.nameFocus.requestFocus();
      });
    } else {
      DefaultSnackBar.show(context, 'Please fill the name first');
    }
  }

  void _removeFriend(FriendAvatar friend) {
    setState(() {
      _friends.remove(friend);
    });
  }

  void _handleAddButton() {
    if (_friends.isEmpty) {
      DefaultSnackBar.show(context, 'Please add at least one friend');
    } else if (_formKey.currentState!.validate()) {
      context.push(
        '/bill/add-item',
        extra: {
          'summary': widget.summary,
          'friends': _friends,
        },
      );
    } else {
      DefaultSnackBar.show(context, requiredFields);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Choose Friends',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(defaultMargin),
                children: [
                  _myAvatar(),
                  SizedBox(width: defaultMargin / 2),
                  _friendAvatars(),
                  _addFriendButton(),
                ],
              ),
            ),
            _addButton(),
          ],
        ),
      ),
    );
  }

  Widget _myAvatar() {
    return const FriendCircleAvatar(
      name: 'You',
      isFriend: false,
    );
  }

  Widget _friendAvatars() {
    return Row(
      children: _friends
          .map(
            (friend) => Padding(
              padding: EdgeInsets.only(right: defaultMargin / 2),
              child: Stack(
                children: [
                  FriendCircleAvatar(friend: friend),
                  _closeButton(friend: friend),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _closeButton({required FriendAvatar friend}) {
    return Positioned(
      top: 0,
      right: 0,
      child: InkWell(
        onTap: () => _removeFriend(friend),
        child: _closeIcon(),
      ),
    );
  }

  Widget _closeIcon() {
    return Container(
      decoration: BoxDecoration(
        color: mutedColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.close_rounded,
        size: 16,
        color: primaryColor,
      ),
    );
  }

  Widget _addFriendButton() {
    return GestureDetector(
      onTap: () => _addFriend(),
      child: const FriendCircleAvatar(
        name: 'Add',
        isFriend: false,
        child: Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _addButton() {
    return Padding(
      padding: EdgeInsets.all(defaultMargin),
      child: DefaultButton(
        onPressed: () => _handleAddButton(),
        text: 'Add(${_friends.length})',
      ),
    );
  }
}
