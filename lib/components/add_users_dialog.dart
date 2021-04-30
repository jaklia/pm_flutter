import 'package:flutter/material.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/components/form_dialog.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/models/user.dart';

class AddUsersDialog extends StatefulWidget {
  final List<User> users;
  final Function onSubmit;

  AddUsersDialog({this.users, this.onSubmit});

  @override
  _AddUsersDialogState createState() => _AddUsersDialogState();
}

class _AddUsersDialogState extends State<AddUsersDialog> {
  Map<int, bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Map<int, bool>.fromIterable(
      widget.users,
      key: (user) => user.id,
      value: (user) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Résztvevők hozzáadása',
      children: widget.users
          .map(
            (user) => listItem(user),
          )
          .toList(),
      onSubmit: onSubmit,
      cancelText: AppLocalizations.of(context).translate(Strings.cancel),
      submitText: 'Hozzáadás',
      onCancel: close,
      onClose: close,
    );
  }

  Widget listItem(User user) {
    return CheckboxListTile(
      value: _selected[user.id],
      onChanged: (a) => selectUser(user, a),
      title: Text(user.name),
    );
  }

  void selectUser(User user, bool s) {
    setState(() {
      _selected[user.id] = s;
    });
  }

  void onSubmit() {
    List<User> selectedUsers = [];
    for (var user in widget.users) {
      if (_selected[user.id]) {
        selectedUsers.add(user);
      }
    }
    widget.onSubmit(selectedUsers);
    close();
  }

  void close() {
    Navigator.of(context).pop();
  }
}
