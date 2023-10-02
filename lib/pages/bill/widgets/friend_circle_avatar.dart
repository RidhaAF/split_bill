import 'package:flutter/material.dart';
import 'package:split_bill/pages/bill/widgets/friend_avatar.dart';
import 'package:split_bill/utils/constants/constants.dart';

class FriendCircleAvatar extends StatelessWidget {
  final FriendAvatar? friend;
  final Widget? child;
  final String? name;
  final bool isFriend;
  const FriendCircleAvatar({
    Key? key,
    this.friend,
    this.child,
    this.name,
    this.isFriend = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _friendAvatar();
  }

  Widget _friendAvatar() {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          child: child ?? const Icon(Icons.person_rounded),
        ),
        SizedBox(height: defaultMargin / 4),
        isFriend
            ? SizedBox(
                width: 48,
                child: _friendNameForm(friend ?? FriendAvatar()),
              )
            : Text(
                name ?? 'You',
                textScaleFactor: 1.0,
              ),
      ],
    );
  }

  Widget _friendNameForm(FriendAvatar friend) {
    return TextFormField(
      controller: friend.nameCtrl,
      focusNode: friend.nameFocus,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
      style: TextStyle(
        fontSize: subheadlineFS,
      ),
      textAlign: TextAlign.center,
      autofocus: true,
      cursorHeight: 16,
      scrollPadding: EdgeInsets.zero,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name...';
        }
        return null;
      },
    );
  }
}
